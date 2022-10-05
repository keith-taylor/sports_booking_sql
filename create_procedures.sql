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
in p_booked_time time, in p_member_id varchar(21)
	begin
		declare v_price decimal(6,2), v_payment_due decimal(6,2);
		select price into v_price from rooms where room_id	= p_room_id;
        
 
    
delimiter ;