package reserve;

public class ReserveDTO {
    // 멤버 변수 선언
    private int resnumber;				// 예약 번호
    private int actnumber;				// 숙소 번호
    private java.sql.Date resstart;		// 체크인 날짜
    private java.sql.Date resend;		// 체크아웃 날짜
    private String resname;				// 예약자 명
    private String resphone;			// 예약자 전화번호
    private String respurchase;			// 예약 지불수단
    private String resprice;			// 예약 가격
    private String reshotel;			// 예약 숙소명
    private String resid;				// 예약자 id
    private String rescancle;			// 예약 취소여부
    
    
 // getter setter ---------------------------------------------
	public String getRescancle() {
		return rescancle;
	}
	public void setRescancle(String rescancle) {
		this.rescancle = rescancle;
	}
	public String getResid() {
		return resid;
	}
	public void setResid(String resid) {
		this.resid = resid;
	}
	public String getReshotel() {
		return reshotel;
	}
	public void setReshotel(String reshotel) {
		this.reshotel = reshotel;
	}
	public int getResnumber() {
		return resnumber;
	}
	public void setResnumber(int resnumber) {
		this.resnumber = resnumber;
	}
	public int getActnumber() {
		return actnumber;
	}
	public void setActnumber(int actnumber) {
		this.actnumber = actnumber;
	}
	public java.sql.Date getResstart() {
		return resstart;
	}
	public void setResstart(java.sql.Date resstart) {
		this.resstart = resstart;
	}
	public java.sql.Date getResend() {
		return resend;
	}
	public void setResend(java.sql.Date resend) {
		this.resend = resend;
	}
	public String getResname() {
		return resname;
	}
	public void setResname(String resname) {
		this.resname = resname;
	}
	public String getResphone() {
		return resphone;
	}
	public void setResphone(String resphone) {
		this.resphone = resphone;
	}
	public String getRespurchase() {
		return respurchase;
	}
	public void setRespurchase(String respurchase) {
		this.respurchase = respurchase;
	}
	public String getResprice() {
		return resprice;
	}
	public void setResprice(String resprice) {
		this.resprice = resprice;
	}
	// getter setter ---------------------------------------------
    

   

}
