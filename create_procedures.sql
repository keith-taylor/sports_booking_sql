delimiter $$

CREATE PROCEDURE insert_member(in p_member_id VARCHAR(21), in p_password VARCHAR(255), 
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
		select members.payment_due into v_payment_due  where member_id = p_member_id;
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
	SELECT * FROM rooms WHERE id NOT IN 
	(SELECT room_id FROM bookings WHERE booked_date = p_booked_date AND 
	booked_time = p_booked_time AND payment_status != 'Cancelled') 
	AND room_type = p_room_type; 
end $$

delimiter ;