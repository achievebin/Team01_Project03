--예약 테이블
create table reservationtbl(
    res_number number(5)primary key,
    act_number number(5) ,
    res_start date,
    res_end date,
    res_name varchar2(30),
    res_phone varchar2(30),
    res_purchase varchar2(30),
    res_price varchar2(30),
    res_hotel varchar2(30));   
    
--예약번호 시퀀스
create sequence seq_res_num 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
    
--예약 여부 컬럼 추가
alter table reservationtbl add res_cancle varchar(25) default '예약됨';