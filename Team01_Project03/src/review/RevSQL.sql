-- 리뷰 테이블
create table Reviewtbl(
    rev_number number(4) primary key,
    rev_title varchar2(100) ,
    rev_content varchar2(1000) ,
    rev_date date default(sysdate),
    rev_score number(2) default(10) ,
    rev_id varchar2(20),
    rev_hotel varchar2(20),
    act_number number(4));
    
--리뷰번호 시퀀스
create sequence seq_rev_num 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;