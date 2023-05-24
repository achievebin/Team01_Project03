-- 질문과 답변 시퀀스
CREATE SEQUENCE seq_QnA_num
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99999
    NOMINVALUE
    NOCYCLE;

-- 질문과 답변 테이블
create table qnatbl(
    qna_number varchar2(8) primary key,
    qna_pb varchar2(10) default 0,
    qna_title varchar2(100),
    qna_content varchar2(4000),
    qna_date date,
    mit_id varchar2(12),
    
    --외래키 설정
    ConSTrAint fk_mit_id foreign key(mit_id)
    references memberidtbl(mit_id)
    
);
  
-- 더미데이터
insert into qnatbl
values (seq_QnA_num.NEXTVAL,  0, '저기', '오늘점심은 뭔가요 선생님', sysdate, 'tester');


insert into qnatbl
values (seq_QnA_num.NEXTVAL,  1, '테스트', '나에게 질문하지 마시오', sysdate, 'tester');

-- 댓글을 위한 계층 생성
select  LEVEL,
        qna_number,
        qna_pb,
        LPAD(' ',4*(LEVEL-1)) || qna_title as qna_title,        
        qna_content,
        qna_date,
        mit_id
        from qnatbl
        start with qna_pb=0
        connect by prior qna_number = qna_pb
        order siblings by qna_number desc;
commit;
