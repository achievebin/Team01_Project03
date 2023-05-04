package member;

import connect.JDBConnect;

public class MemberDao extends JDBConnect {
	/* JNDI(Java Naming and Directory Interface)로 명시한
	데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성합니다. */
	public MemberDao(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	//회원가입:
	public int join(MemberDto dto) {
		int result = 0;
		String query =  "INSERT INTO memberidtbl VALUES"
		+ "(member_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, TRUNC(SYSDATE))";
		
		try {
			psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getId()); 
            psmt.setString(2, dto.getPw());
            psmt.setString(3, dto.getName());
            psmt.setDate(4, dto.getBirth());
            psmt.setString(5, dto.getSex());
            psmt.setString(6, dto.getAddress());
            psmt.setString(7, dto.getPhone());
            psmt.setString(8, dto.getEmail());
            result = psmt.executeUpdate();
		} catch (Exception e) {
        	e.printStackTrace();
        }
		return result;
	}
	
	//로그인: 기입한 아이디·패스워드와 일치하는 회원 정보를 반환합니다.
	public MemberDto signIn(String siid, String sipw) {
		MemberDto dto = new MemberDto(); // 회원 정보 DTO 객체 생성
		String query = "SELECT * FROM memberidtbl WHERE mit_id=? AND mit_pw=?";
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query); // 동적 쿼리문 준비
            psmt.setString(1, siid); 
            psmt.setString(2, sipw);
            rs = psmt.executeQuery();
            
            // 결과 처리
            if (rs.next()) {
            	// 쿼리 결과로 얻은 회원 정보를 DTO 객체에 저장
            	dto.setId(rs.getString("mit_id"));
            	dto.setPw(rs.getString("mit_pw"));
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//내 페이지: 아이디와 일치하는 회원 정보를 반환합니다.
	public MemberDto getInfo(String gid) {
		MemberDto dto = new MemberDto();
		String query = "SELECT * FROM memberidtbl WHERE mit_id=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, gid);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto.setId(rs.getString("mit_id"));
				dto.setPw(rs.getString("mit_pw"));
				dto.setName(rs.getString("mit_name"));
				dto.setBirth(rs.getDate("mit_birth"));
				dto.setSex(rs.getString("mit_sex"));
				dto.setAddress(rs.getString("mit_address"));
				dto.setPhone(rs.getString("mit_phone"));
				dto.setEmail(rs.getString("mit_email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	
	//회원정보수정: 아이디와 일치하는 회원 정보를 찾아 수정한 정보를 갱신한다.
	public int update(MemberDto dto) {
		int result = 0;
		String query = "UPDATE memberidtbl SET mit_pw=?, mit_name=?, mit_birth=?,"
						+ "mit_sex= ?, mit_address=?, mit_phone=?,"
						+ "mit_email=? WHERE mit_id=?";
		try {
			psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getPw());
            psmt.setString(2, dto.getName());
            psmt.setDate(3, dto.getBirth());
            psmt.setString(4, dto.getSex());
            psmt.setString(5, dto.getAddress());
            psmt.setString(6, dto.getPhone());
            psmt.setString(7, dto.getEmail());
            psmt.setString(8, dto.getId());
            result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//회원탈퇴:
	public int withdraw(String wdid) {
		int result = 0;
		String query = "DELETE FROM memberidtbl WHERE mit_id=?";
		try {
			psmt = con.prepareStatement(query); 
            psmt.setString(1, wdid);
            result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
