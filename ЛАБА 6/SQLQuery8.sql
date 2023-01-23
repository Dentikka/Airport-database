use airport2;

 SELECT d.flight_id, d.sold_tickets
           FROM flight d
           WHERE flight_id = 17

          SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
           BEGIN TRANSACTION
           UPDATE flight SET sold_tickets = sold_tickets + 1 WHERE flight_id = 17
           COMMIT;
           go
            SELECT d.flight_id, d.sold_tickets
          FROM flight d
          WHERE flight_id = 17;