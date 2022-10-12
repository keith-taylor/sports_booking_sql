create view member_bookings as
select booking_id, rooms.room_id, room_type, booked_date, booked_time, member_id, datetime_of_booking, 
price, payment_status
from bookings join rooms
on bookings.room_id = rooms.room_id
order by booking_id;  