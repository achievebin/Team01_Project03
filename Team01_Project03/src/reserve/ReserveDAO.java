package reserve;


import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;

import act.ActDTO;
import connect.JDBConnect;

public class ReserveDAO extends JDBConnect {
    public ReserveDAO(ServletContext application) {
        super(application);
    }
    
    // 검색 조건에 맞는 게시물의 개수를 반환합니다.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수

        // 게시물 수를 얻어오는 쿼리문 작성
        String query = "SELECT COUNT(*) FROM Reviewtbl";
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%'";
        }

        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행
            rs.next();  // 커서를 첫 번째 행으로 이동
            totalCount = rs.getInt(1);  // 첫 번째 칼럼 값을 가져옴
        }
        catch (Exception e) {
            System.out.println("게시물 수를 구하는 중 예외 발생");
            e.printStackTrace();
        }

        return totalCount; 
    }

    // 지정한 게시물을 찾아 내용을 반환합니다.
    public ReserveDTO scoreView(String num) { 
    	ReserveDTO dto = new ReserveDTO();
        
        // 쿼리문 준비
        String query = "SELECT * FROM reservationtbl WHERE  res_number =?" ;

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) {
                dto.setResnumber(rs.getInt("res_number")); 
                dto.setActnumber(rs.getInt("act_number"));
                dto.setResstart(rs.getDate("res_start"));
                dto.setResend(rs.getDate("res_end"));
                dto.setResname(rs.getString("res_name"));
                dto.setResphone(rs.getString("res_phone"));
                dto.setRespurchase(rs.getString("res_purchase"));
                dto.setResprice(rs.getString("res_price").replace("/", ""));
                dto.setReshotel(rs.getString("res_hotel"));
                dto.setResid(rs.getString("res_id"));
                dto.setRescancle(rs.getString("res_cancle"));
               
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        
        return dto; 
    }
    // 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 기능 지원).
    public List<ReserveDTO> selectListPage(Map<String, Object> map) {
        List<ReserveDTO> bbs = new Vector<ReserveDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM reservationtbl "
                     + " where res_id = '"+ map.get("resid") +"'" ;
        // 검색 조건 추가 
		/*
		 * if (map.get("searchWord") != null) { query += " WHERE " +
		 * map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' "; }
		 */
        
        query += "      ORDER BY res_number DESC "
               + "     ) Tb "
               + " ) "
               + " WHERE rNum BETWEEN ? AND ?"; 

        try {
            // 쿼리문 완성 
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            
            
            // 쿼리문 실행 
            rs = psmt.executeQuery();
            

            
            
            while (rs.next()) {
                // 한 행(게시물 하나)의 데이터를 DTO에 저장
            	ReserveDTO dto = new ReserveDTO();
                dto.setResnumber(rs.getInt("res_number"));
                dto.setActnumber(rs.getInt("act_number"));
                dto.setResstart(rs.getDate("res_start"));
                dto.setResend(rs.getDate("res_end"));
                dto.setResname(rs.getString("res_name"));
                dto.setResphone(rs.getString("res_phone"));
                dto.setRespurchase(rs.getString("res_purchase"));
                dto.setResprice(rs.getString("res_price"));
                dto.setReshotel(rs.getString("res_hotel"));
                dto.setResid(rs.getString("res_id"));
                dto.setRescancle(rs.getString("res_cancle"));
                // 반환할 결과 목록에 게시물 추가
                bbs.add(dto);
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        
        // 목록 반환
        return bbs;
    }
    // 게시글 데이터를 받아 DB에 추가합니다. 
    public int insertWrite(ReserveDTO dto) {
        int result = 0;
        
        try {
            // INSERT 쿼리문 작성 
            String query = "insert into reservationtbl(res_number,"
            		+"act_number,res_start,res_end,res_name,res_phone,res_purchase,res_price, res_hotel,res_id)\n"
            		+ "values(seq_res_num.nextval, ?, ?, ?, ?, ?, ?, replace(?,'/',''), (select act_name from accommodationtbl where act_number = ?),?)";  

            psmt = con.prepareStatement(query);  // 동적 쿼리 
            psmt.setInt(1, dto.getActnumber());  
            psmt.setDate(2, dto.getResstart());
            psmt.setDate(3, dto.getResend());  
            psmt.setString(4, dto.getResname()); 
            psmt.setString(5, dto.getResphone()); 
            psmt.setString(6, dto.getRespurchase());
            psmt.setString(7, dto.getResprice()); 
            psmt.setInt(8, dto.getActnumber()); 
            psmt.setString(9, dto.getResid()); 
            result = psmt.executeUpdate(); 

        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 게시글 데이터를 받아 DB업데이트. 
    public int updateRoom(int actnumber) {
        int result = 0;
        
        try {
            // INSERT 쿼리문 작성 
            String query = "update accommodationtbl SET act_leftroom = act_room-(select count(*) "
            		+ "from reservationtbl where (sysdate between res_start and res_end) and act_number = ? and res_cancle = '예약됨')"
            		+ "where act_number = ?";
            psmt = con.prepareStatement(query);  // 동적 쿼리 
            psmt.setInt(1, actnumber);  
            psmt.setInt(2, actnumber);
            
            result = psmt.executeUpdate(); 
            
            

        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
    // 예약취소
    public int cancleReserve(ReserveDTO dto) { 
        int result = 0;

        try {
            // 쿼리문 템플릿
            String query = "update reservationtbl set res_cancle = "
            		+ " '취소됨' where res_number = ? "; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setInt(1, dto.getResnumber()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("예약취소 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
    
	/*
	 * public int datesearch(ReserveDTO dto) { int result = 0;
	 * 
	 * try { for ( int i = dto.getResstart().getDate(); i <
	 * dto.getResend().getDate(); i++) { // INSERT 쿼리문 작성 String query =
	 * "insert into reservationtbl(res_number,"
	 * +"act_number,res_start,res_end,res_name,res_phone,res_purchase,res_price, res_hotel)\n"
	 * +
	 * "values(seq_res_num.nextval, ?, ?, ?, ?, ?, ?, replace(?,'/',''), (select act_name from accommodationtbl where act_number = ?))"
	 * ;
	 * 
	 * psmt = con.prepareStatement(query); // 동적 쿼리 psmt.setInt(1,
	 * dto.getActnumber()); psmt.setDate(2, dto.getResstart()); psmt.setDate(3,
	 * dto.getResend()); psmt.setString(4, dto.getResname()); psmt.setString(5,
	 * dto.getResphone()); psmt.setString(6, dto.getRespurchase());
	 * psmt.setString(7, dto.getResprice()); psmt.setInt(8, dto.getActnumber());
	 * 
	 * result = psmt.executeUpdate(); }
	 * 
	 * } catch (Exception e) { System.out.println("게시물 입력 중 예외 발생");
	 * e.printStackTrace(); }
	 * 
	 * return result; }
	 */
    
    	
    }

