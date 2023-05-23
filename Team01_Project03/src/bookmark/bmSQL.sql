--북마크 psmt.setString(2, dto.getActNumber()); 테이블
create table bookmarktbl (bm_number number(5)primary key,bm_id varchar2(20),
    act_number number(5));
    
--북마크 시퀀스
create sequence seq_bm_num 
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;