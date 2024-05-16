-- Active: 1706776139341@@127.0.0.1@3306@estate
# Entity
# - 사용자(고객, 디자이너, 관리자)
# - 이메일 인증번호
# - 공지사항 게시물
# - 트렌드 게시물
# - 고객 게시물
# - 채팅방
# - 디자이너 게시물
# - Q&A 게시물

# Atribute
# - 사용자 (아이디*, 비밀번호, 이메일, 성별, 연령대, 업체명, 면허증사진 권한, 가입경로)
# - 이메일 인증번호 (이메일*, 인증번호)
# - 공지사항 게시물 (게시물번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - 트렌드 게시물 (게시물번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - 트렌드 게시물 답글 (게시물답글번호*, 내용, 작성자, 작성일)
# - 고객 게시물 (게시물번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - 고객 게시물 답글 (게시물답글번호*, 내용, 작성자, 작성일)
# - 디자이너 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수)
# - 디자이너 게시물 답글 (게시물답글번호*, 내용, 작성자, 작성일)
# - Q&A 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수, 답글)

# Relationship
# 사용자 - 이메일 인증번호 : 이메일 인증번호 테이블에 등록된 이메일만 사용자의 이메일로 사용할 수 있음 (1 : 1)
# 사용자 - 공지사항 게시물 : 사용자 이면서 관리자 권한을 가진 사람이 게시물을 작성할 수 있음 (1 : n)
# 사용자 - 트렌드 게시물 : 사용자 이면서 관리자 권한을 가진 사람이 게시물을 작성할 수 있음 (1 : n)
# 사용자 - Q&A 게시물 : 사용자 이면서 관리자 권한을 가진 사람이 게시물을 작성할 수 있음 (1 : n)
# 사용자 - 고객 게시물 : 사용자 이면서 고객 권한을 가진 사람이 게시물을 작성할 수 있음 (1 : n)
# 사용자 - 디자이너 게시물 : 사용자 이면서 디자이너 권한을 가진 사람이 게시물을 작성할 수 있음 (1 : n)

# 사용자 - 채팅방: 사용자 이면서 고객 이거나 디자이너 권한을 가진 사람이 게시물을 작성할 수 있음 (1 : n)

# # - 사용자 (아이디*, 비밀번호, 이메일, 성별, 연령대, 업체명, 면허증사진, 권한, 가입경로)
# table name : user
# user_id : VARCHAR(20) PK
# user_password : VARCHAR(255) NN
# user_email : VARCHAR(50) NN UQ FK email_auth_number(email)
# auth_number : VARCHAR(4) NN 
# user_gender : VARCHAR(10) NN 
# user_age : VARCHAR(10) NN 
# user_image : TEXT
# user_compony_name : VARCHAR(100) 
# role : VARCHAR(10) NN DEFAULT('ROLE_CUSTOMER') CHECK('ROLE_CUSTOMER', 'ROLE_DESIGNER','ROLE_ADMIN')
# join_path : VARCHAR(5) NN DEFAULT('HOME') CHECK('HOME', 'KAKAO', 'NAVER')
#
# - 이메일 인증번호 (이메일*, 인증번호)
#  table name : email_auth_number
#  email : VARCHAR(100) PK
#  auth_number : VARCHAR(4) NN
#
# - 게시물 (게시물번호*, 제목, 내용, 작성자, 작성일, 조회수)
# table name : announcement_board
# announcement_board_number : INT PK AI
# announcement_board_title : VARCHAR(100) NN
# announcement_board_contents : TEXT NN
# announcement_board_writer_id : VARCHAR(50) NN FK user(user_id)
# announcement_board_write_datetime : DATETIME NN DEFAULT(now())
# announcement_board_view_count : INT NN DEFAULT(0)
#
# - 게시물 (게시물번호*, 제목, 내용, 작성자, 작성일, 조회수)
# table name : trend_board
# trend_board_number : INT PK AI
# trend_board_title : VARCHAR(100) NN
# trend_board_contents : TEXT NN
# trend_board_writer_id : VARCHAR(50) NN FK user(user_id)
# trend_board_write_datetime : DATETIME NN DEFAULT(now())
# trend_board_view_count : INT NN DEFAULT(0)
#
# - 게시물 (접수번호*, 상태, 제목, 내용, 작성자, 작성일, 조회수, 답변)
# table name : qna_board
# qna_board_number : INT PK AI
# qna_board_status : BOOLEAN NN DEFAULT(false)
# qna_board_title : VARCHAR(100) NN
# qna_board_contents : TEXT NN
# qna_board_writer_id : VARCHAR(50) NN FK user(user_id)
# qna_board_write_datetime : DATETIME NN DEFAULT(now())
# qna_board_view_count : INT NN DEFAULT(0)
#
# - 게시물 (게시물번호*, 제목, 내용, 작성자, 작성일, 조회수)
# table name : customer_board
# customer_board_number : INT PK AI
# customer_board_title : VARCHAR(100) NN
# customer_board_contents : TEXT NN
# customer_board_writer_id : VARCHAR(50) NN FK user(user_id)
# customer_board_write_datetime : DATETIME NN DEFAULT(now())
# customer_board_view_count : INT NN DEFAULT(0)
#
# - 게시물 (접수번호*, 제목, 내용, 작성자, 작성일, 조회수, 답변)
# table name : designer_board
# designer_board_number : INT PK AI
# designer_board_title : VARCHAR(100) NN
# designer_board_contents : TEXT NN
# designer_board_writer_id : VARCHAR(50) NN FK user(user_id)
# designer_board_write_datetime : DATETIME NN DEFAULT(now())
# designer_board_view_count : INT NN DEFAULT(0)

## 데이터베이스 생성
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
    user_gender VARCHAR(10) NOT NULL, 
    user_age VARCHAR(10) NOT NULL, 
    user_image TEXT,
    user_compony_name VARCHAR(100), 
    user_role VARCHAR(25) NOT NULL DEFAULT('ROLE_USER') CHECK (
        user_role IN ('ROLE_CUSTOMER', 'ROLE_DESIGNER', 'ROLE_ADMIN')
    ),
    join_path VARCHAR(5) NOT NULL DEFAULT('HOME') CHECK (
        join_path IN ('HOME', 'KAKAO', 'NAVER')
    ),
    CONSTRAINT user_email_fk FOREIGN KEY (user_email) REFERENCES email_auth_number (email)
);

## 공지사항 게시물 테이블 생성
CREATE TABLE announcement_board (
    announcement_board_number INT PRIMARY KEY AUTO_INCREMENT,
    announcement_title VARCHAR(100) NOT NULL,
    announcement_contents TEXT NOT NULL,
    announcement_writer_id VARCHAR(20) NOT NULL,
    announcement_write_datetime DATETIME NOT NULL DEFAULT(now()),
    announcement_view_count INT NOT NULL DEFAULT(0),
    CONSTRAINT fk_announcement_board_writer_id FOREIGN KEY (announcement_writer_id) REFERENCES user (user_id)
);
## 트렌드 게시물 테이블 생성
CREATE TABLE trend_board (
    trend_board_number INT PRIMARY KEY AUTO_INCREMENT,
    trend_board_title VARCHAR(100) NOT NULL,
    trend_board_contents TEXT NOT NULL,
    trend_board_writer_id VARCHAR(20) NOT NULL,
    trend_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    trend_board_view_count INT NOT NULL DEFAULT(0),
    CONSTRAINT fk_trend_board_writer_id FOREIGN KEY (trend_board_writer_id) REFERENCES user (user_id)
);

CREATE TABLE trend_board_comment (
    trend_board_comment_number INT PRIMARY KEY AUTO_INCREMENT,
    trend_board_number INT NOT NULL,
    trend_board_comment_contents TEXT NOT NULL,
    trend_board_comment_writer_id VARCHAR(20) NOT NULL,
    trend_board_comment_write_datetime DATETIME NOT NULL DEFAULT(now()),
    CONSTRAINT fk_trend_board_comment_writer_id FOREIGN KEY (trend_board_comment_writer_id) REFERENCES user (user_id),
    CONSTRAINT fk_trend_board_number FOREIGN KEY (trend_board_number) REFERENCES trend_board (trend_board_number)
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
    CONSTRAINT fk_qna_board_writer_id FOREIGN KEY (qna_board_writer_id) REFERENCES user (user_id)
);
## 고객 게시물 테이블 생성
CREATE TABLE customer_board (
    customer_board_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_board_title VARCHAR(100) NOT NULL,
    customer_board_contents TEXT NOT NULL,
    customer_board_writer_id VARCHAR(20) NOT NULL,
    customer_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    customer_board_view_count INT NOT NULL DEFAULT(0),
    CONSTRAINT fk_customet_board_writer_id FOREIGN KEY (customer_board_writer_id) REFERENCES user (user_id)
);

CREATE TABLE customer_board_comment (
    customer_board_comment_number INT PRIMARY KEY AUTO_INCREMENT,
    customer_board_number INT NOT NULL,
    customer_board_contents TEXT NOT NULL,
    customer_board_writer_id VARCHAR(20) NOT NULL,
    customer_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    CONSTRAINT fk_customer_board_comment_writer_id_fk FOREIGN KEY (customer_board_writer_id) REFERENCES user (user_id),
    CONSTRAINT fk_customer_board_number FOREIGN KEY (customer_board_number) REFERENCES customer_board (customer_board_number)
);
## 디자이너 게시물 테이블 생성
CREATE TABLE degsiner_board (
    degsiner_board_number INT PRIMARY KEY AUTO_INCREMENT,
    degsiner_board_title VARCHAR(100) NOT NULL,
    degsiner_board_contents TEXT NOT NULL,
    degsiner_board_writer_id VARCHAR(20) NOT NULL,
    degsiner_board_write_datetime DATETIME NOT NULL DEFAULT(now()),
    degsiner_board_view_count INT NOT NULL DEFAULT(0),
    CONSTRAINT fk_desiner_board_writer_id FOREIGN KEY (degsiner_board_writer_id) REFERENCES user (user_id)
);

CREATE TABLE degsiner_board_comment (
    degsiner_board_comment_number INT PRIMARY KEY AUTO_INCREMENT,
    degsiner_board_number INT NOT NULL,
    degsiner_board_comment_contents TEXT NOT NULL,
    degsiner_board_comment_writer_id VARCHAR(20) NOT NULL,
    degsiner_board_comment_write_datetime DATETIME NOT NULL DEFAULT(now()),
    CONSTRAINT fk_degsiner_comment_writer_id_fk FOREIGN KEY (degsiner_board_comment_writer_id) REFERENCES user (user_id),
    CONSTRAINT fk_degsiner_board_number FOREIGN KEY (degsiner_board_number) REFERENCES degsiner_board (degsiner_board_number)
);

## 개발자 계정 생성
CREATE USER 'developer' @'%' IDENTIFIED BY 'P!ssw0rd';

GRANT ALL PRIVILEGES ON estate.* TO 'developer' @'%';