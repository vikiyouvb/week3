CREATE TABLE trains
(
	train_no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	train_name VARCHAR(100) NOT NULL
);

CREATE TABLE stations
(
	station_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	station_code VARCHAR(25) NOT NULL
);

CREATE TABLE users
(
	user_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	login_id VARCHAR(100) NOT NULL,
	login_password VARCHAR(100) NOT NULL
);
 
CREATE TABLE coaches
(
	coach_code INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	cost_per_km DEC(4,2) NOT NULL
);

CREATE TABLE train_coaches
(
	train_no INT NOT NULL,
	coach_code INT NOT NULL,
	no_of_seats INT NOT NULL,
	CONSTRAINT trains_train_no_fk FOREIGN KEY(train_no) REFERENCES trains(train_no),
	CONSTRAINT coaches_coach_code_fk FOREIGN KEY(coach_code) REFERENCES coaches(coach_code)
);

CREATE TABLE routes
(
	route_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	origin_station_id INT NOT NULL,
	destination_station_id INT NOT NULL,
	distance_in_kms DEC(6,1) NOT NULL,
	CONSTRAINT stations_station_id_origin_fk FOREIGN KEY(origin_station_id) REFERENCES stations(station_id),
	CONSTRAINT stations_station_id_dest_fk FOREIGN KEY(destination_station_id) REFERENCES stations(station_id)
);

CREATE TABLE train_route_maps
(
	route_id INT NOT NULL,
	train_no INT NOT NULL,
	arrival_time TIME NOT NULL,
	departure_time TIME NOT NULL,
	duration_in_mins INT NOT NULL,
	PRIMARY KEY(route_id,train_no)
);

CREATE TABLE bookings
(
	booking_ref_no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	route_id INT NOT NULL,
	train_no INT NOT NULL,
	coach_code INT NOT NULL,
	date_of_journey DATE NOT NULL,
	date_of_booking DATE NOT NULL,
	no_of_tickets INT NOT NULL,
	CONSTRAINT trains_train_no_bookings_fk FOREIGN KEY(train_no) REFERENCES trains(train_no),
	CONSTRAINT routes_route_id_bookings_fk FOREIGN KEY(route_id) REFERENCES routes(route_id),
	CONSTRAINT coaches_coach_code_bookings_fk FOREIGN KEY(coach_code) REFERENCES coaches(coach_code)
);