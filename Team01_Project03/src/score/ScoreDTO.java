package score;

public class ScoreDTO {
    // 멤버 변수 선언
    private int actnum;		// 숙소 번호
    private int countall;	// 리뷰 총 갯수
    private int count5;		// 5점 갯수
    private int count4;		// 4점 갯수
    private int count3;		// 3점 갯수
    private int count2;		// 2점 갯수
    private int count1;		// 1점 갯수
    private int avgscore;	// 평균 점수
    private String hotel;	// 숙소 명

    // getter setter ---------------------------------------------
    public int getAvgScore() {
		return avgscore;
	}
	public void setAvgScore(int avgScore) {
		this.avgscore = avgScore;
	}
	public int getCountAll() {
		return countall;
	}
	public void setCountAll(int countall) {
		this.countall = countall;
	}
	public String getHotel() {
		return hotel;
	}
	public void setHotel(String hotel) {
		this.hotel = hotel;
	}
	public int getCount5() {
		return count5;
	}
	public void setCount5(int count5) {
		this.count5 = count5;
	}
	public int getCount4() {
		return count4;
	}
	public void setCount4(int count4) {
		this.count4 = count4;
	}
	public int getCount3() {
		return count3;
	}
	public void setCount3(int count3) {
		this.count3 = count3;
	}
	public int getCount2() {
		return count2;
	}
	public void setCount2(int count2) {
		this.count2 = count2;
	}
	public int getCount1() {
		return count1;
	}
	public void setCount1(int count1) {
		this.count1 = count1;
	}
	public int getActnum() {
		return actnum;
	}
	public void setActnum(int actnum) {
		this.actnum = actnum;
	}
	// getter setter ---------------------------------------------

}
