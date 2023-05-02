package member;

import java.sql.Date;

public class MemberDto {
	// 멤버 변수 선언
	private String id;
	private String pw;
	private String name;
	private java.sql.Date birth;
	private String sex;
	private String address;
	private String phone;
	private String email;
	
	public MemberDto() {}
	
	public MemberDto(String id, String pw, String name, Date birth, String sex, String address, String phone,
			String email) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.birth = birth;
		this.sex = sex;
		this.address = address;
		this.phone = phone;
		this.email = email;
	}

	// 멤버 변수별 게터와 세터
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public java.sql.Date getBirth() {
		return birth;
	}

	public void setBirth(java.sql.Date birth) {
		this.birth = birth;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}
