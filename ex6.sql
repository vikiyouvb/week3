--1
SELECT trains.name FROM trains;

--2
SELECT trains.train_name,org.station_code,dest.station_code,route_maps.arrival_time,route_maps.departure_time,route_maps.duration_in_mins FROM trains NATURAL JOIN train_route_maps route_maps NATURAL JOIN routes INNER JOIN stations org ON routes.origin_station_id=org.station_id INNER JOIN stations dest ON routes.destination_station_id=dest.station_id;

--3
SELECT trains.train_name,train_coaches.no_of_seats FROM trains NATURAL JOIN train_coaches;

--4
SELECT trains.train_name,route_maps.arrival_time,route_maps.departure_time,route_maps.duration_in_mins,org.station_code,dest.station_code FROM trains NATURAL JOIN train_route_maps route_maps NATURAL JOIN routes INNER JOIN stations org ON routes.origin_station_id=org.station_id INNER JOIN stations dest ON routes.destination_station_id=dest.station_id WHERE dest.station_code='BANGALORE';

--5
SELECT trains.train_name,route_maps.arrival_time,route_maps.departure_time,route_maps.duration_in_mins,org.station_code,dest.station_code FROM trains NATURAL JOIN train_route_maps route_maps NATURAL JOIN routes INNER JOIN stations org ON routes.origin_station_id=org.station_id INNER JOIN stations dest ON routes.destination_station_id=dest.station_id WHERE org.station_code IN ('BANGALORE','CALCUTTA','CHENNAI');

--6
SELECT trains.train_name,bookings.date_of_journey,bookings.date_of_booking,bookings.no_of_tickets,org.station_code,dest.station_code FROM bookings NATURAL JOIN trains NATURAL JOIN routes INNER JOIN stations org ON routes.origin_station_id=org.station_id INNER JOIN stations dest ON routes.destination_station_id=dest.station_id WHERE bookings.date_of_booking BETWEEN '2005-01-01' AND '2005-12-31';

--7
SELECT trains.train_name FROM trains WHERE trains.train_name LIKE "B%";

--8
SELECT trains.train_name,bookings.date_of_journey,bookings.date_of_booking,bookings.no_of_tickets,org.station_code,dest.station_code FROM bookings NATURAL JOIN trains NATURAL JOIN routes INNER JOIN stations org ON routes.origin_station_id=org.station_id INNER JOIN stations dest ON routes.destination_station_id=dest.station_id WHERE bookings.date_of_booking IS NOT NULL;

--9
SELECT trains.train_name,bookings.date_of_journey,bookings.date_of_booking,bookings.no_of_tickets,org.station_code,dest.station_code FROM bookings NATURAL JOIN trains NATURAL JOIN routes INNER JOIN stations org ON routes.origin_station_id=org.station_id INNER JOIN stations dest ON routes.destination_station_id=dest.station_id WHERE YEAR(bookings.date_of_booking)='2006' AND YEAR(bookings.date_of_journey)='2007';

--10
SELECT trains.train_name,COUNT(train_coaches.coach_code) AS no_of_coaches FROM trains NATURAL JOIN train_coaches GROUP BY trains.train_no;

--11
SELECT trains.train_name,COUNT(bookings.booking_ref_no) AS no_of_bookings FROM trains NATURAL JOIN bookings WHERE trains.train_no=16198;

--12
SELECT trains.train_name,SUM(bookings.no_of_tickets) AS total FROM trains NATURAL JOIN bookings WHERE trains.train_no=14198;