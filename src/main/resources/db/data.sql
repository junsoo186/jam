insert into user_tb (nick_name, phone_number, email, password)
values( '박정훈', '010-1234-5678', 'test@test.com', '1234');

insert into user_tb (nick_name, phone_number, email, password)
values( '정해주', '010-4548-5678', 'test@naver.com', '1234');

insert into user_tb (nick_name, phone_number, email, password, role)
values( '정해주1', '010-4548-5678', 'test@naver.com', '1234', 'admin');

<<<<<<< HEAD
insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('관리자테스트','20240527', 'F', '@@시 @@구', '관리자테스트2', '010-7777-7777', 'manager2@test.com', '1234', 'staff');



insert into staff_tb(staff_name,staff_password)values
('a1' , '0000'),
('a2' , '0000');

insert into notice_tb (staff_id, notice_title, notice_content, comment, created_at) values 
(1, '공지사항 제목 1', '공지사항 내용 1입니다.', '첫 번째 공지에 대한 코멘트입니다.', NOW()),
(2, '공지사항 제목 2', '공지사항 내용 2입니다.', '두 번째 공지에 대한 코멘트입니다.', NOW()),
(1, '공지사항 제목 3', '공지사항 내용 3입니다.', '세 번째 공지에 대한 코멘트입니다.', NOW()),
(2, '공지사항 제목 4', '공지사항 내용 4입니다.', '네 번째 공지에 대한 코멘트입니다.', NOW()),
(1, '공지사항 제목 5', '공지사항 내용 5입니다.', '다섯 번째 공지에 대한 코멘트입니다.', NOW());
<<<<<<< HEAD
insert into qna_tb (user_id, title, question_content, created_at) values 
(1, '질문1', '제이름은 명기입니다.', NOW()),
(2, '질문2', '제이름은 명기입니다..', NOW()),
(1, '질문3', '제이름은 명기입니다.', NOW()),
(2, '질문4', '제이름은 명기입니다..', NOW()),
(1, '질문5', '제이름은 명기입니다..', NOW());
=======
>>>>>>> 54a9cbb990a4d50d74ee46af7812093f0305181c

=======
insert into user_tb (nick_name, phone_number, email, password, role)
values( '관리자박정훈', '010-4548-5678', 'test@naver.com', '1234', 'admin');
>>>>>>> 0ff68240bb409579f0bcb01400ab722a49cddab0
