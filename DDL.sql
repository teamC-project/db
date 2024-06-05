CREATE DATABASE hair;

USE hair;

## 이메일 인증 번호 테이블 생성boardboardboard
CREATE TABLE email_auth_number (
    email VARCHAR(100) PRIMARY KEY,
    auth_number VARCHAR(4) NOT NULL
);

## 유저 테이블 생성
CREATE TABLE user (
    user_id VARCHAR(50) PRIMARY KEY,
    user_password VARCHAR(255) NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_gender  VARCHAR(10) NOT NULL, 
    user_age  VARCHAR(10) NOT NULL, 
    user_image  VARCHAR(100), 
    user_compony_name  VARCHAR(100), 
    user_role VARCHAR(15) NOT NULL DEFAULT('ROLE_USER') CHECK (
        user_role IN ('ROLE_CUSTOMER', 'ROLE_DESIGNER', 'ROLE_ADMIN')
    ),
    join_path VARCHAR(5) NOT NULL DEFAULT('HOME') CHECK (
        join_path IN ('HOME', 'KAKAO', 'NAVER')
    ),
    CONSTRAINT user_email_fk FOREIGN KEY (user_email) REFERENCES email_auth_number (email)
);

## 공지사항 게시물 테이블 생성
CREATE TABLE announcement_board (
    board_number INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    contents TEXT NOT NULL,
    writer_id VARCHAR(50) NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT(now()),
    view_count INT NOT NULL DEFAULT(0),
    comment TEXT,
    CONSTRAINT writer_id_fk FOREIGN KEY (writer_id) REFERENCES user (user_id)
);
## 트렌드 게시물 테이블 생성
CREATE TABLE trend_board (
    board_number INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    contents LONGTEXT NOT NULL,
    writer_id VARCHAR(50) NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT(now()),
    view_count INT NOT NULL DEFAULT(0),
    comment TEXT,
    trend_board_thumbnail_image LONGTEXT NOT NULL,
    CONSTRAINT writer_id_fk FOREIGN KEY (writer_id) REFERENCES user (user_id)
);

## Q&A 게시물 테이블 생성
CREATE TABLE qna_board (
    board_number INT PRIMARY KEY AUTO_INCREMENT,
    status BOOLEAN NOT NULL DEFAULT(false),
    title VARCHAR(100) NOT NULL,
    contents TEXT NOT NULL,
    writer_id VARCHAR(50) NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT(now()),
    view_count INT NOT NULL DEFAULT(0),
    comment TEXT,
    CONSTRAINT writer_id_fk FOREIGN KEY (writer_id) REFERENCES user (user_id)
);
## 고객 게시물 테이블 생성
CREATE TABLE customer_board (
    board_number INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    contents TEXT NOT NULL,
    writer_id VARCHAR(50) NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT(now()),
    view_count INT NOT NULL DEFAULT(0),
    comment TEXT,
    CONSTRAINT writer_id_fk FOREIGN KEY (writer_id) REFERENCES user (user_id)
);
## 디자이너 게시물 테이블 생성
CREATE TABLE degsiner_board (
    board_number INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    contents TEXT NOT NULL,
    writer_id VARCHAR(50) NOT NULL,
    write_datetime DATETIME NOT NULL DEFAULT(now()),
    view_count INT NOT NULL DEFAULT(0),
    comment TEXT,
    CONSTRAINT writer_id_fk FOREIGN KEY (writer_id) REFERENCES user (user_id)
);

DROP TABLE trend_board_image

## 개발자 계정 생성
CREATE USER 'developer' @'%' IDENTIFIED BY 'P!ssw0rd';

GRANT ALL PRIVILEGES ON estate.* TO 'developer' @'%';