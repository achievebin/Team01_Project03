package Act;

/*import java.beans.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;*/
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;
import connect.JDBConnect;

public class ActDAO extends JDBConnect {
    public ActDAO(ServletContext application) {
        super(application);
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
    public List<ActDTO> selectList(Map<String, Object> map) { 
        List<ActDTO> bbs = new Vector<ActDTO>();  // 결과(게시물 목록)를 담을 변수

        String query = "SELECT * FROM accommodationtbl "; 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += " ORDER BY num DESC "; 

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
    
    // 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 기능 지원).
    public List<ActDTO> selectListPage(Map<String, Object> map) {
        List<ActDTO> bbs = new Vector<ActDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM accommodationtbl ";

        // 검색 조건 추가 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
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
            	ActDTO dto = new ActDTO();
                dto.setActNumber(rs.getString("act_number"));
                dto.setActName(rs.getString("act_name"));
                dto.setActInfo(rs.getString("act_info"));
                dto.setActAddress(rs.getString("act_address"));
                dto.setActPhone(rs.getString("act_phone"));
                dto.setActRoom(rs.getInt("act_room"));
                dto.setActId(rs.getString("act_id"));
                dto.setActPrice(rs.getInt("act_price"));
                
                

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
    public int insertWrite(ActDTO dto) {
        int result = 0;
        
        try {
            // INSERT 쿼리문 작성 
            String query = "insert into reservationtbl(res_number,act_number,"
            		+"res_start,res_end,res_name,res_phone,res_purchase,res_price)\n"
            		+ "values(seq_res_num.nextval, ?, ?, ?, ?, ?, ?, ?)";  

            psmt = con.prepareStatement(query);  // 동적 쿼리 
            psmt.setString(1, dto.getActName());  
            psmt.setString(2, dto.getActAddress());
            psmt.setString(3, dto.getActPhone());  
            psmt.setInt(4, dto.getActRoom()); 
            psmt.setString(5, dto.getActInfo()); 
            psmt.setString(6, dto.getActId());
            psmt.setInt(7, dto.getActPrice()); 
            
            result = psmt.executeUpdate(); 
            if (result == 1) {
            	try {
                    // 쿼리문 템플릿
                    String quer = "insert into review_score"+
                    "(act_number,hotel,rev_avg,count_all,count5,count4,count3,count2,count1)" +
                    "values(seq_act_num.CURRVAL,?,0,0,0,0,0,0,0)"; 

                    // 쿼리문 완성
                    psmt = con.prepareStatement(quer); 
                    
                    psmt.setString(1, dto.getActName()); 

                    // 쿼리문 실행
                    result = psmt.executeUpdate(); 
                } 
                catch (Exception e) {
                    System.out.println("게시물 삭제 중 예외 발생");
                    e.printStackTrace();
                }
            	
            	
            }
        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }

    // 지정한 게시물을 찾아 내용을 반환합니다.
    public ActDTO selectView(String num) { 
    	ActDTO dto = new ActDTO();
    	
        
        // 쿼리문 준비
        String query = "SELECT *" 
                     + " FROM accommodationtbl" 
                     + " WHERE act_number=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) {
                dto.setActNumber(rs.getString(1)); 
                dto.setActName(rs.getString(2));             
                dto.setActAddress(rs.getString(3));
                dto.setActPhone(rs.getString(4));
                dto.setActRoom(rs.getInt(5));
                dto.setActInfo(rs.getString(6));
                dto.setActId(rs.getString(7));
                dto.setActPrice(rs.getInt(8));
               
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        
        return dto; 
    }

    // 지정한 게시물의 조회수를 1 증가시킵니다.
//    public void updateVisitCount(String num) { 
//        // 쿼리문 준비 
//        String query = "UPDATE board SET "
//                     + " visitcount=visitcount+1 "
//                     + " WHERE num=?";
//        
//        try {
//            psmt = con.prepareStatement(query);
//            psmt.setString(1, num);  // 인파라미터를 일련번호로 설정 
//            psmt.executeQuery();     // 쿼리 실행 
//        } 
//        catch (Exception e) {
//            System.out.println("게시물 조회수 증가 중 예외 발생");
//            e.printStackTrace();
//        }
//    }
    
    // 지정한 게시물을 수정합니다.
    public int updateEdit(ActDTO dto) { 
        int result = 0;
        
        try {
            // 쿼리문 템플릿 
            String query = "UPDATE accommodationtbl SET "
                         + " act_name=?, act_info=?, act_address=?, act_Phone=?, act_room=?, act_price=? "
                         + " WHERE act_number=?";
            
            // 쿼리문 완성
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getActName());
            psmt.setString(2, dto.getActInfo());
            psmt.setString(3, dto.getActAddress());
            psmt.setString(4, dto.getActPhone());
            psmt.setInt(5, dto.getActRoom());
            psmt.setString(6, dto.getActNumber());
            psmt.setInt(7, dto.getActPrice());
            // 쿼리문 실행 
            result = psmt.executeUpdate();

        }
        

        catch (Exception e) {
            System.out.println("게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환 
    }
    // 수정 성공시 데이터베이스 업데이트
    public int updateRev(ActDTO dto) { 
        int result = 0;
        
    	try {
            // 쿼리문 템플릿
            String quer = "update reviewtbl SET rev_hotel = ?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(quer); 
            
            psmt.setString(1, dto.getActName()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환 
    }
    
    public int updateScore(ActDTO dto) { 
        int result = 0;
        
    	try {
            // 쿼리문 템플릿
            String quer = "update review_score SET hotel = ?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(quer); 
            
            psmt.setString(1, dto.getActName()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환 
    }
    



    // 지정한 게시물을 삭제합니다.
    public int deletePost(ActDTO dto) { 
        int result = 0;

        try {
            // 쿼리문 템플릿
            String query = "DELETE FROM accommodationtbl WHERE act_number=?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getActNumber()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
    public int deleteReview(ActDTO dto) { 
        int result = 0;

        try {
            // 쿼리문 템플릿
            String query = "DELETE FROM reviewtbl WHERE act_number=?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getActNumber()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
    public int deleteScore(ActDTO dto) { 
        int result = 0;

        try {
            // 쿼리문 템플릿
            String query = "DELETE FROM review_score WHERE act_number=?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getActNumber()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
    
    	
}

