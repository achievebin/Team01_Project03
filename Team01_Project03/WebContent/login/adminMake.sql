  --관리자 계정 생성
  INSERT INTO memberidtbl (mit_number, mit_id, mit_pw, mit_name, mit_nickname, mit_birth, mit_sex, mit_address, mit_phone, mit_email, mit_grade, mit_sdate)
  VALUES (
    SEQ_MEMBER_NUM.nextval,
    'admin01',
    'Admin!@pw01',
    '관리자',
    'admin',
    TO_DATE('1990-01-01', 'YYYY-MM-DD'),
    'Male',
    '서울',
    '010-1234-1234',
    'sample@example.com',
    'admin',
    SYSDATE
);  
  --유저 계정 생성
  INSERT INTO memberidtbl (mit_number, mit_id, mit_pw, mit_name, mit_nickname, mit_birth, mit_sex, mit_address, mit_phone, mit_email, mit_grade, mit_sdate)
  VALUES (
    SEQ_MEMBER_NUM.nextval,
    'user01',
    'User!@pw01',
    '유저',
    'user',
    TO_DATE('1991-01-01', 'YYYY-MM-DD'),
    'Male',
    '서울',
    '010-1234-5678',
    'sample1@example.com',
    'bronze',
    SYSDATE
)