-- 공지사항 시퀀스 생성
CREATE SEQUENCE seq_board_num
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
  
-- 예시 코드
insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '첫번째 공지사항', '나와라 공지사항', sysdate, 'master');


commit;
