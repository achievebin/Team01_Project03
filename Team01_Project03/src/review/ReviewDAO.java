package review;


import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;


import connect.JDBConnect;

public class ReviewDAO extends JDBConnect {
    public ReviewDAO(ServletContext application) {
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
    
    // 검색 조건에 맞는 게시물 목록을 반환합니다.
    public List<ReviewDTO> selectList(Map<String, Object> map) { 
        List<ReviewDTO> bbs = new Vector<ReviewDTO>();  // 결과(게시물 목록)를 담을 변수
        
        String query = "SELECT * FROM Reviewtbl "; 
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
            	ReviewDTO dto = new ReviewDTO(); 

                dto.setNum(rs.getString("num"));          // 일련번호
                dto.setTitle(rs.getString("title"));      // 제목
                dto.setContent(rs.getString("content"));  // 내용
                dto.setPostdate(rs.getDate("postdate"));  // 작성일
                dto.setId(rs.getString("id"));            // 작성자 아이디
                dto.setVisitcount(rs.getString("visitcount"));  // 조회수

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
    public List<ReviewDTO> selectListPage(Map<String, Object> map) {
        List<ReviewDTO> bbs = new Vector<ReviewDTO>();  // 결과(게시물 목록)를 담을 변수
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM Reviewtbl "
        			 + " where act_number = '"+ map.get("actnumber") +"'";
        // 검색 조건 추가 
		
		/*
		 * if (map.get("searchWord") != null) { query += " WHERE " +
		 * map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' "; }
		 */
		 
        
        query += "      ORDER BY rev_number DESC "
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
            	ReviewDTO dto = new ReviewDTO();
                dto.setNum(rs.getString("rev_number"));
                dto.setTitle(rs.getString("rev_title"));
                dto.setContent(rs.getString("rev_content"));
                dto.setPostdate(rs.getDate("rev_date"));
                dto.setId(rs.getString("rev_id"));
                dto.setScore(rs.getInt("rev_Score"));
                dto.setHotel(rs.getString("rev_hotel"));
                dto.setActNumber(rs.getString("act_number"));
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
    public int insertWrite(ReviewDTO dto) {
        int result = 0;
        
        try {
            // INSERT 쿼리문 작성 
            String query = "insert into Reviewtbl(rev_number,rev_title,rev_content,rev_date,rev_score,rev_id,rev_hotel,act_number)"
                         + " VALUES ( "
                         + " seq_rev_num.nextval, ?, ?, sysdate, ?, ?, ?, ?)";  

            psmt = con.prepareStatement(query);  // 동적 쿼리 
            psmt.setString(1, dto.getTitle());  
            psmt.setString(2, dto.getContent());
            psmt.setInt(3, dto.getScore());  
            psmt.setString(4, dto.getId()); 
            psmt.setString(5, dto.getHotel()); 
            psmt.setString(6, dto.getActNumber());
            
            result = psmt.executeUpdate(); 
            if (result == 1) {
            	try {
                    // 쿼리문 템플릿
                    String quer = "update review_score \n"
                    		+ "set rev_avg = (select round(avg(rev_score),2) from reviewtbl where act_number = ?),\n"
                    		+ "    count_all  = (select count(rev_score)from reviewtbl where act_number = ?),\n"
                    		+ "    count5  = (select count(rev_score)from reviewtbl where (rev_score = 5 and act_number = ?)),\n"
                    		+ "    count4  = (select count(rev_score)from reviewtbl where (rev_score = 4 and act_number = ?)),\n"
                    		+ "    count3  = (select count(rev_score)from reviewtbl where (rev_score = 3 and act_number = ?)),\n"
                    		+ "    count2  = (select count(rev_score)from reviewtbl where (rev_score = 2 and act_number = ?)),\n"
                    		+ "    count1  = (select count(rev_score)from reviewtbl where (rev_score = 1 and act_number = ?))\n"
                    		+ "where act_number = ?"; 

                    // 쿼리문 완성
                    psmt = con.prepareStatement(quer); 
                    psmt.setString(1, dto.getActNumber());                   
                    psmt.setString(2, dto.getActNumber()); 
                    psmt.setString(3, dto.getActNumber()); 
                    psmt.setString(4, dto.getActNumber()); 
                    psmt.setString(5, dto.getActNumber()); 
                    psmt.setString(6, dto.getActNumber()); 
                    psmt.setString(7, dto.getActNumber());
                    psmt.setString(8, dto.getActNumber()); 

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
    public ReviewDTO selectView(String num) { 
    	ReviewDTO dto = new ReviewDTO();
        
        // 쿼리문 준비
        String query = "SELECT *" 
                + " FROM reviewtbl" 
                + " WHERE rev_number=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) {
                dto.setNum(rs.getString("rev_number")); 
                dto.setTitle(rs.getString("rev_title"));
                dto.setContent(rs.getString("rev_content"));
                dto.setPostdate(rs.getDate("rev_date"));
                dto.setId(rs.getString("rev_id"));
                dto.setHotel(rs.getString("rev_hotel"));
                dto.setScore(rs.getInt("rev_score"));
               
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        
        return dto; 
    }

    // 지정한 게시물의 조회수를 1 증가시킵니다.
    public void updateVisitCount(String num) { 
        // 쿼리문 준비 
        String query = "UPDATE board SET "
                     + " visitcount=visitcount+1 "
                     + " WHERE num=?";
        
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);  // 인파라미터를 일련번호로 설정 
            psmt.executeQuery();     // 쿼리 실행 
        } 
        catch (Exception e) {
            System.out.println("게시물 조회수 증가 중 예외 발생");
            e.printStackTrace();
        }
    }
    
    // 지정한 게시물을 수정합니다.
    public int updateEdit(ReviewDTO dto) { 
        int result = 0;
        
        try {
            // 쿼리문 템플릿 
            String query = "UPDATE Reviewtbl SET "
                         + " rev_title=?, rev_content=?, rev_score=? "
                         + " WHERE rev_number=?";
            
            // 쿼리문 완성
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getContent());
            psmt.setInt(3, dto.getScore());
            psmt.setString(4, dto.getNum());
            
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
    public int deletePost(ReviewDTO dto) { 
        int result = 0;

        try {
            // 쿼리문 템플릿
            String query = "DELETE FROM Reviewtbl WHERE rev_number=?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getNum()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
    
    public int scoreUpdate(ReviewDTO dto) {
    
    	int result = 0;
    	 try {
             // 쿼리문 템플릿
             String query = "update review_score \n"
             		+ "set rev_avg = (select round(avg(rev_score),2) from reviewtbl where act_number = ?),\n"
             		+ "    count_all  = (select count(rev_score)from reviewtbl where act_number = ?),\n"
             		+ "    count5  = (select count(rev_score)from reviewtbl where (rev_score = 5 and act_number = ?)),\n"
             		+ "    count4  = (select count(rev_score)from reviewtbl where (rev_score = 4 and act_number = ?)),\n"
             		+ "    count3  = (select count(rev_score)from reviewtbl where (rev_score = 3 and act_number = ?)),\n"
             		+ "    count2  = (select count(rev_score)from reviewtbl where (rev_score = 2 and act_number = ?)),\n"
             		+ "    count1  = (select count(rev_score)from reviewtbl where (rev_score = 1 and act_number = ?))\n"
             		+ "where act_number = ?"; 

             // 쿼리문 완성
             psmt = con.prepareStatement(query); 
             psmt.setString(1, dto.getActNumber()); 
             psmt.setString(2, dto.getActNumber()); 
             psmt.setString(3, dto.getActNumber()); 
             psmt.setString(4, dto.getActNumber()); 
             psmt.setString(5, dto.getActNumber()); 
             psmt.setString(6, dto.getActNumber()); 
             psmt.setString(7, dto.getActNumber()); 
             psmt.setString(8, dto.getActNumber()); 

             // 쿼리문 실행
             result = psmt.executeUpdate(); 
         } 
         catch (Exception e) {
             System.out.println("게시물 삭제 중 예외 발생");
             e.printStackTrace();
         }
    	
    	return result; // 결과 반환
    }
    
    // 검색 조건에 맞는 게시물 목록을 반환합니다(페이징 기능 지원).
    public List<ReviewDTO> selectMyList(Map<String, Object> map) {
        List<ReviewDTO> bbs = new Vector<ReviewDTO>();  // 결과(게시물 목록)를 담을 변수
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM Reviewtbl "
        			 + " where rev_id = '"+ map.get("id") +"'";
        // 검색 조건 추가 
		
		/*
		 * if (map.get("searchWord") != null) { query += " WHERE " +
		 * map.get("searchField") + " LIKE '%" + map.get("searchWord") + "%' "; }
		 */
		 
        
        query += "      ORDER BY rev_number DESC "
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
            	ReviewDTO dto = new ReviewDTO();
                dto.setNum(rs.getString("rev_number"));
                dto.setTitle(rs.getString("rev_title"));
                dto.setContent(rs.getString("rev_content"));
                dto.setPostdate(rs.getDate("rev_date"));
                dto.setId(rs.getString("rev_id"));
                dto.setScore(rs.getInt("rev_Score"));
                dto.setHotel(rs.getString("rev_hotel"));
                dto.setActNumber(rs.getString("act_number"));
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