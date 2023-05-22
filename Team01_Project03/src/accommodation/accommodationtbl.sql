-- 숙박업소
create table accommodationtbl (
    act_number number(5) primary key,
    act_name varchar2(100),
    act_address varchar2(100),
    act_phone varchar2(20) UNIQUE,
    act_room varchar2(4),
    act_rcheck varchar2(3)
);

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (1, '호텔 A', '서울특별시 강남구 역삼동 123-45', '02-123-4567', '20', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (2, '모텔 B', '서울특별시 강남구 청담동 678-90', '02-555-1234', '10', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (3, '호텔 C', '서울특별시 마포구 서교동 456-78', '02-222-3333', '30', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (4, '모텔 D', '서울특별시 종로구 관수동 135-79', '02-777-8888', '8', 'N');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (5, '호텔 E', '서울특별시 강서구 방화동 567-89', '02-444-5555', '35', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (6, '호텔 F', '서울특별시 강북구 미아동 246-80', '02-666-7777', '40', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (7, '모텔 G', '서울특별시 송파구 잠실동 135-79', '02-888-9999', '7', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (8, '호텔 H', '서울특별시 강동구 천호동 567-89', '02-111-2222', '15', 'N');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (9, '모텔 I', '서울특별시 서초구 방배동 345-67', '02-333-4444', '10', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (10, '호텔 J', '서울특별시 강남구 삼성동 678-90', '02-999-0000', '25', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (11, '모텔 K', '서울특별시 마포구 공덕동 123-45', '02-222-1111', '6', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (12, '호텔 L', '서울특별시 중구 남대문로 123', '02-777-6666', '40', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (13, '모텔 M', '서울특별시 종로구 관철동 246-80', '02-333-2222', '5', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (14, '호텔 N', '서울특별시 강북구 수유동 135-79', '02-555-4444', '36', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (15, '모텔 O', '서울특별시 송파구 잠실동 567-89', '02-888-7777', '12', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (16, '호텔 P', '서울특별시 강남구 역삼동 123-45', '02-123-4568', '20', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (17, '모텔 Q', '서울특별시 강남구 청담동 678-90', '02-555-1235', '10', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (18, '호텔 R', '서울특별시 마포구 서교동 456-78', '02-222-3334', '30', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (19, '모텔 S', '서울특별시 종로구 관수동 135-79', '02-777-8889', '8', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (20, '호텔 T', '서울특별시 강서구 방화동 567-89', '02-444-5556', '35', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (21, '호텔 U', '서울특별시 강북구 미아동 246-80', '02-666-7778', '40', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (22, '모텔 V', '서울특별시 송파구 잠실동 135-79', '02-888-9990', '7', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (23, '호텔 W', '서울특별시 강동구 천호동 567-89', '02-111-2223', '15', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (24, '모텔 X', '서울특별시 서초구 방배동 345-67', '02-333-4445', '10', 'Y');

INSERT INTO accommodationtbl (act_number, act_name, act_address, act_phone, act_room, act_rcheck)
VALUES (25, '호텔 Y', '서울특별시 강남구 삼성동 678-90', '02-999-0001', '25', 'Y');



select * from accommodationtbl;

commit;


drop table accommodationtbl;

