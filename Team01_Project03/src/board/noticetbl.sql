-- 공지사항 시퀀스
CREATE SEQUENCE seq_Notice_num
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99999
    NOMINVALUE
    NOCYCLE;

-- 공지사항 테이블
create table Noticetbl(
    noc_number varchar2(8) primary key,
    noc_title varchar2(100),
    noc_content varchar2(4000),
    noc_date date,
    mit_id varchar2(12)
);
  
-- 더미데이터
insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '공지사항', '오늘점심은...', sysdate, 'master');


commit;
