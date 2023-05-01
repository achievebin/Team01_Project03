package member;

import java.sql.Date;

import connect.JDBConnect;

public class MemberDao extends JDBConnect {
	/* JNDI(Java Naming and Directory Interface)로 명시한
	데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성합니다. */
	public MemberDao(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	public MemberDto join(String jnid, String jnpw, String jnname, Date jnbirth, String jnsex, String jnaddress, String jnphone,
			String jnemail) {
		MemberDto dto = new MemberDto();
		String query =  "INSERT INTO memberidtable VALUES (member_seq.NEXTVAL,"
						+ "?, ?, ?, ?, ?, ?, TRUNC(SYSDATE))";
		
		try {
			psmt = con.prepareStatement(query);
            psmt.setString(1, jnid); 
            psmt.setString(2, jnpw);
            psmt.setString(3, jnname);
            psmt.setDate(4, jnbirth);
            psmt.setString(5, jnsex);
            psmt.setString(6, jnaddress);
            psmt.setString(7, jnphone);
            psmt.setString(8, jnemail);
            rs = psmt.executeQuery();
            
            if (rs.next()) {
            	dto.setId(rs.getString("id"));
            	dto.setPw(rs.getString("pw"));
            	dto.setName(rs.getString("name"));
            	dto.setBirth(rs.getDate("birth"));
            	dto.setSex(rs.getString("sex"));
            	dto.setAddress(rs.getString("address"));
            	dto.setPhone(rs.getString("phone"));
            	dto.setEmail(rs.getString("email"));
            } 
		} catch (Exception e) {
        	e.printStackTrace();
        }
		return dto;
	}
	
	// 명시한 아이디/패스워드와 일치하는 회원 정보를 반환합니다.
	public MemberDto signIn(String siid, String sipw) {
		MemberDto dto = new MemberDto(); // 회원 정보 DTO 객체 생성
		String query = "SELECT * FROM memberidtable WHERE mit_id=? AND mit_pw=?";
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query); // 동적 쿼리문 준비
            psmt.setString(1, siid); 
            psmt.setString(2, sipw);
            rs = psmt.executeQuery();
            
            // 결과 처리
            if (rs.next()) {
            	// 쿼리 결과로 얻은 회원 정보를 DTO 객체에 저장
            	dto.setId(rs.getString("id"));
            	dto.setPw(rs.getString("pw"));
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public MemberDto update(String upid, String uppw, String upname, Date upbirth, String upsex, String upaddress, String upphone,
			String upemail) {
		MemberDto dto = new MemberDto();
		String query = "UPDATE memberidtable SET mit_pw=?, mit_name=?, mit_birth=?,"
						+ "mit_sex= ?, mit_address=?, mit_phone=?,"
						+ "mit_email=? WHERE mit_id=?";
		try {
			psmt = con.prepareStatement(query); 
            psmt.setString(1, uppw);
            psmt.setString(2, upname);
            psmt.setDate(3, upbirth);
            psmt.setString(4, upsex);
            psmt.setString(5, upaddress);
            psmt.setString(6, upphone);
            psmt.setString(7, upemail);
            psmt.setString(8, upid);
            rs = psmt.executeQuery();
			if (rs.next()) {
            	dto.setPw(rs.getString("pw"));
            	dto.setName(rs.getString("name"));
            	dto.setBirth(rs.getDate("birth"));
            	dto.setSex(rs.getString("sex"));
            	dto.setAddress(rs.getString("address"));
            	dto.setPhone(rs.getString("phone"));
            	dto.setEmail(rs.getString("email"));
            	dto.setId(rs.getString("id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public  MemberDto withdraw(String wdid) {
		MemberDto dto = new MemberDto();
		String query = "DELETE FROM memberidtable WHERE mit_id=?";
		try {
			psmt = con.prepareStatement(query); 
            psmt.setString(1, wdid);
            rs = psmt.executeQuery();
            
            if (rs.next()) {
            	dto.setId(rs.getString("id"));
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
}
