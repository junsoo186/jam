CREATE TABLE `user_tb` (
    `user_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT 'auto',
    `name` varchar(20) NOT NULL,
    `birth_date` date NOT NULL,
    `gender` enum('M','F') NOT NULL,
    `address` varchar(100) NULL,
    `nick_name` varchar(20) NOT NULL,
    `phone_number` varchar(30) NOT NULL,
    `email` varchar(40) NOT NULL,
    `password` varchar(1000) NOT NULL,
    `admin_check` enum('user','staff') NOT NULL DEFAULT 'user' COMMENT 'Y,N',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp COMMENT 'current'
);

CREATE TABLE `genre_tb` (
    `genre_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `genre_name` varchar(10) NULL
);

CREATE TABLE `category_tb` (
    `category_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `best` varchar(50) NOT NULL
);

CREATE TABLE `tag_tb` (
    `tag_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `tag_name` varchar(50) NOT NULL
);

CREATE TABLE `book_tb` (
    `book_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '참조: user_tb.user_id',
    `title` varchar(50) NOT NULL COMMENT '책 제목', 
    `author_comment` text NOT NULL COMMENT '작가코멘트',
    `author` varchar(20) NOT NULL COMMENT '가명',
    `book_cover_image` text NULL,
    `category_id` int NOT NULL COMMENT '참조: category_tb.category_id',
    `genre_id` int NOT NULL COMMENT '참조: genre_tb.genre_id',
    `tag_id` int NOT NULL COMMENT '참조: tag_tb.tag_id',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    `like` int NULL DEFAULT 0 COMMENT '좋아요',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`category_id`) REFERENCES `category_tb`(`category_id`),
    FOREIGN KEY (`genre_id`) REFERENCES `genre_tb`(`genre_id`),
    FOREIGN KEY (`tag_id`) REFERENCES `tag_tb`(`tag_id`)
);

CREATE TABLE `user_de_tb` (
    `user_detail_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `point` bigint NOT NULL DEFAULT 0,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `project_tb` (
    `project_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL,
    `title` varchar(50) NOT NULL COMMENT '프로젝트 제목',
    `contents` text NOT NULL COMMENT '프로젝트 내용',
    `category_id` INT NOT NULL,
    `goal` bigint NOT NULL COMMENT '프로젝트 목표',
    `date_start` date NOT NULL COMMENT '프로젝트 시작일',
    `date_end` date NOT NULL COMMENT '프로젝트 마감일',
    `project_image` text NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    `staff_agree` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT 'Y:N',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb` (`user_id`),
    FOREIGN KEY (`category_id`) REFERENCES `category_tb` (`category_id`)
);

CREATE TABLE `book_rent_histry_tb` (
    `book_rent_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT 'auto',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `book_id` int NOT NULL COMMENT '외래 키, book_tb 참조',
    `book_point` int NOT NULL COMMENT '대여 포인트',
    `account_amount` int NOT NULL COMMENT '구매 포인트',
    `before_point` int NOT NULL DEFAULT 0 COMMENT '사용자 보유 포인트',
    `after_point` int NOT NULL COMMENT '사용자 구매 후 포인트',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`)
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

CREATE TABLE `account_history_tb` (
    `account_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `deposit` bigint NOT NULL COMMENT '입금 금액',
    `point` bigint NOT NULL COMMENT '충전 포인트',
    `after_balance` bigint NOT NULL COMMENT '충전 후 포인트' ,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `funding_tb` (
    `funding_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `project_id` int NOT NULL COMMENT '외래 키, project_tb 참조',
    FOREIGN KEY (`project_id`) REFERENCES `project_tb`(`project_id`)
);

CREATE TABLE `funding_history_tb` (
    `funding_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL COMMENT 'auto',
    `funding_id` int NOT NULL,
    `project_id` int NOT NULL COMMENT '외래 키, project_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `subject` varchar(50) NULL COMMENT '펀딩 제목',
    `project_reward` bigint NOT NULL COMMENT '유저 선택 리워드',
    `after_balance` bigint NULL COMMENT '포인트 결제 시 사용',
    `request` int NOT NULL COMMENT '남은 목표 금액',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    `confirm_success` enum('N','Y') NULL DEFAULT 'N' COMMENT 'Y:N 성공 여부',
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`project_id`) REFERENCES `project_tb`(`project_id`),
    FOREIGN KEY (`funding_id`) REFERENCES `funding_tb` (`funding_id`)
);

CREATE TABLE `staff_tb` (
    `staff_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `staff_name` varchar(10) NOT NULL,
    `staff_password` varchar(1000) NOT NULL
);

CREATE TABLE `notice_tb` (
    `notice_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `staff_id` int NOT NULL COMMENT '외래 키, staff_tb 참조',
    `notice_title` varchar(50) NOT NULL COMMENT '공지 사항 제목',
    `notice_content` text NOT NULL COMMENT '공지 사항 내용',
    `comment` text NULL COMMENT '공지 사항 댓글',
    `created_at` timestamp NULL DEFAULT current_timestamp,
    FOREIGN KEY (`staff_id`) REFERENCES `staff_tb`(`staff_id`)
);

CREATE TABLE `qna_tb` (
    `qna_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `staff_id` int NOT NULL COMMENT '외래 키, staff_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    `qna_content` text NULL COMMENT '문의 사항 내용',
    FOREIGN KEY (`staff_id`) REFERENCES `staff_tb`(`staff_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `user_alert_list_tb` (
    `alert_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `alert_content` varchar(50) NOT NULL COMMENT '경고 내용'
);

CREATE TABLE `user_alert_history_tb` (
    `alert_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `alert_id` int NOT NULL COMMENT '외래 키, user_alert_list_tb 참조',
    `staff_id` int NOT NULL COMMENT '외래 키, staff_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `period_date` date NOT NULL COMMENT '경고 기간',
    FOREIGN KEY (`staff_id`) REFERENCES `staff_tb`(`staff_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`),
    FOREIGN KEY (`alert_id`) REFERENCES `user_alert_list_tb`(`alert_id`)
);

CREATE TABLE `user_coupon_tb` (
    `coupon_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `coupon_name` varchar(50) NOT NULL,
    `coupon_content` varchar(50) NOT NULL,
    `coupon_date` date NOT NULL,
    `coupon_price` bigint NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
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

CREATE TABLE `story_tb` (
    `story_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `book_id` int NOT NULL COMMENT '외래 키, book_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `number` int NOT NULL COMMENT '회차',
    `type` varchar(20) NOT NULL COMMENT '프롤로그,무료,유료',
    `title` varchar(20) NOT NULL COMMENT '회차 제목',
    `upload_day` date NOT NULL COMMENT '예약 일자',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp,
    `age` int NOT NULL COMMENT '15,19',
    `save` varchar(10) NOT NULL DEFAULT 'Y' COMMENT 'Y,N',
    `cost` int NOT NULL DEFAULT 0,
    `views` int NOT NULL DEFAULT 0,
    `content` text NOT NULL COMMENT '소설 내용',
    FOREIGN KEY (`book_id`) REFERENCES `book_tb`(`book_id`),
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
    `processing` enum('N','Y') NULL DEFAULT 'N' COMMENT 'Y:N',
    FOREIGN KEY (`alert_id`) REFERENCES `user_alert_list_tb`(`alert_id`),
    FOREIGN KEY (`user_id`) REFERENCES `user_tb`(`user_id`)
);

CREATE TABLE `report_history_tb` (
    `report_history_id` int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `report_id` int NOT NULL COMMENT '외래 키, report_tb 참조',
    `staff_id` int NOT NULL COMMENT '외래 키, staff_tb 참조',
    `alert_id` int NOT NULL COMMENT '외래 키, user_alert_list_tb 참조',
    `user_id` int NOT NULL COMMENT '외래 키, user_tb 참조',
    `created_at` timestamp NULL DEFAULT current_timestamp,
    FOREIGN KEY (`report_id`) REFERENCES `report_tb`(`report_id`),
    FOREIGN KEY (`staff_id`) REFERENCES `staff_tb`(`staff_id`),
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