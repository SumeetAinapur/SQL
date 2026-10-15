CREATE DATABASE IF NOT EXISTS HotelBookingDB;
USE HotelBookingDB;

CREATE TABLE IF NOT EXISTS Hotels(
hotel_id INT PRIMARY KEY auto_increment,
hotel_name VARCHAR(50) Not Null,
city VARCHAR(30) Not Null,
star_rating int);

Create table if not exists Rooms(
room_id int primary key auto_increment,
hotel_id int not null,
room_number varchar(10) not null,
room_type varchar(10) not null,
price decimal(10,2) not null,
status Varchar(20) default 'Available',
foreign key (hotel_id)
references Hotels(hotel_id),
Unique (hotel_id, room_number)
);


create table if not exists Guests (
guest_id int primary key auto_increment,
guest_name varchar(50) not null,
phone varchar(15),
city varchar(30)
);

create table if not exists Bookings (
booking_id int primary key auto_increment,
guest_id int not null,
room_id int not null,
check_in date not null,
check_out date not null,
booking_status varchar(20) default 'Booked',
foreign key (guest_id)
references Guests(guest_id),
foreign key (room_id)
references Rooms(room_id)
);

create table if not exists Payments(
payment_id int primary key auto_increment,
booking_id int not null,
amount decimal(10,2) not null,
payment_status varchar(20) not null,
foreign key (booking_id)
references Bookings(booking_id),
unique (booking_id)
);

insert into Hotels (hotel_name, city, star_rating)
values
('Grand Palace', 'Channie', 5),
('Royal Inn', 'Banglore',4),
('Blue Moon','Hyderabad',3);

Insert into Rooms(hotel_id,room_number,room_type,price,status)
values
(1, '101','Standard',2500,'Available'),
(1,'102','Duplex',4000,'Occupied'),
(1,'103','Suite',7000,'Occupied'),
(2,'201','Standard',2200,'Available'),
(2,'202','Duplex',3800,'Occupied'),
(3,'301','Standard',1800,'Available'),
(3,'302','Suite',6000,'Occupied');

INSERT INTO Guests (guest_name, phone, city)
VALUES
('Rahul', '9876543210', 'Chennai'),
('Priya', '9876543211', 'Bangalore'),
('Arun', '9876543212', 'Hyderabad'),
('Sneha', '9876543213', 'Coimbatore'),
('Karthik', '9876543214', 'Mumbai');

Insert into Bookings(guest_id,room_id,check_in,check_out,booking_status)
values
(1,2,'2026-07-25','2026-07-30','Completed'),
(2,3,'2026-07-28','2026-02-02','Active'),
(3,5,'2026-07-29','2026-08-01','Active'),
(4,7,'2026-07-20','2026-07-22','Completed'),
(1,1,'2026-08-05','2026-08-08','Booked'),
 (5,4,'2026-07-31','2026-08-03','Cancelled');
 
 Insert into Payments (booking_id,amount,payment_status)
 values
 (1,20000.00,'Paid'),
 (2,50000.00,'Paid'),
 (3,12000.00,'Pending'),
 (4,15000.00,'Paid'),
 (5,7500.00,'Pending'),
 (6,0.00,'Refunded');


USE HotelBookingDB;

SELECT * FROM Hotels;
SELECT * FROM Rooms;
SELECT * FROM Guests;
SELECT * FROM Bookings;
SELECT * FROM Payments;

SELECT h.hotel_name, h.city, r.room_number, r.room_type, r.price FROM Hotels h INNER JOIN Rooms r ON h.hotel_id = r.hotel_id WHERE r.status = 'Available';

SELECT SUM(amount) AS Total_Revenue FROM Payments WHERE payment_status = 'Paid';