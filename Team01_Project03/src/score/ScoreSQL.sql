--리뷰점수 테이블
create table review_score(
    act_number number(30) primary key,
    hotel varchar2(30),
    count_all number(30),
    rev_avg number(30,2),
    count5 number(30),
    count4 number(30),
    count3 number(30),
    count2 number(30),
    count1 number(30));
