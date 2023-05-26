insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '[안내] 서비스 점검 안내', 
'시스템 점검 안내
1. 점검 일정:
- 2023년 5월 24일(화) 오후 12시 40분 ~ 17시 40분 (5시간)

2. 점검 사유:
- 시스템 업그레이드

3. 점검 영향:
- 점검 시간 동안 저기어때 서비스 이용 불가

점검 시간은 변경될 수 있으며 변경 시 공지를 통해 안내 드리겠습니다.
감사합니다.
', sysdate, 'master');

insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '[안내] 서비스이용약관 변경 안내', 
'안녕하세요.
서비스이용약관이 변경됩니다.
감사합니다.
', sysdate, 'master');

insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '[이벤트] 5월 페이백 이벤트', 
'5월 페이벡 이벤트에 대해 안내드립니다.
이벤트 진행기간
2023년 5월 24일(화) ~ 2023년 5월 30일(화) (7일간)
감사합니다.
', sysdate, 'master');

insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '[안내] 긴급 점검 안내', 
'시스템 점검 안내
1. 점검 일정:
- 2023년 5월 25일(화) 오후 13시 40분 ~ 15시 40분 (2시간)

2. 점검 사유:
- 오류 수정

3. 점검 영향:
- 점검 시간 동안 저기어때 서비스 이용 불가

점검 시간은 변경될 수 있으며 변경 시 공지를 통해 안내 드리겠습니다.
불편을 끼쳐드려 죄송합니다.
', sysdate, 'master');

insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '[안내] 긴급 점검 안내', 
'시스템 점검 안내
1. 점검 일정:
- 2023년 5월 25일(화) 오후 13시 40분 ~ 15시 40분 (2시간)

2. 점검 사유:
- 오류 수정

3. 점검 영향:
- 점검 시간 동안 저기어때 서비스 이용 불가

점검 시간은 변경될 수 있으며 변경 시 공지를 통해 안내 드리겠습니다.
불편을 끼쳐드려 죄송합니다.
', sysdate, 'master');

insert into Noticetbl
values (seq_Notice_num.NEXTVAL, '[이벤트] 5월 2차 저기어때 응원하기 이벤트 ', 
'안녕하세요.
저기어때 응원하기 이벤트 5월 2차 당첨은
내부 사정으로 인하여 한주 쉬어가게 되었습니다.

앞으로도 고객님께 더욱 즐거운 혜택을 드릴 수 있도록 끊임없이 고민하고 노력하는 저기어때가 되겠습니다.
많은 관심과 성원 부탁드립니다.

감사합니다.
', sysdate, 'master');

select * from Noticetbl;

commit;