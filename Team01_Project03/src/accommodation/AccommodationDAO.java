package accommodation;

import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;
import connect.JDBConnect;
import accommodation.AccommodationDTO;

public class AccommodationDAO extends JDBConnect {
	public AccommodationDAO(ServletContext application) {
        super(application);
    }

    // 검색 조건에 맞는 게시물의 개수를 반환합니다.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수
        
        // 숙소 수를 얻어오는 쿼리문 작성
        String query = "SELECT COUNT(*) FROM accommodationtbl";
        if (map.get("accsearch") != null) {
            query += " WHERE " + map.get("searchText") + " "
                   + " LIKE '%" + map.get("accsearch") + "%'";
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

    
    // 검색 조건에 맞는 숙소 목록을 반환합니다(페이징 기능 지원).
    public List<AccommodationDTO> selectListPage(Map<String, Object> map) {
        List<AccommodationDTO> bbs = new Vector<AccommodationDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM accommodationtbl ";
        
        // 검색 조건 추가 
        if (map.get("accsearch") != null) {
            query += " WHERE " + map.get("searchText")
                   + " LIKE '%" + map.get("accsearch") + "%' ";
        }
        
        query += "      ORDER BY act_number DESC "
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
            	AccommodationDTO dto = new AccommodationDTO();
                dto.setAct_number(rs.getString("act_number"));
                dto.setAct_name(rs.getString("act_name"));
                dto.setAct_address(rs.getString("act_address"));
                dto.setAct_phone(rs.getString("act_phone"));
                dto.setAct_room(rs.getString("act_room"));
                dto.setAct_rcheck(rs.getString("act_rcheck"));

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


}