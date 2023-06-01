package reserve;

import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;

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
    
    // 검색 조건에 맞는 게시물의 개수를 반환합니다.
    public int myselectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수

        // 게시물 수를 얻어오는 쿼리문 작성
        String query = "SELECT COUNT(*) FROM reservationtbl where res_id ='"+ map.get("resid") +"'";
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

    // db의 reservationtbl에서 데이터 가져오기
    public ReserveDTO scoreView(String num) { 
    	ReserveDTO dto = new ReserveDTO();
        
        // 입력값이 res_number와 같은 데이터 가져오기
        String query = "SELECT * FROM reservationtbl WHERE  res_number =?" ;

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) { // rs에 값이 있을경우 ReserveDTO에 값 저장
                dto.setResnumber(rs.getInt("res_number"));  // 예약 번호
                dto.setActnumber(rs.getInt("act_number"));	// 숙소 번호
                dto.setResstart(rs.getDate("res_start"));	// 체크인 날짜
                dto.setResend(rs.getDate("res_end"));		// 체크아웃 날짜
                dto.setResname(rs.getString("res_name"));	// 예약자 이름
                dto.setResphone(rs.getString("res_phone"));	// 예약자 전화번호
                dto.setRespurchase(rs.getString("res_purchase"));	// 예약금액 지불 수단
                dto.setResprice(rs.getString("res_price").replace("/", ""));//예약 총금액
                dto.setReshotel(rs.getString("res_hotel"));	// 예약한 숙소 이름
                dto.setResid(rs.getString("res_id"));		// 예약자 아이디
                dto.setRescancle(rs.getString("res_cancle"));	// 예약 취소여부
               
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        
        return dto; 
    }
    // db의 reservationtbl 에서 현재 로그인되있는 id의 예약목록 가져오기
    public List<ReserveDTO> selectListPage(Map<String, Object> map) {
        List<ReserveDTO> bbs = new Vector<ReserveDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // 현재 로그인되있는 id의 예약목록만 가져오기
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
            

            
            
            while (rs.next()) { // rs에 값이 있을경우 ReserveDTO에 값 저장
                
            	ReserveDTO dto = new ReserveDTO();
                dto.setResnumber(rs.getInt("res_number"));			// 예약 번호
                dto.setActnumber(rs.getInt("act_number"));			// 숙소 번호
                dto.setResstart(rs.getDate("res_start"));			// 체크인 날짜
                dto.setResend(rs.getDate("res_end"));				// 체크아웃 날짜
                dto.setResname(rs.getString("res_name"));			// 예약자 이름
                dto.setResphone(rs.getString("res_phone"));			// 예약자 전화번호
                dto.setRespurchase(rs.getString("res_purchase"));	// 예약금액 지불수단
                dto.setResprice(rs.getString("res_price"));			// 예약 총금액
                dto.setReshotel(rs.getString("res_hotel"));			// 예약한 숙소 이름
                dto.setResid(rs.getString("res_id"));				// 예약자 아이디
                dto.setRescancle(rs.getString("res_cancle"));		// 예약 취소여부
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
    
    // reserve(예약) 페이지에서 입력한 값을 reservationtbl에 입력
    public int insertWrite(ReserveDTO dto) {
        int result = 0;
        
        try {
            // // reserve(예약) 페이지에서 입력한 값을 reservationtbl에 입력하는 쿼리문
            String query = "insert into reservationtbl(res_number,"
            		+"act_number,res_start,res_end,res_name,res_phone,res_purchase,res_price, res_hotel,res_id)\n"
            		+ "values(seq_res_num.nextval, ?, ?, ?, ?, ?, ?, replace(?,'/',''), (select act_name from accommodationtbl where act_number = ?),?)";  

            psmt = con.prepareStatement(query);  	// 동적 쿼리 
            psmt.setInt(1, dto.getActnumber());  	// 숙소 번호
            psmt.setDate(2, dto.getResstart());	 	// 체크인 날짜
            psmt.setDate(3, dto.getResend());  	 	// 체크아웃 날짜
            psmt.setString(4, dto.getResname()); 	// 예약자 이름
            psmt.setString(5, dto.getResphone()); 	// 예약자 전화번호
            psmt.setString(6, dto.getRespurchase());// 예약금액 지불수단
            psmt.setString(7, dto.getResprice());	// 예약 총금액 
            psmt.setInt(8, dto.getActnumber()); 	// 예약한 숙소 번호로 숙소이름 가져오기
            psmt.setString(9, dto.getResid()); 		// 예약자 아이디
            result = psmt.executeUpdate(); 

        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
    
    // 예약, 예약 취소시 accommodationtbl의 남은객실수(act_leftroom) 업데이트
    public int updateRoom(int actnumber) {
        int result = 0;
        
        try {
            // 체크인~체크아웃 날짜동안  총 객실수에서 예약수를 뺀 값을 남은객실수에 적용하는 쿼리문
            String query = "update accommodationtbl SET act_leftroom = act_room-(select count(*) "
            		+ "from reservationtbl where (sysdate between res_start and res_end) and act_number = ? and res_cancle = '예약됨')"
            		+ "where act_number = ?";
            psmt = con.prepareStatement(query);  // 동적 쿼리 
            psmt.setInt(1, actnumber);  // 숙소 번호
            psmt.setInt(2, actnumber);  // 숙소 번호
            
            result = psmt.executeUpdate(); 
            
            

        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
    // reservePrint에서 예약취소를 누를 경우 reservationtbl의 예약여부를 취소됨으로 바꿈
    public int cancleReserve(ReserveDTO dto) { 
        int result = 0;

        try {
            // reservationtbl의 예약여부를 취소됨으로 바꾸는 쿼리문
            String query = "update reservationtbl set res_cancle = "
            		+ " '취소됨' where res_number = ? "; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setInt(1, dto.getResnumber()); //예약 번호

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

