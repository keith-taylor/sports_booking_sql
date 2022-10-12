create database sports_booking;

create table members (
	member_id varchar(21) primary key,
    password varchar(255) not null,
    email varchar(255) not null,
    member_since timestamp default now() not null,
    payment_due decimal(6,2) not null default 0 
    );

create table pending_terminations (
	id varchar(10) primary key,
    email varchar(255) not null,
    request_date timestamp not null default now(),
    payments_due decimal(6,2) not null default 0
    ); 

create table rooms (
room_id varchar(255) primary key, 
room_type varchar(255) not null,
price decimal (6,2) not null 
);

create table bookings (
booking_id int auto_increment primary key, 
room_id varchar(255) not null,
booked_date date not null,
booked_time time not null,
member_id varchar(21) not null,
datetime_of_booking timestamp default now() not null,
payment_status varchar(255) not null default 'unpaid',
constraint uc1 unique (room_id, booked_date, booked_time)
); 

alter table bookings 
add constraint fk1 
	foreign key (member_id) references members(member_id) 
    on delete cascade on update cascade,
add constraint fk2 
	foreign key (room_id) references rooms(room_id) 
    on delete cascade on update cascade;