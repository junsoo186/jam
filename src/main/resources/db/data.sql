insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)

values('이름테스트','20240827', 'M', '부산시 @@구', '닉네임테스트', '010-1234-5678', 'test@test.com', '1234', 'user');

insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('이름테스트2','20240727', 'F', '부산시 @@구', '닉네임테스트2', '010-1111-2222', 'test2@test.com', '1234', 'user');

-- 관리자 유저 생성
insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('관리자테스트','20240527', 'M', '@@시 @@구', '관리자테스트', '010-5555-5555', 'manager@test.com', '1234', 'staff');

insert into user_tb (name, birth_date, gender, address, nick_name, phone_number, email, password, admin_check)
values('관리자테스트','20240527', 'F', '@@시 @@구', '관리자테스트2', '010-7777-7777', 'manager2@test.com', '1234', 'staff');


            
-- 카테고리 테이블에 데이터 삽입
insert into category_tb (category_id, category_name) values (1, '문학');
insert into category_tb (category_id, category_name) values (2, '시/에세이');
insert into category_tb (category_id, category_name) values (3, '소설');

-- 장르 테이블에 데이터 삽입
insert into genre_tb (genre_id, genre_name) values (1, '추리');
insert into genre_tb (genre_id, genre_name) values (2, '스릴러');
insert into genre_tb (genre_id, genre_name) values (3, '공포');
insert into genre_tb (genre_id, genre_name) values (4, '과학');
insert into genre_tb (genre_id, genre_name) values (5, '판타지');
insert into genre_tb (genre_id, genre_name) values (6, '무협');


-- 북테이블 생성
insert into book_tb (user_id, title, author_comment, author, category_id, genre_id, introduction, age) 
values (1, '테스트하기1', '줄거리테스트1', '작가테스트1', '1', '1', '소개글1','19');

insert into book_tb (user_id,title,author_comment,author,category_id , genre_id,
            introduction,age) 
			values(2,'테스트하기2','줄거리테스트2','작가테스트2', '1', '1','소개글2', '15');





-- 스토리 테이블 생성
insert into story_tb (book_id,user_id,number,type,title,upload_day,contents)
					values(1,1,1,'프롤로그','뜻밖의 알바 면접','2000-05-03',
                    '서울의 한복판, 흔한 골목길 모퉁이에 위치한 작은 편의점. 낮에는 그저 그런 편의점이지만, 밤이 되면 그곳은 마법의 입구가 된다. 바로 ‘미라클 마트’였다.

김도현은 대학교를 휴학하고 아르바이트를 구하던 중 우연히 그 편의점 앞을 지나쳤다. 창문에는 "야간 알바 급구! 고수익 보장!"이라는 광고가 붙어 있었다. 밤새워 게임하느라 주야가 바뀐 도현에게 야간 알바는 안성맞춤이었다.

“여긴 어디서 많이 본 것 같기도 하고…”

도현은 문을 열고 들어갔다. 그와 동시에 뒤에서 갑자기 문이 쾅 닫히며 주변의 공기가 바뀌었다. 편의점은 이전과 완전히 다른 모습이었다. 형형색색의 마법의 불빛들이 천장에 떠 있었고, 진열대에는 알 수 없는 포션과 마법 책들이 즐비했다.

“어, 어어?” 도현은 눈을 크게 뜨고 주변을 둘러보았다. "여기가 정말 편의점 맞아?"

그때, 카운터 뒤에서 한 소녀가 나타났다. 긴 푸른 머리에 큰 안경을 쓴 소녀는 환하게 웃으며 도현을 맞이했다.

“어서 오세요! ‘미라클 마트’에 오신 걸 환영해요! 저는 매니저, 루나라고 합니다.”

도현은 놀라 눈을 깜빡였다. “매니저요? 저… 야간 알바 구한다고 해서 왔는데요.”

“그럼요! 잘 오셨어요. 사실 저희 마트는 그냥 마트가 아니거든요. 여기는 인간 세계와 마법 세계를 잇는 중요한 중계지점이랍니다.”

도현은 귀를 의심했다. “마법 세계요? 저기, 장난치시는 건 아니죠?”

루나는 도현을 쳐다보며 미소 지었다. “한번 경험해 보실래요? 마법 세계로의 입구는 항상 열려 있으니까요. 대신 조건이 하나 있어요.”

“무슨 조건이죠?”

“여기서 알바를 하는 동안 마법 세계의 규칙을 따라야 해요. 그리고…” 루나는 의미심장한 미소를 지으며 말을 이었다. “당신도 마법을 사용할 수 있게 될 거예요.”

도현은 믿을 수 없다는 표정으로 루나를 바라보았다. 그러나 그의 마음 속에서는 이상하게도 호기심이 점점 커져만 갔다. "마법을... 쓸 수 있다고요? 진짜로?"

“네, 진짜로요. 그리고 아주 좋은 보수도 보장되죠.” 루나는 작고 예쁜 지갑을 꺼내 보여주었다. 그 안에는 눈부신 금화가 가득했다.

도현은 잠시 고민했지만, 결국 결심했다. "좋아요, 해볼게요. 대신, 정말 장난치는 거라면… 나중에 웃지 마세요!"

루나는 깜찍하게 웃으며 손을 내밀었다. “잘 오셨어요, 김도현 씨. 이제부터 당신은 ‘미라클 마트’의 야간 아르바이트생입니다. 그리고 이건 저의 첫 번째 주문입니다.”

도현은 어리둥절한 표정으로 물었다. “첫 번째 주문이요?”

루나는 손가락을 튕기며 주문서를 건네주었다. “마법 세계의 손님이 주문한 물건을 찾아주세요. 이 주문이 끝나면 당신도 첫 번째 마법을 배우게 될 거예요!”

도현은 얼떨결에 주문서를 받았다. 주문서에는 생소한 이름들이 적혀 있었고, 그 중 하나가 눈에 들어왔다.

"용의 비늘 티백"

“잠깐만요, 용의 비늘을 어디서 찾죠?”

루나는 웃으며 대답했다. “그건 바로 당신이 알아내야 할 일이죠. 미라클 마트에는 불가능이란 없답니다!”

도현은 한숨을 쉬며 고개를 끄덕였다. "좋아, 해보자고!"

그리하여 김도현의 첫 번째 마법 알바가 시작되었다. 그의 새로운 일상은 예상치 못한 모험과 마법으로 가득 차게 될 것이었다.');
                    