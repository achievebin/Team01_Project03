package accommodation;

public class AccommodationDTO {
	//맴버변수 선언
    private String act_number;     // 숙박업소 순번
    private String act_name;       // 숙박업소 이름
    private String act_address;    // 숙박업소 소재지
    private String act_phone;      // 숙박업소 전화번호
    private String act_room;       // 총 객실 수
    private String act_rcheck;     // 예약 가능 여부
    
    //게터/세터
  	public String getAct_number() {
  		return act_number;
  	}
  	public void setAct_number(String act_number) {
  		this.act_number = act_number;
  	}
  	public String getAct_name() {
  		return act_name;
  	}
  	public void setAct_name(String act_name) {
  		this.act_name = act_name;
  	}
  	public String getAct_address() {
  		return act_address;
  	}
  	public void setAct_address(String act_address) {
  		this.act_address = act_address;
  	}
  	public String getAct_phone() {
  		return act_phone;
  	}
  	public void setAct_phone(String act_phone) {
  		this.act_phone = act_phone;
  	}
  	public String getAct_room() {
  		return act_room;
  	}
  	public void setAct_room(String act_room) {
  		this.act_room = act_room;
  	}
  	public String getAct_rcheck() {
  		return act_rcheck;
  	}
  	public void setAct_rcheck(String act_rcheck) {
  		this.act_rcheck = act_rcheck;
  	}
  	
 }
