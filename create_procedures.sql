delimiter $$

CREATE PROCEDURE insert_member(in p_member_id VARCHAR(21), in p_password VARCHAR(255) 
in p_email VARCHAR(255))
BEGIN
	insert into members (member_id, password, email)
	values (p_member_id, p_password, p_email);
END $$

CREATE PROCEDURE delete_member(in p_member_id VARCHAR(21))
begin
	delete from members where member_id = p_member_id;
end $$

CREATE PROCEDURE update_member_password(in p_member_id VARCHAR(21), in p_password VARCHAR(255))
begin 
	update members set password = p_password where p_member_id = members.member_id; 
end $$ 

CREATE PROCEDURE update_member_email(in p_member_id VARCHAR(21), in p_email VARCHAR(255))
begin 
	update members set email = p_email where p_member_id = members.member_id; 
end $$ 

CREATE PROCEDURE make_booking(in p_room_id varchar(255), in p_booked_date date, 
in p_booked_time time, in p_member_id varchar(21))
begin
	declare v_price decimal(6,2);
	declare v_payment_due decimal(6,2);
	select price into v_price from rooms where room_id	= p_room_id;
	insert into bookings (room_id, booked_date, booked_time, member_id)
	values (p_room_id, p_booked_date, p_booked_time, p_member_id);
	select payment_due into v_payment_due from members where member_id = p_member_id;
	update members set payment_due = v_payment_due + v_price where member_id = p_member_id;
end $$
    
CREATE PROCEDURE update_payment (in p_booking_id int)
begin
	declare v_member_id varchar(21); 
	declare v_payment_due decimal(6,2);
	declare v_price decimal(6,2);
	update bookings set payment_status = "Paid" where booking_id = p_booking_id;  
	select member_id, price into v_member_id, v_price from member_bookings where booking_id = p_booking_id;
	select payment_due into v_payment_due from members where member_id = v_member_id;
	update members set payment_due = 
		v_payment_due - v_price where member_id = v_member_id; 
end $$
 
CREATE PROCEDURE view_bookings (in p_member_id varchar(21))
begin 
	select * from member_bookings where member_id = p_member_id;
end $$
   
CREATE PROCEDURE search_for_room (in p_room_type varchar(255), in p_booked_date date, in p_booked_time time)
begin
	SELECT * FROM rooms WHERE room_id NOT IN 
	(SELECT room_id FROM bookings WHERE booked_date = p_booked_date AND 
	booked_time = p_booked_time AND payment_status != 'Cancelled') 
	AND room_type = p_room_type; 
end $$ 
drop procedure if exists cancel_booking$$
CREATE PROCEDURE cancel_booking(in p_booking_id int, out p_message varchar(255))
begin
	declare v_cancellation int;
	declare v_member_id varchar(21);
	declare v_payment_status varchar(255);
	declare v_booked_date date;
	declare v_price decimal(6,2);
	declare v_payment_due decimal(6,2);
	
	set v_cancellation = 0;
	
	select member_id, booked_date , price, payment_status into
		v_member_id, v_booked_date , v_price, v_payment_status
			from member_bookings where booking_id = p_booking_id;
	
	select payment_due into v_payment_due from members 
		where member_id = v_member_id;
	
	if curdate() >= v_booked_date then
	select 'Cancellation cannot be done on/after the booked date. ' into p_message;
			elseif v_payment_status = 'Cancelled' 
			OR v_payment_status = 'Paid' then
			select 'Booking has already been cancelled or paid. ' into p_message;
					else 
					update bookings set payment_status = 'Cancelled' where p_booking_id = booking_id;
					set v_payment_due = v_payment_due - v_price;
					set v_cancellation = check_cancellation(p_booking_id);
						if v_cancellation >= 2 then set
						v_payment_due = v_payment_due + 10;
						end if;
					update members set payment_due = v_payment_due where member_id = v_member_id; 
					select 'Booking cancelled. ' into p_message;
	end if;
end $$
        
CREATE TRIGGER payment_check before delete on members for each row 
begin
	declare v_payment_due decimal(6,2); 
	select payment_due into v_payment_due from members where member_id = old.member_id; 
	if v_payment_due > 0 then
		insert into pending_terminations (member_id, email, payment_due)
		values (old.member_id, old.email, old.payment_due);
	end if; 
end $$ 

CREATE FUNCTION check_cancellation (p_booking_id int) returns int deterministic
begin
	declare v_done int;
    declare v_cancellation int;
    declare v_current_payment_status varchar(255);
    declare cur cursor for 
    select payment_status from bookings 
    where member_id = 
		(select member_id from bookings where booking_id = p_booking_id)
        order by datetime_of_booking DESC;
    declare continue handler for not found set v_done = 1;
	set v_cancellation = 0;
    set v_done = 0 ;
    
    open cur;
	cancellation_loop: loop
    fetch cur into v_current_payment_status;
		if
			v_current_payment_status != "Cancelled" OR v_done = 1 
			then leave cancellation_loop;
        else
			set v_cancellation = v_cancellation + 1;
		end if;
    end loop;
    close cur;
    RETURN v_cancellation; 
end $$

delimiter ;
