package bookmark;

import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;

import act.ActDTO;
import connect.JDBConnect;
import reserve.ReserveDTO;


public class bmDAO extends JDBConnect {
    public bmDAO(ServletContext application) {
        super(application);
    }

    
 // 북마크 등록
    public int addBookmark(bmDTO dto) { 
        int result = 0;
    	try {
            // 쿼리문 템플릿
            String quer = "insert into bookmarktbl"+
            "(bm_number,bm_id,act_number)" +
            "values(seq_bm_num.nextVAL,?,?)"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(quer); 
            psmt.setString(1, dto.getBmId()); 
            psmt.setString(2, dto.getActNumber()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
    
    // 지정한 게시물을 찾아 내용을 반환합니다.
    public bmDTO selectView(String id) { 
    	bmDTO dto = new bmDTO();
    	
        
        // 쿼리문 준비
        String query = "SELECT *" 
                     + " FROM bookmarktbl" 
                     + " WHERE bm_id=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, id);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) {
            	dto.setBmId("bm_id");
                dto.setActNumber(rs.getString("act_number")); 
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        
        return dto; 
    }
    
    // 검색 조건에 맞는 게시물 목록을 반환합니다.
    public List<bmDTO> selectList(Map<String, Object> map) { 
        List<bmDTO> bbs = new Vector<bmDTO>();  // 결과(게시물 목록)를 담을 변수

        String query = "SELECT * FROM bookmarktbl where bm_id = '" + map.get("bmid")+"'" ; 

        query += " ORDER BY bm_number DESC "; 

        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행

            while (rs.next()) {  // 결과를 순화하며...
                // 한 행(게시물 하나)의 내용을 DTO에 저장
            	bmDTO dto = new bmDTO(); 

                dto.setActNumber(rs.getString("act_number"));          // 일련번호
                dto.setBmId(rs.getString("bm_id"));

                bbs.add(dto);  // 결과 목록에 저장
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }

        return bbs;
    }
    
    // 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 기능 지원).
    public List<bmDTO> selectListPage(Map<String, Object> map) {
        List<bmDTO> bbs = new Vector<bmDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM bookmarktbl";

        // 검색 조건 추가 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        
        query += "      ORDER BY bm_number DESC "
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
			/* bmDTO */
            
            while (rs.next()) {
                // 한 행(게시물 하나)의 데이터를 DTO에 저장
            	bmDTO dto = new bmDTO();
                dto.setActNumber(rs.getString("act_number"));
                dto.setBmId(rs.getString("act_name"));
                dto.setBmNumber(rs.getString("bm_number"));
                
				/*
				 * //관심목록 if(map.get("actnumber").equals(rs.getString("act_number")) ) {
				 * dto.setActBookMark("O");
				 * 
				 * }else {dto.setActBookMark("X");}
				 */
                

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
    
    // 검색 조건에 맞는 게시물의 개수를 반환합니다.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수

        // 게시물 수를 얻어오는 쿼리문 작성
        String query = "SELECT COUNT(*) FROM accommodationtbl";
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
    
    // 검색 조건에 맞는 게시물 목록을 반환합니다.
    public List<ActDTO> actList(Map<String, Object> map) { 
        List<ActDTO> bbs = new Vector<ActDTO>();  // 결과(게시물 목록)를 담을 변수

        String query = "select * from accommodationtbl where act_number in" 
        		+"(select act_number from bookmarktbl where bm_id = '"+map.get("id")+"')  "; 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += " ORDER BY act_number DESC "; 

        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행

            while (rs.next()) {  // 결과를 순화하며...
                // 한 행(게시물 하나)의 내용을 DTO에 저장
            	ActDTO dto = new ActDTO(); 

                dto.setActNumber(rs.getString("act_number"));          // 일련번호
                dto.setActName(rs.getString("act_name"));      // 제목
                dto.setActInfo(rs.getString("act_info"));  // 내용
                dto.setActAddress(rs.getString("act_address"));  // 작성일
                dto.setActPhone(rs.getString("act_phone"));            // 작성자 아이디
                dto.setActRoom(rs.getInt("act_room"));  // 조회수
                dto.setActId(rs.getString("act_id"));

                bbs.add(dto);  // 결과 목록에 저장
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }

        return bbs;
    }
    
    	
}

