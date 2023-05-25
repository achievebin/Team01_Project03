package member;

import connect.JDBConnect;

public class MemberDao extends JDBConnect {
	/* JNDI(Java Naming and Directory Interface)로 명시한
	데이터베이스로의 연결이 완료된 MemberDAO 객체를 생성합니다. */
	public MemberDao(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}
	
	//회원가입: 기입한 정보를 회원 테이블에 추가합니다.
	public int join(MemberDto dto) {
		int result = 0;
		String query =  "INSERT INTO memberidtbl VALUES"
		+ "(SEQ_MEMBER_NUM.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, DEFAULT, TRUNC(SYSDATE))";
		
		try {
			psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getId()); 
            psmt.setString(2, dto.getPw());
            psmt.setString(3, dto.getName());
            psmt.setString(4, dto.getNickname());
            psmt.setDate(5, dto.getBirth());
            psmt.setString(6, dto.getSex());
            psmt.setString(7, dto.getAddress());
            psmt.setString(8, dto.getPhone());
            psmt.setString(9, dto.getEmail());
            result = psmt.executeUpdate();
		} catch (Exception e) {
        	e.printStackTrace();
        }
		return result;
	}
	
	//아이디 중복 체크: 기입한 아이디가 회원정보에 존재할 경우 0을, 부존재할 경우 1을 반환합니다.
	public int checkValidId(String cvid) {
		int result = -1;
		String query = "SELECT mit_id FROM memberidtbl WHERE mit_id=?";
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query); // 동적 쿼리문 준비
			psmt.setString(1, cvid);
			rs = psmt.executeQuery();
			if (rs.next()) {
				result = 0;
			} else {
				result = 1;
			}
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
            	dto.setNickname(rs.getString("mit_nickname"));
            	dto.setGrade(rs.getString("mit_grade"));
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//아이디 찾기: 기입한 이름·전화번호와 일치하는 회원의 아이디를 반환합니다.
	public String findMyId(String yname, String yphone) {
		String yid = null;
		String query = "SELECT mit_id FROM memberidtbl WHERE mit_name=? AND mit_phone=?";
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query); // 동적 쿼리문 준비
			psmt.setString(1, yname);
			psmt.setString(2, yphone);
			rs = psmt.executeQuery();
			if (rs.next()) {
				yid = rs.getString("mit_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return yid;
	}
	//비밀번호 찾기: 기입한 이름·전화번호·아이디와 일치하는 회원의 패스워드를 반환합니다.
	public String findMyPwd(String yname, String yphone, String yid) {
		String ypw = null;
		String query = "SELECT mit_pw FROM memberidtbl WHERE mit_name=? AND mit_phone=? AND mit_id=?";
		
		try {
			// 쿼리 실행
			psmt = con.prepareStatement(query); // 동적 쿼리문 준비
			psmt.setString(1, yname);
			psmt.setString(1, yphone);
			psmt.setString(1, yid);
			rs = psmt.executeQuery();
			if (rs.next()) {
				yid = rs.getString("mit_pw");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ypw;
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
				dto.setNickname(rs.getString("mit_nickname"));
				dto.setBirth(rs.getDate("mit_birth"));
				dto.setSex(rs.getString("mit_sex"));
				dto.setAddress(rs.getString("mit_address"));
				dto.setPhone(rs.getString("mit_phone"));
				dto.setEmail(rs.getString("mit_email"));
				dto.setGrade(rs.getString("mit_grade"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	
	//회원정보수정: 아이디와 일치하는 회원 정보를 찾은 후 기입한 정보로 갱신합니다.
	public int update(MemberDto dto) {
		int result = 0;
		String query = "UPDATE memberidtbl SET mit_pw=?, mit_name=?, mit_nickname=?, mit_birth=?,"
						+ "mit_sex= ?, mit_address=?, mit_phone=?,"
						+ "mit_email=? WHERE mit_id=?";
		try {
			psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getPw());
            psmt.setString(2, dto.getName());
            psmt.setString(3, dto.getNickname());
            psmt.setDate(4, dto.getBirth());
            psmt.setString(5, dto.getSex());
            psmt.setString(6, dto.getAddress());
            psmt.setString(7, dto.getPhone());
            psmt.setString(8, dto.getEmail());
            psmt.setString(9, dto.getId());
            result = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//회원탈퇴: 기입한 아이디·패스워드와 일치하는 회원 정보를 찾은 후 정보를 삭제합니다.
	public int withdraw(String wdid, String wdpw) {
		int result = 0;
		String query = "DELETE FROM memberidtbl WHERE mit_id=? AND mit_pw=?";
		try {
			psmt = con.prepareStatement(query); 
			psmt.setString(1, wdid);
			psmt.setString(2, wdpw);
			result = psmt.executeUpdate();
           } catch (Exception e) {
            	e.printStackTrace();
           }
		return result;
	}
}