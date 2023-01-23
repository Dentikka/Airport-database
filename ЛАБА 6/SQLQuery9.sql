use airport2;

 DROP TABLE if exists tmp;

           CREATE TABLE tmp (id int, tmp_value int)
           INSERT INTO tmp VALUES (1,0)
           go
           SELECT * FROM tmp

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
           BEGIN TRANSACTION
           UPDATE tmp SET tmp_value =
                    (SELECT sold_tickets FROM flight WHERE flight_id = 17)
           WHERE id = 1;
           go
           SELECT * FROM tmp
	
          UPDATE flight SET sold_tickets = (SELECT tmp_value FROM tmp WHERE id = 1)
          WHERE flight_id = 17
          COMMIT;

          SELECT d.flight_id, d.sold_tickets
          FROM flight d
          WHERE flight_id = 17;


	select @@trancount as 'количество транзакций';