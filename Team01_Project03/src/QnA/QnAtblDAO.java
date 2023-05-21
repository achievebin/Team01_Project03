/*
  데이터 베이스 쿼리문에 맞게 수정 필요함.
  댓글 달 수 있는 계층생성 준비는 되어있으나
  기능적인 준비가 안됨
  참고한 홈페이지 url
  https://kimgom2.tistory.com/294
*/
package QnA;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;
import connect.JDBConnect;

public class QnAtblDAO extends JDBConnect {
    public QnAtblDAO(ServletContext application) {
        super(application);
    }
    
    public List<Object> Allboard() {
    	List<Object> QnaBoard = new ArrayList<Object>();
    	try {
    	String Query = "SELECT LEVEL, qna_number, qna_pb, qna_title,"
    			+ "qna_content, qna_date, mit_id"
    			+ "from qnatbl"
    			+" START WIHT qna_pb=0" + " CONNECT BY PRIOR qna_number=qna_number"
    			+" ORDER SIBLINGS BY qna_number DESC";
    	
    	stmt = con.createStatement();   // 쿼리문 생성
        rs = stmt.executeQuery(Query);  // 쿼리 실행
    	
         while (rs.next()) {
        	 	int level = rs.getInt("level");
        	 	String qna_number = rs.getString("qna_number");
        	 	String qna_pb = rs.getString("qna_pb");
        	 	String title = rs.getString("qna_title");
        	 	String content = rs.getString("qna_content");
        	 	java.sql.Date writeDate = rs.getDate("qna_date");
        	 	String id = rs.getString("mit_id");
        	 	
        	 	//게시글 정보를 저장함
        	 	QnAtblDTO dto = new QnAtblDTO();
                dto.setLevel(level);
                dto.setQna_number(qna_number);
                dto.setQna_pb(qna_pb);
                dto.setQna_title(title);
                dto.setQna_content(content);
                dto.setPostdate(writeDate);
                dto.setMit_id(id);
        	 	
         }
         rs.close();
         stmt.close();   			
    	
    	
    } catch (Exception e) {
    	System.out.println("테스트 오류");
        e.printStackTrace();
    	
    }
    	return QnaBoard;
    }
    // 검색 조건에 맞는 게시물의 개수를 반환합니다.
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수
        
        // 게시물 수를 얻어오는 쿼리문 작성
        String query = "SELECT COUNT(*) FROM qnatbl";
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
    public List<QnAtblDTO> selectList(Map<String, Object> map) { 
        List<QnAtblDTO> bbs = new Vector<QnAtblDTO>();  // 결과(게시물 목록)를 담을 변수

        String query = "SELECT * FROM qnatbl "; 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        
        query += " ORDER BY qna_number DESC "; 

        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행

            while (rs.next()) {  // 결과를 순화하며...
                // 한 행(게시물 하나)의 내용을 DTO에 저장
            	QnAtblDTO dto = new QnAtblDTO(); 

                dto.setQna_number(rs.getString("qna_number"));          // 일련번호
                dto.setQna_title(rs.getString("qna_title"));      // 제목
                dto.setQna_content(rs.getString("qna_content"));  // 내용
                dto.setMit_id(rs.getString("mit_id"));  // 아이디
                dto.setPostdate(rs.getDate("qna_date"));  // 작성자 작성일
                //dto.setVisitcount(rs.getString("visitcount"));  // 조회수

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
    public List<QnAtblDTO> selectListPage(Map<String, Object> map) {
        List<QnAtblDTO> bbs = new Vector<QnAtblDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM Qnatbl ";

        // 검색 조건 추가 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField")
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        
        query += "      ORDER BY Qna_number DESC "
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
            	QnAtblDTO dto = new QnAtblDTO();
                dto.setQna_number(rs.getString("qna_num"));
                dto.setQna_title(rs.getString("qna_title"));
                dto.setQna_content(rs.getString("qna_content"));  
                dto.setPostdate(rs.getDate("qna_date"));     
                dto.setMit_id(rs.getString("mit_id"));
                
                //dto.setVisitcount(rs.getString("visitcount"));

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
    public int insertWrite(QnAtblDTO dto) {
        int result = 0;
        
        try {
            // INSERT 쿼리문 작성 
            String query = "INSERT INTO Qnatbl ( "
                         + " qna_number, qna_title, qna_content, qna_date, mit_id) "
                         + " VALUES ( "
                         + " seq_QnA_num.NEXTVAL, ?, ?, sysdate, ?)";  
            // 오류발생구간
            psmt = con.prepareStatement(query);  // 동적 쿼리 
             
            psmt.setString(1, dto.getQna_title());
            psmt.setString(2, dto.getQna_content());          
            psmt.setString(3, dto.getMit_id());   
            
            result = psmt.executeUpdate(); 
			/*
			 * if (result == 1) { try { // 쿼리문 템플릿 String quer =
			 * "insert into Noticetbl(title) values(?,?,?,?,?)";
			 * 
			 * // 쿼리문 완성 psmt = con.prepareStatement(quer); psmt.setString(1,
			 * dto.getNoc_num()); psmt.setString(2, dto.getNoc_title()); psmt.setString(3,
			 * dto.getNoc_content()); psmt.setDate(4, dto.getPostdate()); psmt.setString(5,
			 * dto.getMit_id()); // 오류.
			 * 
			 * // 쿼리문 실행 result = psmt.executeUpdate();
			 * 
			 * } catch (Exception e) { System.out.println("게시물 입력 중 예외 발생");
			 * e.printStackTrace(); }
			 * 
			 * 
			 * }
			 */
        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
    

    // 지정한 게시물을 찾아 내용을 반환합니다.
    public QnAtblDTO selectView(String num) { 
    	QnAtblDTO dto = new QnAtblDTO();
        
        // 쿼리문 준비
		/*
		 * String query = "SELECT B.*, M.name " +
		 * " FROM memberidtbl M INNER JOIN Noticetbl B " + " ON M.id=B.id " +
		 * " WHERE noc_num=?";
		 */
    	
    	String query = "SELECT *" 
                + " FROM Qnatbl" 
                + " WHERE qna_number=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정
            //psmt.setInt(1, Integer.parseInt(num)); // 문자열을 정수형으로 변환하여 인파라미터 설정
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) {
                dto.setQna_number(rs.getString("qna_number")); 
                dto.setQna_title(rs.getString("qna_title"));
                dto.setQna_content(rs.getString("qna_content"));
                dto.setPostdate(rs.getDate("qna_date"));
                dto.setMit_id(rs.getString("mit_id"));
                //dto.setName(rs.getString("name")); 
                //dto.setVisitcount(rs.getString(6));

            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        
        return dto; 
    }

     //지정한 게시물의 조회수를 1 증가시킵니다.
//    public void updateVisitCount(String num) { 
//        // 쿼리문 준비 
//        String query = "UPDATE Noticetbl SET "
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
    public int updateEdit(QnAtblDTO dto) { 
        int result = 0;
        
        try {
            // 쿼리문 템플릿 
            String query = "UPDATE QnAtbl SET "
                         + " noc_title=?, noc_content=? "
                         + " WHERE qna_number=?";
            
            // 쿼리문 완성
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getQna_title());
            psmt.setString(2, dto.getQna_content());
            psmt.setString(3, dto.getQna_number());
            
            // 쿼리문 실행 
            result = psmt.executeUpdate();
        } 
        catch (Exception e) {
            System.out.println("게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환 
    }

    // 지정한 게시물을 삭제합니다.
    public int deletePost(QnAtblDTO dto) { 
        int result = 0;

        try {
            // 쿼리문 템플릿
            String query = "DELETE FROM NnAtbl WHERE qna_number=?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getQna_number()); 

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
