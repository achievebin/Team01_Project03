package review;

public class ReviewDTO {
    // 멤버 변수 선언
    private String num;					// 리뷰 넘버
    private String title;				// 리뷰 제목
    private String content;				// 리뷰 내용
    private String id;					// 리뷰 작성자 ID
    private int score;					// 리뷰 점수
	private java.sql.Date postdate;		// 리뷰 작성 날짜
    private String visitcount;			// 리뷰 조회수
    private int avgScore;				// 리뷰 평균점수
    private int cntScore;				// 리뷰 총 갯수
    private String hotel;				// 리뷰한 숙소 명
    private String actNumber;			// 리뷰한 숙소 번호
   
    // getter setter ---------------------------------------------
    public String getNum() {
        return num;
    }
    public void setNum(String num) {
        this.num = num;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public java.sql.Date getPostdate() {
        return postdate;
    }
    public void setPostdate(java.sql.Date postdate) {
        this.postdate = postdate;
    }
    public String getVisitcount() {
        return visitcount;
    }
    public void setVisitcount(String visitcount) {
        this.visitcount = visitcount;
    }
    public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getAvgScore() {
			return avgScore;
		}
	public void setAvgScore(int avgScore) {
			this.avgScore = avgScore;
		}
	public int getCntScore() {
			return cntScore;
		}
	public void setCntScore(int cntScore) {
			this.cntScore = cntScore;
		}
	public String getHotel() {
		return hotel;
	}
	public void setHotel(String hotel) {
		this.hotel = hotel;
	}
	public String getActNumber() {
		return actNumber;
	}
	public void setActNumber(String actNumber) {
		this.actNumber = actNumber;
	}
	// getter setter ---------------------------------------------
	
}