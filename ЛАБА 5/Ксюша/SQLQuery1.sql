USE chess

--ИГРОК, ИНФОРМАЦИЯ, СТРАНА И СРЕДНИЙ РЕЙТИНГ
IF OBJECT_ID ('Pl_all') IS NOT NULL
	DROP VIEW Pl_all;
go
CREATE VIEW Pl_all as 
SELECT P.player_id, first_name, last_name, avg(rating) as avg_rating, country
FROM Players AS P left JOIN Rating as R ON P.player_id=R.player_id left join country as C on C.country_id=P.country_id
GROUP BY P.player_id, first_name, last_name, country

GO
Select first_name, last_name, country,avg_rating, max(rating) as [max]
FROM Pl_all left join Rating on Rating.player_id=Pl_all.player_id
GROUP BY Rating.player_id, first_name, last_name, country,avg_rating
ORDER BY avg_rating desc
--------------------------------------------------------------------------------------------------------------------
--страна, колво игроков из нее, средний рейтинг

IF OBJECT_ID ('С_all') IS NOT NULL
	DROP VIEW С_all;
go
CREATE VIEW С_all as 
SELECT country, count(player_id) as nom,sum(su)/sum(la) as avg_rating
FROM (SELECT P.player_id, sum(rating) as su, count(rating) as la, country
FROM Players AS P left JOIN Rating as R ON P.player_id=R.player_id left join country as C on C.country_id=P.country_id
GROUP BY P.player_id, first_name, last_name, country) as Meow
GROUP BY country

GO
Select *
FROM С_all
ORDER BY avg_rating desc

--------------------------------------------------------------------------------------------------------------
---преподаватель, количество учеников, средний рейтинг
IF OBJECT_ID ('Pl_sta') IS NOT NULL
	DROP VIEW Pl_sta;
go 

With Pl_sta as 
(SELECT M.teacher_id,T.first_name,T.last_name, count(la) as nom, sum(su)/sum(la) as avg_rating, max(ma) as [max],min(mi) as [min]
FROM (SELECT P.player_id, sum(rating) as su, count(rating) as la, max(rating) as ma, min(rating) as mi
FROM Players AS P left JOIN Rating as R ON P.player_id=R.player_id 
left join country as C on C.country_id=P.country_id
GROUP BY P.player_id, first_name, last_name, country) as Meow 
right join Mentoring M on M.player_id=Meow.player_id 
left join Teachers T on T.teacher_id=M.teacher_id 
GROUP BY M.teacher_id,T.first_name,T.last_name
)

Select *, [max]-[min] as delta
FROM Pl_sta
ORDER BY delta desc

--------------------------------------------------------------------------------------------------------------------
--- 
IF OBJECT_ID ('Stat') IS NOT NULL
	DROP VIEW Stat;
go
CREATE VIEW Stat AS
SELECT W.player_id, win, draw, lose
FROM
(SELECT player_id, count(result) as win
FROM Game_result
WHERE result=1
GROUP BY player_id) W left join
(SELECT player_id, count(result) as draw
FROM Game_result
WHERE result=0
GROUP BY player_id) D on W.player_id=D.player_id left join
(SELECT player_id, count(result) as lose
FROM Game_result
WHERE result=-1
GROUP BY player_id) L on L.player_id=D.player_id


go
SELECT first_name,last_name, win, draw, lose
FROM Stat 
join Players on Stat.player_id=Players.player_id
ORDER BY draw desc