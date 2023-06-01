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
    

    // db에서 조회수 가져오기
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수

        // Reviewtbl의 값 가져오기
        String query = "SELECT COUNT(*) FROM Reviewtbl";
        
        // 검색어가 존재할경우 조건문 추가
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
    
    
    // db에서 조회수 가져오기
    public int myselectCount(Map<String, Object> map) {
        int totalCount = 0; // 결과(게시물 수)를 담을 변수

        // Reviewtbl의 값 가져오기
        String query = "SELECT COUNT(*) FROM Reviewtbl where rev_id ='"+ map.get("id") +"'";
        
        // 검색어가 존재할경우 조건문 추가
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
    
    // db에서 검색 조건에 맞는 Reviewtbl의 값 가져오기
    public List<ReviewDTO> selectList(Map<String, Object> map) { 
        List<ReviewDTO> bbs = new Vector<ReviewDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // Reviewtbl 의 값 가져오기
        String query = "SELECT * FROM Reviewtbl "; 
        
        //검색어가 존재할경우 조건문 추가
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        // 번호순으로 정렬
        query += " ORDER BY num DESC "; 

        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행

            while (rs.next()) {  // rs에 값이 존재할경우 ReviewDTO에 값 저장
            	
            	ReviewDTO dto = new ReviewDTO(); 

                dto.setNum(rs.getString("num"));          // 번호
                dto.setTitle(rs.getString("title"));      // 제목
                dto.setContent(rs.getString("content"));  // 내용
                dto.setPostdate(rs.getDate("postdate"));  // 작성일
                dto.setId(rs.getString("id"));            // 작성자 아이디
                dto.setVisitcount(rs.getString("visitcount"));  // 조회수

                bbs.add(dto);  // 리스트에 추가
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }

        return bbs;
    }
    
    // db에서 검색 조건에 맞는 Reviewtbl의 값 가져오기(페이징 기능 지원).
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
                dto.setNum(rs.getString("rev_number"));			// 리뷰 번호
                dto.setTitle(rs.getString("rev_title"));		// 리뷰 제목
                dto.setContent(rs.getString("rev_content"));	// 리뷰 내용
                dto.setPostdate(rs.getDate("rev_date"));		// 리뷰 작성일자
                dto.setId(rs.getString("rev_id"));				// 리뷰작성자 아이디
                dto.setScore(rs.getInt("rev_Score"));			// 리뷰 점수
                dto.setHotel(rs.getString("rev_hotel"));		// 리뷰한 숙소 이름
                dto.setActNumber(rs.getString("act_number"));	// 리뷰한 숙소 번호
                	
                bbs.add(dto); //리스트에 추가
				

				 
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        
        // 목록 반환
        return bbs;
    }

    // revWrite페이지에서 입력한 값을 db의 Reviewtbl에 입력
    public int insertWrite(ReviewDTO dto) {
        int result = 0;
        
        try {
            // revWrite페이지에서 입력한 값을 Reviewtbl에 입력하는 쿼리문
            String query = "insert into Reviewtbl(rev_number,rev_title,rev_content,rev_date,rev_score,rev_id,rev_hotel,act_number)"
                         + " VALUES ( "
                         + " seq_rev_num.nextval, ?, ?, sysdate, ?, ?, ?, ?)";  

            psmt = con.prepareStatement(query);  	// 동적 쿼리 
            psmt.setString(1, dto.getTitle());   	// 리뷰 제목
            psmt.setString(2, dto.getContent()); 	// 리뷰 내용
            psmt.setInt(3, dto.getScore());  	 	// 리뷰 점수
            psmt.setString(4, dto.getId()); 	 	// 리뷰작성자 아이디
            psmt.setString(5, dto.getHotel()); 	 	// 리뷰한 숙소 이름
            psmt.setString(6, dto.getActNumber());	// 리뷰한 숙소 번호
            
            result = psmt.executeUpdate(); 
            
            //리뷰 작성 성공시 review_score 테이블 업데이트
            if (result == 1) {
            	try {
                    // 리뷰가 추가됐으니 리뷰점수 테이블 최신화
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
                    
                    // 숙소 번호
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


    // db의 reviewtbl에서 입력받은 값(리뷰 번호)와 rev_number가 같은 값 가져오기
    public ReviewDTO selectView(String num) { 
    	ReviewDTO dto = new ReviewDTO();
        
        // reviewtbl에서 입력받은 값(리뷰 번호)와 rev_number가 같은 값을 가져오는 쿼리문
        String query = "SELECT *" 
                + " FROM reviewtbl" 
                + " WHERE rev_number=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) { // rs에 값이 있을경우 ReviewDTO에 값 저장
                dto.setNum(rs.getString("rev_number")); 		// 리뷰 번호
                dto.setTitle(rs.getString("rev_title"));		// 리뷰 제목
                dto.setContent(rs.getString("rev_content"));	// 리뷰 내용
                dto.setPostdate(rs.getDate("rev_date"));		// 리뷰 작성일
                dto.setId(rs.getString("rev_id"));				// 리뷰작성자 아이디
                dto.setHotel(rs.getString("rev_hotel"));		// 리뷰한 숙소 이름
                dto.setScore(rs.getInt("rev_score"));			// 리뷰 점수
               
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
    
    // revView 페이지에서 리뷰 수정을 누를경우 Reviewtbl의 
    // rev_title, rev_content, rev_score를 입력값으로 변경
    public int updateEdit(ReviewDTO dto) { 
        int result = 0;
        
        try {
            // rev_title, rev_content, rev_score를 입력값으로 변경하는 쿼리문
            String query = "UPDATE Reviewtbl SET "
                         + " rev_title=?, rev_content=?, rev_score=? "
                         + " WHERE rev_number=?";
            
            // 쿼리문 완성
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getTitle());		// 리뷰 제목
            psmt.setString(2, dto.getContent());	// 리뷰 내용
            psmt.setInt(3, dto.getScore());			// 리뷰 점수
            psmt.setString(4, dto.getNum());		// 리뷰 번호
            
            // 쿼리문 실행 
            result = psmt.executeUpdate();
        } 
        catch (Exception e) {
            System.out.println("게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환 
    }

    // revView 페이지에서 리뷰 삭제를 누를경우 Reviewtbl에서 조건에 맞는 데이터 삭제 
    public int deletePost(ReviewDTO dto) { 
        int result = 0;

        try {
        	// revView 페이지에서 리뷰 삭제를 누를경우 Reviewtbl에서 조건에 맞는 데이터 삭제하는 쿼리문
            String query = "DELETE FROM Reviewtbl WHERE rev_number=?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getNum()); // 리뷰 번호

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
    //리뷰 점수 업데이트
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
    
    // 로그인 된 아이디가 작성한 리뷰만을 myReview 페이지에 출력
    public List<ReviewDTO> selectMyList(Map<String, Object> map) {
        List<ReviewDTO> bbs = new Vector<ReviewDTO>();  // 결과(게시물 목록)를 담을 변수
        
     // 로그인 된 아이디가 작성한 리뷰만을 myReview 페이지에 출력하는 쿼리문 
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
            

            
            
            while (rs.next()) { //rs에 값이 존재할경우 ReviewDTO에 값 저장
               
            	ReviewDTO dto = new ReviewDTO();
                dto.setNum(rs.getString("rev_number"));
                dto.setTitle(rs.getString("rev_title"));
                dto.setContent(rs.getString("rev_content"));
                dto.setPostdate(rs.getDate("rev_date"));
                dto.setId(rs.getString("rev_id"));
                dto.setScore(rs.getInt("rev_Score"));
                dto.setHotel(rs.getString("rev_hotel"));
                dto.setActNumber(rs.getString("act_number"));
                
                bbs.add(dto); // 리스트에 값 추가
				

				 
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
