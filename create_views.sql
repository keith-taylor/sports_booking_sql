create view room_booking_details as
select booking_id, rooms.room_id, room_type, booked_date, booked_time, member_id, datetime_of_booking, 
price, payment_status
from bookings join rooms
on bookings.room_id = rooms.room_id
order by booking_id;  

select * from room_booking_details;