insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('이름테스트','20240827', 'M', '부산시 @@구', '닉네임테스트', '010-1234-5678', 'test@test.com', '1234', 'user');

insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('이름테스트2','20240727', 'F', '부산시 @@구', '닉네임테스트2', '010-1111-2222', 'test2@test.com', '1234', 'user');

-- 관리자 유저 생성
insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('관리자테스트','20240527', 'M', '@@시 @@구', '관리자테스트', '010-5555-5555', 'manager@test.com', '1234', 'staff');

insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('관리자테스트','20240527', 'F', '@@시 @@구', '관리자테스트2', '010-7777-7777', 'manager2@test.com', '1234', 'staff');

insert into notice_tb (notice_id, staff_id, notice_title, notice_content, comment, created_at) values 
(1, 101, '공지사항 제목 1', '공지사항 내용 1입니다.', '첫 번째 공지에 대한 코멘트입니다.', NOW()),
(2, 102, '공지사항 제목 2', '공지사항 내용 2입니다.', '두 번째 공지에 대한 코멘트입니다.', NOW()),
(3, 103, '공지사항 제목 3', '공지사항 내용 3입니다.', '세 번째 공지에 대한 코멘트입니다.', NOW()),
(4, 104, '공지사항 제목 4', '공지사항 내용 4입니다.', '네 번째 공지에 대한 코멘트입니다.', NOW()),
(5, 105, '공지사항 제목 5', '공지사항 내용 5입니다.', '다섯 번째 공지에 대한 코멘트입니다.', NOW());