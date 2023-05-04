package Review;

public class ReviewDTO {
    // 멤버 변수 선언
    private String num;
    private String title;
    private String content;
    private String id;
    private int score;
	private java.sql.Date postdate;
    private String visitcount;
    private int avgScore;
    private int cntScore;
    private String hotel;
    private int actNumber;
   
	// 게터/세터
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
	public int getActNumber() {
		return actNumber;
	}
	public void setActNumber(int actNumber) {
		this.actNumber = actNumber;
	}
	
}
