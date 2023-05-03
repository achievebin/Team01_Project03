package board;

public class NoticetblDTO {
    // 멤버 변수 선언
    private String noc_num;
    private String noc_title;
    private String noc_content;
    private String mit_id;
    private java.sql.Date postdate;
	public String getNoc_num() {
		return noc_num;
	}
	public void setNoc_num(String noc_num) {
		this.noc_num = noc_num;
	}
	public String getNoc_title() {
		return noc_title;
	}
	public void setNoc_title(String noc_title) {
		this.noc_title = noc_title;
	}
	public String getNoc_content() {
		return noc_content;
	}
	public void setNoc_content(String noc_content) {
		this.noc_content = noc_content;
	}
	public String getMit_id() {
		return mit_id;
	}
	public void setMit_id(String mit_id) {
		this.mit_id = mit_id;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
    
    // 게터/세터
    
}
