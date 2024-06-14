CREATE DATABASE hair;

USE hair;

## 이메일 인증 번호 테이블 생성
CREATE TABLE email_auth_number (
    email VARCHAR(100) PRIMARY KEY,
    auth_number VARCHAR(4) NOT NULL
);

## 유저 테이블 생성
CREATE TABLE user (
    user_id VARCHAR(20) PRIMARY KEY,
    user_password VARCHAR(255) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_gender VARCHAR(10) NOT NULL DEFAULT('MALE') CHECK (
        user_gender IN ('MALE', 'FEMALE')
    ),
    user_age VARCHAR(10) NOT NULL,
    user_image TEXT,
    user_company_name VARCHAR(100),
    user_role VARCHAR(25) NOT NULL DEFAULT('ROLE_USER') CHECK (
        user_role IN (
            'ROLE_CUSTOMER',
            'ROLE_DESIGNER',
            'ROLE_ADMIN'
        )
    ),
    join_path VARCHAR(5) NOT NULL DEFAULT('HOME') CHECK (
        join_path IN ('HOME', 'KAKAO', 'NAVER')
    ),
    sns_id VARCHAR(255) UNIQUE,
    CONSTRAINT user_email_fk FOREIGN KEY (user_email) REFERENCES email_auth_number (email) ON DELETE CASCADE
);

## 공지사항 게시물 테이블 생성
CREATE TABLE announcement_board (
    announcement_board_board_number INT PRIMARY KEY AUTO_INCREMENT,
    announcement_board_title VARCHAR(100) NOT NULL,
    announcement_board_contents TEXT NOT NULL,
    announcement_board_writer_id VARCHAR(20) NOT NULL,
    announcement_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    announcement_board_view_count INT NOT NULL DEFAULT(0),
    CONSTRAINT fk_announcement_board_writer_id FOREIGN KEY (announcement_board_writer_id) REFERENCES user (user_id) ON DELETE CASCADE
);
## 트렌드 게시물 테이블 생성
CREATE TABLE trend_board (
    trend_board_number INT PRIMARY KEY AUTO_INCREMENT,
    trend_board_title VARCHAR(100) NOT NULL,
    trend_board_contents TEXT NOT NULL,
    trend_board_writer_id VARCHAR(20) NOT NULL,
    trend_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    trend_board_like_count INT NOT NULL DEFAULT(0),
    trend_board_thumbnail_image LONGTEXT NOT NULL,
    CONSTRAINT fk_trend_board_writer_id FOREIGN KEY (trend_board_writer_id) REFERENCES user (user_id) ON DELETE CASCADE
);

## 트렌드 게시물 답글 테이블 생성
CREATE TABLE trend_board_comment (
    trend_board_comment_number INT PRIMARY KEY AUTO_INCREMENT,
    trend_board_number INT NOT NULL,
    trend_board_comment_contents TEXT NOT NULL,
    trend_board_comment_writer_id VARCHAR(20) NOT NULL,
    trend_board_comment_write_datetime DATETIME NOT NULL DEFAULT(now()),
    CONSTRAINT fk_trend_board_comment_writer_id FOREIGN KEY (trend_board_comment_writer_id) REFERENCES user (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_trend_board_number FOREIGN KEY (trend_board_number) REFERENCES trend_board (trend_board_number) ON DELETE CASCADE
);

## Q&A 게시물 테이블 생성
CREATE TABLE qna_board (
    qna_board_number INT PRIMARY KEY AUTO_INCREMENT,
    qna_board_status BOOLEAN NOT NULL DEFAULT(false),
    qna_board_title VARCHAR(100) NOT NULL,
    qna_board_contents TEXT NOT NULL,
    qna_board_writer_id VARCHAR(20) NOT NULL,
    qna_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    qna_board_view_count INT NOT NULL DEFAULT(0),
    qna_board_comment TEXT,
    CONSTRAINT fk_qna_board_writer_id FOREIGN KEY (qna_board_writer_id) REFERENCES user (user_id) ON DELETE CASCADE
);
## 고객 게시물 테이블 생성
CREATE TABLE customer_board (
    customer_board_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_board_title VARCHAR(100) NOT NULL,
    customer_board_contents TEXT NOT NULL,
    customer_board_writer_id VARCHAR(20) NOT NULL,
    customer_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    customer_board_view_count INT NOT NULL DEFAULT(0),
    is_secret BOOLEAN NOT NULL DEFAULT(false),
    CONSTRAINT fk_customet_board_writer_id FOREIGN KEY (customer_board_writer_id) REFERENCES user (user_id) ON DELETE CASCADE
);
customer_board_parent_comment_number
## 고객 게시물 답글 테이블 생성
CREATE TABLE customer_board_comment (
    customer_board_comment_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_board_number INT NOT NULL,
    customer_board_comment_contents TEXT NOT NULL,
    customer_board_comment_writer_id VARCHAR(20) NOT NULL,
    customer_board_comment_write_datetime DATETIME NOT NULL DEFAULT(now()),
    customer_board_parent_comment_number INT default NULL,
    CONSTRAINT fk_customer_board_parent_comment_number_fk FOREIGN KEY (
        customer_board_parent_comment_number
    ) REFERENCES customer_board_comment (customer_board_comment_number) ON DELETE CASCADE,
    CONSTRAINT fk_customer_board_comment_writer_id_fk FOREIGN KEY (
        customer_board_comment_writer_id
    ) REFERENCES user (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_customer_board_number FOREIGN KEY (customer_board_number) REFERENCES customer_board (customer_board_number) ON DELETE CASCADE
);

## 고객 게시물 이미지 테이블 생성
CREATE TABLE customer_board_image (
    customer_board_image_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_board_image_url TEXT NOT NULL,
    customer_board_number INT NOT NULL,
    CONSTRAINT fk_customer_board_image_number FOREIGN KEY (customer_board_number) REFERENCES customer_board (customer_board_number) ON DELETE CASCADE
);

## 디자이너 게시물 테이블 생성
CREATE TABLE designer_board (
    designer_board_number INT PRIMARY KEY AUTO_INCREMENT,
    designer_board_title VARCHAR(100) NOT NULL,
    designer_board_contents TEXT NOT NULL,
    designer_board_writer_id VARCHAR(20) NOT NULL,
    designer_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    designer_board_view_count INT NOT NULL DEFAULT(0),
    CONSTRAINT fk_desiner_board_writer_id FOREIGN KEY (designer_board_writer_id) REFERENCES user (user_id) ON DELETE CASCADE
);

## 디자이너 게시물 답글 테이블 생성
CREATE TABLE designer_board_comment (
    designer_board_comment_number INT PRIMARY KEY AUTO_INCREMENT,
    designer_board_number INT NOT NULL,
    designer_board_comment_contents TEXT NOT NULL,
    designer_board_comment_writer_id VARCHAR(20) NOT NULL,
    designer_board_comment_write_datetime DATETIME NOT NULL DEFAULT(now()),
    CONSTRAINT fk_designer_comment_writer_id_fk FOREIGN KEY (
        designer_board_comment_writer_id
    ) REFERENCES user (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_designer_board_comment_writer_id_fk FOREIGN KEY (
        designer_board_comment_writer_id
    ) REFERENCES user (user_id) ON DELETE CASCADE,
    CONSTRAINT fk_designer_board_number FOREIGN KEY (designer_board_number) REFERENCES designer_board (designer_board_number) ON DELETE CASCADE
);

## 디자이너 게시물 이미지 테이블 생성
CREATE TABLE designer_board_image (
    designer_board_image_number INT PRIMARY KEY AUTO_INCREMENT,
    designer_board_image_url TEXT NOT NULL,
    designer_board_number INT NOT NULL,
    CONSTRAINT fk_designer_board_image_number FOREIGN KEY (designer_board_number) REFERENCES designer_board (designer_board_number) ON DELETE CASCADE
);

## 방문로그 테이블 생성
CREATE TABLE login_log (
    sequence INT PRIMARY KEY AUTO_INCREMENT,
    login_id VARCHAR(20),
    login_date DATE DEFAULT(now()),
    CONSTRAINT fk_login_id FOREIGN KEY (login_id) REFERENCES user (user_id) ON DELETE CASCADE
);

## 개발자 계정 생성
CREATE USER 'developer' @'%' IDENTIFIED BY 'P!ssw0rd';

GRANT ALL PRIVILEGES ON hair.* TO 'developer' @'%';