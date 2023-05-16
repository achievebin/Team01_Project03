-- 회원가입 테이블 생성
create table memberidtbl (
    mit_number number(5) primary key,
    mit_id varchar2(12) not null UNIQUE,
    mit_pw varchar2(12) not null,
    mit_name varchar2(12) not null,
    mit_nickname varchar(48) not null,
    mit_birth date not null,
    mit_sex varchar2(6) not null,
    mit_address varchar2(50) not null,
    mit_phone varchar2(20) not null UNIQUE,
    mit_email varchar2(40) not null UNIQUE,
    mit_grade varchar2(10) default 'bronze' not null,
    mit_sdate date not null
);

-- 회원가입을 위한 시퀀스 생성
create sequence member_seq
increment by 1
start with 1
minvalue 1
maxvalue 99999
nocycle
nocache
noorder;

drop table memberidtbl;
drop sequence member_seq;

commit;