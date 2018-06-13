DROP TABLE Pilot CASCADE;
DROP TABLE Flight CASCADE;
DROP TABLE Schedule CASCADE;
DROP TABLE Reservation CASCADE;
DROP TABLE Waitlisted CASCADE;
DROP TABLE Confirmed CASCADE;
DROP TABLE Reserved CASCADE;
DROP TABLE Customer CASCADE;
DROP TABLE Plane CASCADE;
DROP TABLE Technician CASCADE;
DROP TABLE has1 CASCADE;
DROP TABLE repair_request CASCADE;
DROP TABLE uses CASCADE;
DROP TABLE has CASCADE;
DROP TABLE repairs CASCADE;

CREATE TABLE Pilot(
ID INTEGER,
name CHAR(32) NOT NULL,
nationality CHAR(32) NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(ID) REFERENCES uses(ID1) ON DELETE NO ACTION);

CREATE TABLE Flight(
flight_num INTEGER,
cost INTEGER,
num_sold INTEGER,
num_stops INTEGER,
actual_arrive_date CHAR(32),
actual_arrive_time CHAR(32),
actual_depart_date CHAR(32),
actual_depart_time CHAR(32),
source CHAR(32) NOT NULL,
destination CHAR(32) NOT NULL,
ID INTEGER,
PRIMARY KEY(flight_num),
FOREIGN KEY(ID) REFERENCES Pilot(ID) ON DELETE NO ACTION,
FOREIGN KEY(flight_num) REFERENCES has1(flight_num1) ON DELETE NO ACTION,
FOREIGN KEY(flight_num) REFERENCES has(flight_num) ON DELETE NO ACTION);

CREATE TABLE Schedule(
flight_num INTEGER,
day CHAR(32) NOT NULL,
depart_time CHAR(32),
arrive_time CHAR(32),
PRIMARY KEY(flight_num),
FOREIGN KEY(flight_num) REFERENCES Flight(flight_num) ON DELETE CASCADE);

CREATE TABLE Reservation(
Rnum INTEGER,
PRIMARY KEY(Rnum) );

CREATE TABLE Waitlisted(
Rnum INTEGER REFERENCES Reservation(Rnum),
PRIMARY KEY(Rnum) );

CREATE TABLE Confirmed(
Rnum INTEGER REFERENCES Reservation(Rnum),
PRIMARY KEY(Rnum) );

CREATE TABLE Reserved(
Rnum INTEGER REFERENCES Reservation(Rnum),
PRIMARY KEY(Rnum) );

CREATE TABLE Customer(
ID INTEGER,
first_name CHAR(32),
last_name CHAR(32),
gender CHAR(32),
date_of_birth CHAR(8),
address CHAR(32),
contact_num CHAR(32),
ZIP_code INTEGER,
PRIMARY KEY(ID) );

CREATE TABLE Plane(
ID INTEGER,
model CHAR(32) NOT NULL,
make CHAR(32) NOT NULL,
age INTEGER,
num_seats INTEGER,
PRIMARY KEY(ID) );

CREATE TABLE Technician(
ID INTEGER,
PRIMARY KEY(ID) );

CREATE TABLE has1(
flight_num1 INTEGER,
flight_num2 INTEGER,
PRIMARY KEY(flight_num1, flight_num2),
FOREIGN KEY(flight_num1) REFERENCES Flight(flight_num),
FOREIGN KEY(flight_num2) REFERENCES Schedule(flight_num) );

CREATE TABLE repair_request(
ID1 INTEGER,
ID2 INTEGER,
ID3 INTEGER,
ID INTEGER,
PRIMARY KEY(ID1, ID2, ID3),
FOREIGN KEY(ID1) REFERENCES Pilot(ID),
FOREIGN KEY(ID2) REFERENCES Plane(ID),
FOREIGN KEY(ID3) REFERENCES Technician(ID) );

CREATE TABLE uses(
flight_num INTEGER,
ID1 INTEGER,
ID2 INTEGER,
PRIMARY KEY(flight_num, ID1, ID2),
FOREIGN KEY(flight_num) REFERENCES Flight(flight_num),
FOREIGN KEY(ID1) REFERENCES Pilot(ID),
FOREIGN KEY(ID2) REFERENCES Plane(ID) );

CREATE TABLE has(
flight_num INTEGER,
ID INTEGER,
Rnum INTEGER,
PRIMARY KEY(flight_num, ID, Rnum),
FOREIGN KEY(flight_num) REFERENCES Flight(flight_num),
FOREIGN KEY(ID) REFERENCES Customer(ID),
FOREIGN KEY(Rnum) REFERENCES Reservation(Rnum) );

CREATE TABLE repairs(
ID1 INTEGER,
ID2 INTEGER,
ID3 INTEGER,
date CHAR(8) NOT NULL,
code CHAR(32),
PRIMARY KEY(ID1, ID2),
FOREIGN KEY(ID1) REFERENCES Plane(ID),
FOREIGN KEY(ID2) REFERENCES Technician(ID),
FOREIGN KEY(ID3) REFERENCES Pilot(ID) ON DELETE NO ACTION);