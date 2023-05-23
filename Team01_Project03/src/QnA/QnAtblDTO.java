package QnA;

public class QnAtblDTO {
    // 멤버 변수 선언
	
	private int level;
    private String qna_number;
    private String qna_pb;
    private String qna_title;
    private String qna_content;
    private java.sql.Date postdate;
    private String mit_id;
    
    
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getQna_number() {
		return qna_number;
	}
	public void setQna_number(String qna_number) {
		this.qna_number = qna_number;
	}
	public String getQna_pb() {
		return qna_pb;
	}
	public void setQna_pb(String qna_pb) {
		this.qna_pb = qna_pb;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public String getMit_id() {
		return mit_id;
	}
	public void setMit_id(String mit_id) {
		this.mit_id = mit_id;
	}
    
    

}
