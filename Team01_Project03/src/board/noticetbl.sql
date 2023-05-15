-- �������� ������ ����
CREATE SEQUENCE seq_board_num
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99999
    NOMINVALUE
    NOCYCLE;

-- �������� ���̺�    
create table Noticetbl(
    noc_number varchar2(8) primary key,
    noc_title varchar2(100),
    noc_content varchar2(4000),
    noc_date date,
    mit_id varchar2(12)
);
  
-- ���� �ڵ�
insert into Noticetbl
values (seq_Notice_num.NEXTVAL, 'ù��° ��������', '���Ͷ� ��������', sysdate, 'master');


commit;
