CREATE TABLE `user_tb` (
    `user_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT 'auto',
    `nick_name` varchar(20) NOT NULL UNIQUE,
    `email` varchar(40) UNIQUE NOT NULL,
    `phone_number` varchar(30) NULL,
    `password` varchar(1000) NOT NULL,
    `profile_img` TEXT null,
    `role` VARCHAR(50) NOT NULL DEFAULT 'user',
    -- 기본값 'user' 설정
    CHECK (role IN ('admin', 'user')),
    `created_at` timestamp NOT NULL DEFAULT current_timestamp COMMENT 'current' -- 우리꺼 네이버인지 카카온지 구글인지 저장
);

-- 장르 테이블
CREATE TABLE `genre_tb` (
    `genre_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `genre_name` varchar(50) NOT NULL COMMENT '장르 이름'
);

-- 카테고리 테이블
CREATE TABLE `category_tb` (
    `category_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `category_name` varchar(50) NOT NULL COMMENT '카테고리 이름'
);

-- 태그 테이블
CREATE TABLE `tag_tb` (
    `tag_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `tag_name` varchar(50) NOT NULL COMMENT '태그 이름'
);

-- 책 테이블
CREATE TABLE `book_tb` (
    `book_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '참조: user_tb.user_id',
    `title` varchar(50) NOT NULL COMMENT '책 제목',
    `author_comment` text NOT NULL COMMENT '작가코멘트',
    `author` varchar(20) NOT NULL COMMENT '가명',
    `book_cover_image` text NULL,
    `category_id` int NOT NULL,
    `genre_id` int NOT NULL,
    `introduction` text NOT NULL COMMENT '책 소개글',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    `likes` int NULL DEFAULT 0 COMMENT '좋아요',
    `age` ENUM('전체', '7', '12', '15', '19') NOT NULL COMMENT '등급 표시제',
    `serial_day` varchar(10) NULL DEFAULT '비 정기 연재' COMMENT '연재 방식',

    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`category_id`) REFERENCES `category_tb`(`category_id`),
    FOREIGN KEY (`genre_id`) REFERENCES `genre_tb`(`genre_id`)
);

-- 중간 테이블: 책-태그
CREATE TABLE `book_tag_tb` (
    `book_id` int NOT NULL,
    `tag_id` int NOT NULL,
    PRIMARY KEY (`book_id`, `tag_id`),
    FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`) ON DELETE CASCADE,
    FOREIGN KEY (`tag_id`) REFERENCES `tag_tb`(`tag_id`) ON DELETE CASCADE
);

CREATE TABLE `story_tb` (
    `story_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `book_id` int NOT NULL COMMENT '외래 키, book_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `number` varchar(10) NOT NULL COMMENT '회차',
    `type` varchar(20) NOT NULL COMMENT '프롤로그,무료,유료',
    `title` varchar(50) NOT NULL COMMENT '회차 제목',
    `upload_day` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '예약 일자',
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `save` varchar(10) NOT NULL DEFAULT 'Y' COMMENT 'Y,N',
    `cost` bigint NOT NULL DEFAULT 0,
    `views` int NOT NULL DEFAULT 0,
    `contents` text NOT NULL COMMENT '소설 내용',
    FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);


-- 뷰,평점 테이블
CREATE TABLE `book_views_rating_tb` (
    `view_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,                    -- 고유 조회 기록 ID
    `book_id` int not null,       				   -- 책 ID (외래 키)     
    `view_year` int,
	`view_month` INT,                              -- 조회  월
    `view_day` INT,   						       -- 조회 일
    `views`  int  DEFAULT 0, -- default값필요                  -- 해당 날짜의 조회수
    `rating` double  null, -- default이 있으면 오류가능성
    `user_id` int not null ,       -- 조회한 사용자 (선택적)        
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 조회 기록 생성 시각,
        FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`) ON DELETE CASCADE,
		FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`) ON DELETE CASCADE
);


/* 유저 상세 정보  (테스트) */
-- 이름(본명), 생일, 전화번호, 주소, 포인트(잔액)
CREATE TABLE `user_de_tb` (
    `user_detail_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `point` bigint NULL DEFAULT 0,
    name VARCHAR(20) NULL COMMENT '유저 이름(본명)',
    birth_date DATE NULL COMMENT '생일',
    address VARCHAR(100) NULL COMMENT '주소',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `project_tb` (
    `project_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '등록 유저id',
    `book_id` int not null comment '등록 book id',
    `title` varchar(50) NOT NULL COMMENT '프로젝트 제목',
    `oneline_comment` varchar(200) NOT NULL COMMENT '프로젝트 한줄 소개',
    `contents` text NOT NULL COMMENT '프로젝트 내용',
    `goal` bigint NOT NULL COMMENT '프로젝트 목표',
    `date_end` date NOT NULL COMMENT '프로젝트 마감일',
    `created_at` timestamp NULL DEFAULT current_timestamp COMMENT '프로젝트 시작일',
    `staff_agree` enum('N', 'Y') NOT NULL DEFAULT 'N' COMMENT 'Y:N',
    `main_img` text null COMMENT 'project 메인 이미지',
    `project_successful` enum('N', 'Y') NULL DEFAULT 'N' COMMENT 'Y:N 프로젝트 성공 여부',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb` (`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `book_tb` (`book_id`)
);

CREATE TABLE `content_tb` (
    `content_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `project_id` int NOT NULL,
    `img` text not null COMMENT 'project 컨텐츠 이미지',
    FOREIGN KEY (`project_id`) REFERENCES `project_tb`(`project_id`)
);

CREATE TABLE `book_rent_histry_tb` (
    `book_rent_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT 'auto',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `book_id` int NOT NULL COMMENT '외래 키, book_tb 참조',
    `story_id` int NOT NULL COMMENT '외래 키, book_tb 참조',
    `book_point` int NOT NULL COMMENT '대여 포인트',
    `account_amount` int NOT NULL COMMENT '구매 포인트',
    `before_point` int NOT NULL DEFAULT 0 COMMENT '사용자 보유 포인트',
    `after_point` int NOT NULL COMMENT '사용자 구매 후 포인트',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`),
    FOREIGN KEY (`story_id`) REFERENCES `story_tb`(`story_id`)
);

CREATE TABLE `event_tb` (
    `event_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT 'auto',
    `event_title` varchar(20) NOT NULL COMMENT '이벤트 제목',
    `event_content` text NOT NULL COMMENT '이벤트 내용',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp COMMENT '이벤트 생성 시간',
    `start_day` date NOT NULL COMMENT '이벤트 시작일',
    `end_day` date NOT NULL COMMENT '이벤트 종료일',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조, 당첨자 명',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

-- 참여자
CREATE TABLE `event_participants_tb` (
    `participant_id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT '참여자 ID',
    `event_id` INT NOT NULL unique COMMENT '이벤트 ID',
    `user_id` INT NOT NULL unique COMMENT '사용자 ID',
    `participation_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '참여 일자',
    FOREIGN KEY (`event_id`) REFERENCES `event_tb`(`event_id`) ON DELETE CASCADE,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`) ON DELETE CASCADE
);

-- 당첨자
CREATE TABLE `event_winners_tb` (
    `winner_id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT '당첨자 ID',
    `event_id` INT NOT NULL COMMENT '이벤트 ID',
    `user_id` INT NOT NULL COMMENT '당첨된 사용자 ID',
    `winning_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '당첨 일자',
    `prize` VARCHAR(100) COMMENT '당첨 상품',
    FOREIGN KEY (`event_id`) REFERENCES `event_tb`(`event_id`) ON DELETE CASCADE,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`) ON DELETE CASCADE
);
-- 토스페이먼츠 결제 성공 시 기록에 저장된다. (user_id, deposit, point, after_balance, created_at, payment_key, status)
CREATE TABLE `account_history_tb` (
    `account_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `deposit` bigint NOT NULL COMMENT '입금 금액',
    `point` bigint NOT NULL COMMENT '충전 포인트',
    `after_balance` bigint NOT NULL COMMENT '충전 후 포인트',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    `payment_key` varchar(50) null comment '토스 환불에서 paymentkey, 결제가격, 환불이유가 필요',
    `status` VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT '요청 상태 (PENDING, APPROVED, REJECTED)',
    refund_reason VARCHAR(255) COMMENT '환불 사유',
    event char(1),
    method varchar(15)
);

-- 환불 요청 테이블 (사용자가 환불요청 하면 관리자가 승인, 거절 할 수 있다.)
CREATE TABLE refund_request_tb (
    refund_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT '환불 요청 ID',
    user_id INT NOT NULL COMMENT 'user_tb의 외래 키',
    staff_id INT NULL COMMENT 'user_tb의 왜래 키',
    payment_key VARCHAR(50) NOT NULL COMMENT '결제 고유 키',
    refund_amount BIGINT NOT NULL COMMENT '환불 금액',
    refund_reason VARCHAR(255) COMMENT '환불 사유',
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT '요청 상태 (PENDING, 심사중, 승인, 거절)',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '요청 생성 시간',
    approved_at TIMESTAMP NULL COMMENT '관리자 승인 시간',
    rejected_at TIMESTAMP NULL COMMENT '관리자 거부 시간',
    point bigint not null comment '결제후 포인트 획득',
    method varchar(10) not null comment '결제 방식',
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id),
    FOREIGN KEY (staff_id) REFERENCES user_tb(user_id)
);

-- 충전 이벤트 유무를 확인할 수 있다. (만약 이벤트가 'Y' 이면 환불 불가 or 이벤트가 'N' 이라면 환불 가능)
create table payment_tb(
	payment_id int primary key auto_increment,
    user_id int not null,
    price bigint not null,
    point bigint not null ,
    event char(1), -- 'Y' 'N'
    payment_key varchar(50) not null,
    FOREIGN KEY (user_id) REFERENCES user_tb(user_id),
    FOREIGN KEY (payment_key) REFERENCES account_history_tb(payment_key)
);


CREATE TABLE `reward_tb` (
    `reward_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `project_id` int NOT NULL COMMENT '외래 키, project_tb 참조',
    `reward_content` text NOT NULL COMMENT '공지 사항 내용',
    `reward_point` int NOT NULL COMMENT '리워드 금액',
    `reward_quantity` int NOT NULL DEFAULT 0 COMMENT '리워드 수량',
    -- 리워드 수량 추가
    FOREIGN KEY (`project_id`) REFERENCES `project_tb` (`project_id`)
);

CREATE TABLE `funding_tb` (
    `funding_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, 참여 user_tb 참조',
    `reward_id` int NOT NULL COMMENT '외래 키, 참여 reward_tb 참조',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    `canceled_at` date DEFAULT NULL COMMENT '취소된 날짜, NULL 허용',
    `reward_quantity` int NOT NULL COMMENT '리워드 수량',
    `cancel_confirm` enum('N', 'Y') NULL DEFAULT 'N' COMMENT 'Y:N',
    `zipcode` varchar(10) NOT NULL COMMENT '우편번호',
    `basic_address` varchar(255) NOT NULL COMMENT '기본 주소',
    `detailed_address` varchar(255) NOT NULL COMMENT '상세 주소',
    `extra_address` varchar(255) COMMENT '참고 항목',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`) ON DELETE CASCADE,
    FOREIGN KEY (`reward_id`) REFERENCES `reward_tb`(`reward_id`) ON DELETE CASCADE
    `canceled_At` DATE DEFAULT '2099-12-31' ,
    `confirm_success` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT 'Y:N',
		FOREIGN KEY (`reward_id`) REFERENCES `reward_tb`(`reward_id`),
       FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `funding_history_tb` (
    `funding_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT 'auto',
    `project_id` int NOT NULL COMMENT '외래 키, project_tb 참조',
    FOREIGN KEY (`project_id`) REFERENCES `project_tb`(`project_id`)
);

CREATE TABLE `notice_tb` (
    `notice_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `notice_title` varchar(50) NOT NULL COMMENT '공지 사항 제목',
    `notice_content` text NOT NULL COMMENT '공지 사항 내용',
    `comment` text NULL COMMENT '공지 사항 댓글',
    `created_at` timestamp NULL DEFAULT current_timestamp,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `qna_tb` (
    `qna_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `title` varchar(40) NOT NULL COMMENT '문의 제목',
    `question_content` text COMMENT '질문 사항 내용',
    `answer_content` text COMMENT '질문 사항 내용',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `user_alert_list_tb` (
    `alert_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `alert_content` varchar(50) NOT NULL COMMENT '경고 내용'
);

CREATE TABLE `user_alert_history_tb` (
    `alert_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `alert_id` int NOT NULL COMMENT '외래 키, user_alert_list_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, staff_tb 참조',
    `period_date` date NOT NULL COMMENT '경고 기간',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`alert_id`) REFERENCES `user_alert_list_tb`(`alert_id`)
);

CREATE TABLE `user_coupon_tb` (
    `coupon_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `coupon_name` varchar(50) NOT NULL,
    `coupon_content` varchar(50) NOT NULL,
    `coupon_date` date NOT NULL,
    `coupon_price` bigint NOT NULL
);

CREATE TABLE `order_tb` (
    `order_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `field` varchar(255) NULL,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `user_coupon_history_tb` (
    `coupon_use_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `coupon_id` int NOT NULL COMMENT '외래 키, user_coupon_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `coupon_name` varchar(50) NOT NULL,
    `coupon_content` varchar(50) NOT NULL,
    `coupon_date` date NOT NULL,
    `coupon_price` bigint NOT NULL,
    FOREIGN KEY (`coupon_id`) REFERENCES `user_coupon_tb`(`coupon_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `black_user_tb` (
    `user_id` int NOT NULL,
    `black_user_id` int NULL COMMENT '차단한 사용자 ID',
    `black_reason` text NULL COMMENT '차단 사유',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `report_tb` (
    `report_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `alert_id` int NOT NULL COMMENT '외래 키, user_alert_list_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `report_user_id` int NULL COMMENT '신고 대상 유저 ID',
    `project_id` int NULL COMMENT '신고 대상 프로젝트 ID',
    `book_id` int NULL COMMENT '신고 대상 BookID',
    `period_content` text NOT NULL,
    `created_at` timestamp NULL DEFAULT current_timestamp,
    `processing` enum('N', 'Y') NULL DEFAULT 'N' COMMENT 'Y:N',
    FOREIGN KEY (`alert_id`) REFERENCES `user_alert_list_tb`(`alert_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `report_history_tb` (
    `report_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `report_id` int NOT NULL COMMENT '외래 키, report_tb 참조',
    `alert_id` int NOT NULL COMMENT '외래 키, user_alert_list_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `created_at` timestamp NULL DEFAULT current_timestamp,
    FOREIGN KEY (`report_id`) REFERENCES `report_tb`(`report_id`),
    FOREIGN KEY (`alert_id`) REFERENCES `user_alert_list_tb`(`alert_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `story_comment_tb` (
    `comment_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `story_id` int NOT NULL COMMENT '외래 키, story_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `book_id` int NOT NULL COMMENT '외래 키, book_tb 참조',
    `comment` text NOT NULL COMMENT '회차별 댓글',
    `created_at` timestamp NULL DEFAULT current_timestamp COMMENT '댓글 작성 시간',
    `likes` int NULL DEFAULT 0,
    FOREIGN KEY (`story_id`) REFERENCES `story_tb`(`story_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`)
);

CREATE TABLE `subscribe_tb` (
    `subscribe_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `subscribe_user_id` int NULL COMMENT '구독 대상 ID',
    `book_id` int NULL COMMENT '책 ID',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `project_comment_tb` (
    `comment_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `project_id` int NOT NULL COMMENT '외래 키, project_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `comment` text NOT NULL COMMENT '프로젝트 댓글',
    `created_at` timestamp NULL DEFAULT current_timestamp COMMENT '댓글 작성 시간',
    `likes` int NULL DEFAULT 0 COMMENT '프로젝트 좋아요 갯수',
    FOREIGN KEY (`project_id`) REFERENCES `project_tb`(`project_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `book_comment_tb` (
    `comment_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `book_id` int NOT NULL COMMENT '외래 키, book_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `comment` text NOT NULL COMMENT '북 댓글',
    `created_at` timestamp NULL DEFAULT current_timestamp COMMENT '댓글 작성 시간',
    `likes` int NULL DEFAULT 0,
    FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `banner_tb`(
    `banner_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `title` varchar(1000) COMMENT '베너 제목',
    `content_one` varchar(1000) COMMENT '베너 내용1',
    `content_two` varchar(1000) COMMENT '베너 내용2',
    `img` varchar(2000) COMMENT '이미지'
`banner_id`int PRIMARY KEY AUTO_INCREMENT NOT NULL,
`title` varchar(1000) COMMENT '베너 제목',
`content` varchar(1000) COMMENT '베너 내용1',
`sub_content` varchar(1000) COMMENT '베너 내용2',
`image_path` varchar(2000) COMMENT '이미지 경로',
`event_id` int,
FOREIGN KEY (`event_id`) REFERENCES `event_tb`(`event_id`)
);

-- project_tb에 reward_id에 대한 외래 키 추가
-- ALTER TABLE `project_tb`
-- ADD CONSTRAINT fk_project_reward FOREIGN KEY (`reward_id`) REFERENCES `reward_tb`(`reward_id`);
ALTER TABLE `project_tb`
ADD CONSTRAINT fk_project_reward FOREIGN KEY (`reward_id`) REFERENCES `reward_tb`(`reward_id`);



-- fk 순환구조라 오류생김
-- reward_tb에 project_id에 대한 외래 키 추가
-- ALTER TABLE `reward_tb`
-- ADD CONSTRAINT fk_reward_project FOREIGN KEY (`project_id`) REFERENCES `project_tb`(`project_id`);