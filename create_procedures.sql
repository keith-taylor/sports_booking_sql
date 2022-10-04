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