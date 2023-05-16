--숙소 테이블
create table accommodationtbl(
    act_number number(5) primary key,
    act_name varchar2(100) not null,
    act_address varchar2(100) not null,
    act_phone varchar2(20) not null,
    act_room number(10) not null,
    act_info varchar2(1000),
    act_id varchar2(30),
    act_price number(30),
    act_leftroom number(4));
    
--숙소번호 시퀀스
create sequence seq_act_num 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;