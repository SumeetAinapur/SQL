create database if not exists HotelBookingDB;
use HotelBookingDB;

create table Hotels (
    hotel_id int primary key auto_increment,
    hotel_name varchar(60) not null,
    city varchar(40) not null,
    country varchar(40) not null,
    currency char(3) not null,
    star_rating int,
    check (star_rating between 1 and 5)
);

insert into Hotels (hotel_name, city, country, currency, star_rating)
values
('Maple Crown Lodge', 'Toronto', 'Canada', 'CAD', 4),
('Saffron Dunes Retreat', 'Dubai',
 'United Arab Emirates', 'AED', 5),
('Alpine Ember Resort', 'Zurich', 'Switzerland', 'CHF', 5),
('Velvet Fig Residence', 'Istanbul', 'Turkey', 'TRY', 4),
('Coral Lantern Suites', 'Bangkok', 'Thailand', 'THB', 4);

create table Rooms (
    room_id int primary key auto_increment,
    hotel_id int not null,
    room_number varchar(10) not null,
    room_type varchar(20) not null,
    price decimal(10,2) not null,
    status varchar(20) default 'Available',
    foreign key (hotel_id) references Hotels(hotel_id),
    unique (hotel_id, room_number),
    check (price >= 0),
    check (room_type in ('Standard', 'Deluxe', 'Suite', 'Duplex')),
    check (status in ('Available', 'Occupied', 'Maintenance'))
);

insert into Rooms (hotel_id, room_number, room_type, price, status)
values
(1, 'C101', 'Standard', 145.00, 'Available'),
(1, 'C102', 'Deluxe', 260.00, 'Available'),
(1, 'C103', 'Suite', 430.00, 'Available'),
(2, 'D201', 'Standard', 520.00, 'Available'),
(2, 'D202', 'Deluxe', 890.00, 'Available'),
(2, 'D203', 'Suite', 1450.00, 'Available'),
(3, 'Z301', 'Standard', 210.00, 'Available'),
(3, 'Z302', 'Deluxe', 380.00, 'Available'),
(3, 'Z303', 'Suite', 680.00, 'Available'),
(4, 'I401', 'Standard', 2800.00, 'Available'),
(4, 'I402', 'Duplex', 4900.00, 'Occupied'),
(5, 'B501', 'Standard', 2400.00, 'Available'),
(5, 'B502', 'Deluxe', 3900.00, 'Occupied');

create table Guests (
    guest_id int primary key auto_increment,
    guest_name varchar(50) not null,
    phone varchar(15),
    city varchar(40),
    country varchar(40)
);

insert into Guests (guest_name, phone, city, country)
values
('Aarav Mehta', '9876543210', 'Mumbai', 'India'),
('Maya Thompson', '6475550101', 'Ottawa', 'Canada'),
('Omar Al Nuaimi', '9715550102', 'Abu Dhabi',
 'United Arab Emirates'),
('Elena Fischer', '4155550103', 'Geneva', 'Switzerland'),
('Deniz Kaya', '9055550104', 'Ankara', 'Turkey'),
('Narin Chaiyaporn', '6655550105', 'Chiang Mai', 'Thailand'),
('Isabella Rossi', '3935550106', 'Milan', 'Italy'),
('Sumeet Kulkarni', '9845012345', 'Bengaluru', 'India'),
('Ananya Deshmukh', '9822012345', 'Pune', 'India'),
('Rohan Reddy', '9849012345', 'Hyderabad', 'India'),
('Kavya Nair', '9895012345', 'Kochi', 'India'),
('Aditya Sharma', '9810012345', 'New Delhi', 'India'),
('Sneha Patil', '9766012345', 'Nagpur', 'India'),
('Vikram Singh', '9872012345', 'Jaipur', 'India'),
('Meera Iyer', '9840012345', 'Chennai', 'India');

create table Bookings (
    booking_id int primary key auto_increment,
    guest_id int not null,
    room_id int not null,
    check_in date not null,
    check_out date not null,
    booking_status varchar(20) default 'Booked',
    foreign key (guest_id) references Guests(guest_id),
    foreign key (room_id) references Rooms(room_id),
    check (check_out > check_in),
    check (booking_status in ('Booked', 'Active', 'Completed', 'Cancelled'))
);

insert into Bookings (guest_id, room_id, check_in, check_out, booking_status)
values
(1, 2, '2026-07-25', '2026-07-30', 'Completed'),
(2, 3, '2026-07-28', '2026-08-02', 'Completed'),
(3, 5, '2026-07-29', '2026-08-01', 'Completed'),
(4, 8, '2026-07-20', '2026-07-22', 'Completed'),
(1, 1, '2026-08-05', '2026-08-08', 'Completed'),
(5, 4, '2026-07-31', '2026-08-03', 'Cancelled'),
(6, 11, '2026-10-10', '2026-10-18', 'Active'),
(7, 13, '2026-10-12', '2026-10-17', 'Active'),
(2, 7, '2026-08-10', '2026-08-13', 'Completed'),
(3, 10, '2026-08-15', '2026-08-18', 'Completed'),
(4, 12, '2026-08-20', '2026-08-23', 'Completed'),
(8, 9, '2026-11-05', '2026-11-08', 'Booked'),
(9, 6, '2026-11-10', '2026-11-12', 'Booked'),
(10, 3, '2026-11-15', '2026-11-18', 'Booked'),
(11, 12, '2026-11-20', '2026-11-23', 'Booked'),
(12, 13, '2026-11-25', '2026-11-28', 'Booked');

create table Payments (
    payment_id int primary key auto_increment,
    booking_id int not null,
    amount decimal(10,2) not null,
    payment_status varchar(20) not null,
    foreign key (booking_id) references Bookings(booking_id),
    unique (booking_id),
    check (amount >= 0),
    check (payment_status in ('Paid', 'Pending', 'Refunded'))
);

insert into Payments (booking_id, amount, payment_status)
values
(1, 1300.00, 'Paid'),
(2, 2150.00, 'Paid'),
(3, 2670.00, 'Paid'),
(4, 760.00, 'Paid'),
(5, 435.00, 'Paid'),
(6, 0.00, 'Refunded'),
(7, 39200.00, 'Pending'),
(8, 19500.00, 'Paid'),
(9, 630.00, 'Paid'),
(10, 8400.00, 'Paid'),
(11, 7200.00, 'Pending'),
(12, 2040.00, 'Pending'),
(13, 2900.00, 'Pending'),
(14, 1290.00, 'Pending'),
(15, 7200.00, 'Pending'),
(16, 11700.00, 'Pending');

-- 1. Display Available Rooms
select r.room_number, r.room_type, r.price, h.hotel_name, h.country, h.currency
from Rooms r inner join Hotels h on r.hotel_id = h.hotel_id
where r.status <> 'Maintenance'
and not exists (select 1
from Bookings b
where b.room_id = r.room_id and b.booking_status in ('Booked', 'Active')
and '2026-11-15' < b.check_out and '2026-11-16' > b.check_in);

-- 2. Find Guests Staying Today
select g.guest_name, h.hotel_name, h.country, r.room_number, b.check_in, b.check_out 
from Guests g inner join Bookings b on g.guest_id = b.guest_id inner join Rooms r on b.room_id = r.room_id inner join Hotels h on r.hotel_id = h.hotel_id 
where curdate() >= b.check_in and curdate() < b.check_out and b.booking_status = 'Active';

-- 3. Calculate Total Revenue
select h.currency, sum(p.amount) as Total_Revenue 
from Payments p inner join Bookings b on p.booking_id = b.booking_id inner join Rooms r on b.room_id = r.room_id inner join Hotels h on r.hotel_id = h.hotel_id 
where p.payment_status = 'Paid' group by h.currency order by h.currency;

-- 4. Display Bookings Between Two Dates
select b.booking_id, g.guest_name, h.hotel_name, h.country, b.check_in, b.check_out 
from Bookings b inner join Guests g on b.guest_id = g.guest_id inner join Rooms r on b.room_id = r.room_id inner join Hotels h on r.hotel_id = h.hotel_id 
where b.check_in between '2026-07-25' and '2026-07-31'
and b.booking_status <> 'Cancelled';

-- 5. Find the Most Booked Room Type
select r.room_type, count(*) as Total_Bookings 
from Rooms r inner join Bookings b on r.room_id = b.room_id
where b.booking_status <> 'Cancelled'
group by r.room_type having count(*) = (select max(room_count)
    from (select count(*) as room_count
        from Bookings b inner join Rooms r on b.room_id = r.room_id
        where b.booking_status <> 'Cancelled'
        group by r.room_type) as room_counts
);

-- 6. Calculate Occupancy Rate
select round(count(case when status = 'Occupied' then 1 end) * 100.0 / count(*), 2) as Occupancy_Rate 
from Rooms;

-- 7. Display Cancelled Bookings
select b.booking_id, g.guest_name, h.hotel_name, h.country, r.room_number 
from Bookings b inner join Guests g on b.guest_id = g.guest_id inner join Rooms r on b.room_id = r.room_id inner join Hotels h on r.hotel_id = h.hotel_id 
where b.booking_status = 'Cancelled';

-- 8. Find Customers with Multiple Bookings
select g.guest_name, count(b.booking_id) as Total_Bookings 
from Guests g inner join Bookings b on g.guest_id = b.guest_id 
where b.booking_status <> 'Cancelled' group by g.guest_id, g.guest_name 
having count(b.booking_id) > 1;

-- 9. Display Average Room Price
select h.currency, round(avg(r.price), 2) as Average_Room_Price 
from Rooms r inner join Hotels h on r.hotel_id = h.hotel_id 
group by h.currency order by h.currency;

-- 10. Find Hotels with More Than 2 Rooms
select h.hotel_name, h.country, count(r.room_id) as Total_Rooms 
from Hotels h inner join Rooms r on h.hotel_id = r.hotel_id 
group by h.hotel_id, h.hotel_name, h.country 
having count(r.room_id) > 2;

-- 11. Find the Highest-Paying Guest
select guest_name, currency, total_spent 
from (
    select g.guest_name, h.currency, sum(p.amount) as total_spent, rank() over (
            partition by h.currency order by sum(p.amount) desc) as payment_rank
    from Guests g inner join Bookings b on g.guest_id = b.guest_id
    inner join Rooms r on b.room_id = r.room_id
    inner join Hotels h on r.hotel_id = h.hotel_id
    inner join Payments p on b.booking_id = p.booking_id
    where p.payment_status = 'Paid'
    group by g.guest_id, g.guest_name, h.currency) ranked_guests
where payment_rank = 1;

-- 12. Hotel-Wise Revenue
select h.hotel_name, h.country, h.currency, sum(p.amount) as Revenue 
from Hotels h
inner join Rooms r on h.hotel_id = r.hotel_id
inner join Bookings b on r.room_id = b.room_id
inner join Payments p on b.booking_id = p.booking_id
where p.payment_status = 'Paid'
group by h.hotel_id, h.hotel_name, h.country, h.currency
order by h.country;

-- 13. Most Expensive Room in Each Currency
select hotel_name, country, currency, room_number, room_type, price 
from (
    select h.hotel_name, h.country, h.currency, r.room_number, r.room_type, r.price, rank() over (
            partition by h.currency order by r.price desc) as price_rank
    from Rooms r inner join Hotels h on r.hotel_id = h.hotel_id) ranked_rooms
where price_rank = 1;

-- 14. Guests Who Have Never Made a Booking
select g.guest_id, g.guest_name, g.country 
from Guests g
left join Bookings b on g.guest_id = b.guest_id
where b.booking_id is null;

-- 15. Rank Hotels by Revenue
select hotel_name, country, currency, revenue, rank() over (
        partition by currency
        order by revenue desc
    ) as Revenue_Rank
from (
    select h.hotel_id, h.hotel_name, h.country, h.currency, sum(p.amount) as revenue
	from Hotels h
	inner join Rooms r on h.hotel_id = r.hotel_id
	inner join Bookings b on r.room_id = b.room_id
	inner join Payments p on b.booking_id = p.booking_id
	where p.payment_status = 'Paid'
	group by h.hotel_id, h.hotel_name, h.country, h.currency) hotel_revenue;