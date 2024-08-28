insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)

values('이름테스트','20240827', 'M', '부산시 @@구', '닉네임테스트', '010-1234-5678', 'test@test.com', '1234', 'user');

insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('이름테스트2','20240727', 'F', '부산시 @@구', '닉네임테스트2', '010-1111-2222', 'test2@test.com', '1234', 'user');

-- 관리자 유저 생성
insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('관리자테스트','20240527', 'M', '@@시 @@구', '관리자테스트', '010-5555-5555', 'manager@test.com', '1234', 'staff');

insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('관리자테스트','20240527', 'F', '@@시 @@구', '관리자테스트2', '010-7777-7777', 'manager2@test.com', '1234', 'staff');


insert into book_tb (user_id,title,author_comment,author,
            introduction,age) 
            values(1,'테스트하기1','줄거리테스트1','작가테스트1','소개글1','19');
insert into book_tb (user_id,title,author_comment,author,
			introduction,age) 
			values(2,'테스트하기2','줄거리테스트2','작가테스트2','소개글2','15');
            