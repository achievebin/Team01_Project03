-- 숙소 목록
declare
  i number;
begin
  -- 숙소 목록
  -- ACCOMMODATIONTBL 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'ACCOMMODATIONTBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table ACCOMMODATIONTBL';
  end if;
  -- seq_act_num 시퀀스의 존재 여부 확인
  select count(*) into i from user_sequences where sequence_name = 'SEQ_ACT_NUM';
  -- 시퀀스가 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop sequence seq_act_num';
  end if;
  -- 공지사항
  -- 공지사항 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'NOTICETBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table NOTICETBL';
  end if;
  -- 공지사항 시퀀스의 존재 여부 확인
  select count(*) into i from user_sequences where sequence_name = 'SEQ_NOTICE_NUM';
  -- 시퀀스가 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop sequence SEQ_NOTICE_NUM';
  end if;
  -- 북마크
  -- 북마크 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'BOOKMARKTBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table BOOKMARKTBL';
  end if;
  -- 북마크 시퀀스의 존재 여부 확인
  select count(*) into i from user_sequences where sequence_name = 'SEQ_BM_NUM';
  -- 시퀀스가 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop sequence SEQ_BM_NUM';
  end if;
  --회원가입
  -- 질문과 답변 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'QNATBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table QNATBL';
  end if;
  -- 회원가입 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'MEMBERIDTBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table MEMBERIDTBL';
  end if;
  -- 회원가입 시퀀스의 존재 여부 확인
  select count(*) into i from user_sequences where sequence_name = 'SEQ_MEMBER_NUM';
  -- 시퀀스가 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop sequence SEQ_MEMBER_NUM';
  end if;
  -- 질문과 답변
  -- 질문과 답변 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'QNATBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table QNATBL';
  end if;
  -- 질문과 답변 시퀀스의 존재 여부 확인
  select count(*) into i from user_sequences where sequence_name = 'SEQ_QNA_NUM';
  -- 시퀀스가 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop sequence SEQ_QNA_NUM';
  end if;
  -- 예약
  -- 예약 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'RESERVATIONTBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table RESERVATIONTBL';
  end if;
  -- 예약번호 시퀀스의 존재 여부 확인
  select count(*) into i from user_sequences where sequence_name = 'SEQ_RES_NUM';
  -- 시퀀스가 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop sequence SEQ_RES_NUM';
  end if;
  -- 리뷰
  -- 리뷰 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'REVIEWTBL';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table REVIEWTBL';
  end if;
  -- 리뷰번호 시퀀스의 존재 여부 확인
  select count(*) into i from user_sequences where sequence_name = 'SEQ_REV_NUM';
  -- 시퀀스가 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop sequence SEQ_REV_NUM';
  end if;
  -- 리뷰 점수
  -- 리뷰점수 테이블의 존재 여부 확인
  select count(*) into i from all_tables where table_name = 'REVIEW_SCORE';
  -- 테이블이 존재하는 경우 삭제
  if i > 0 then
    execute immediate 'drop table REVIEW_SCORE';
  end if;
  -- seq_act_num 시퀀스 생성
  execute immediate 'create sequence seq_act_num 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache';
  -- ACCOMMODATIONTBL 테이블 생성
  execute immediate 'create table ACCOMMODATIONTBL (
    act_number number(5) primary key,
    act_name varchar2(100) not null,
    act_address varchar2(100) not null,
    act_phone varchar2(20) unique not null,
    act_room number(10) not null,
    act_info varchar2(1000),
    act_id varchar2(30),
    act_price number(30),
    act_leftroom number(4),
    act_div varchar2(30))';
  -- 공지사항 시퀀스 생성
  execute immediate 'CREATE SEQUENCE SEQ_NOTICE_NUM
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99999
    NOMINVALUE
    NOCYCLE';
  -- 공지사항 테이블 생성
  execute immediate 'create table NOTICETBL (
    noc_number varchar2(8) primary key,
    noc_title varchar2(100),
    noc_content varchar2(4000),
    noc_date date,
    mit_id varchar2(12))';
  -- 북마크 시퀀스 생성
  execute immediate 'create sequence SEQ_BM_NUM 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache';
  -- 북마크 테이블 생성
  execute immediate 'create table BOOKMARKTBL (
    bm_number number(5) primary key,
    bm_id varchar2(20),
    act_number number(5)
  )';
  -- 회원가입 시퀀스 생성
  execute immediate 'create sequence SEQ_MEMBER_NUM 
    increment by 1
    start with 1
    minvalue 1
    maxvalue 99999
    nocycle
    nocache
    noorder';
  -- 회원가입 테이블 생성
  execute immediate 'create table MEMBERIDTBL (
    mit_number number(5) primary key,
    mit_id varchar2(12) not null unique,
    mit_pw varchar2(12) not null,
    mit_name varchar2(12) not null,
    mit_nickname varchar(48) not null,
    mit_birth date not null,
    mit_sex varchar2(6) not null,
    mit_address varchar2(50) not null,
    mit_phone varchar2(20) not null unique,
    mit_email varchar2(40) not null unique,
    mit_grade varchar2(10) default ''bronze'' not null,
    mit_sdate date not null)';  
  -- 질문과 답변 시퀀스 생성
  execute immediate 'create sequence SEQ_QNA_NUM 
    increment by 1
    start with 1
    minvalue 1
    maxvalue 99999
    nocycle
    nocache
    noorder';
  -- 질문과 답변 테이블 생성
  execute immediate 'create table QNATBL (
    qa_number number(5) primary key,
    qa_question varchar2(4000) not null,
    qa_answer varchar2(4000) not null,
    qa_date date,
    mit_id varchar2(12) not null,
    constraint fk_mit_id foreign key (mit_id) references MEMBERIDTBL(mit_id))';
  -- 예약번호 시퀀스 생성
  execute immediate 'create sequence SEQ_RES_NUM 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache';
  -- 예약 테이블 생성
  execute immediate 'create table RESERVATIONTBL (
    res_number number(5) primary key,
    act_number number(5),
    res_start date,
    res_end date,
    res_name varchar2(30),
    res_phone varchar2(30),
    res_purchase varchar2(30),
    res_price varchar2(30),
    res_hotel varchar2(30),
    res_id varchar2(30),
    res_cancle varchar2(15) default ''예약됨'')';
  -- 리뷰번호 시퀀스 생성
  execute immediate 'create sequence SEQ_REV_NUM 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache';
  -- 리뷰 테이블 생성
  execute immediate 'create table REVIEWTBL (
    rev_number number(4) primary key,
    rev_title varchar2(100),
    rev_content varchar2(1000),
    rev_date date default(sysdate),
    rev_score number(2) default(10),
    rev_id varchar2(20),
    rev_hotel varchar2(20),
    act_number number(4))';
  -- 리뷰점수 테이블 생성
  execute immediate 'create table REVIEW_SCORE (
    act_number number(30) primary key,
    hotel varchar2(30),
    count_all number(30),
    rev_avg number(30,2),
    count5 number(30),
    count4 number(30),
    count3 number(30),
    count2 number(30),
    count1 number(30))';
end;