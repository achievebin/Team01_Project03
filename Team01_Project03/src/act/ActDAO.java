package act;

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
    
	    
    // actList페이지에 표시할 값을 accommodationtbl에서 가져오기 (페이징 기능 지원).
    public List<ActDTO> selectListPage(Map<String, Object> map) {
        List<ActDTO> bbs = new Vector<ActDTO>();  // 결과(게시물 목록)를 담을 변수
        
        // 쿼리문 템플릿  
        String query = " SELECT * FROM ( "
                     + "    SELECT Tb.*, ROWNUM rNum FROM ( "
                     + "        SELECT * FROM accommodationtbl ";
        
        // 검색 조건 추가 
        if (map.get("accsearch") != null) {
            query += " WHERE " + map.get("searchText")
                   + " LIKE '%" + map.get("accsearch") + "%' ";
        }
        if (map.get("actdiv") != null) {
            query += " WHERE act_div = '"+ map.get("actdiv") +"'";
                   
        }
        
     // 정렬 조건 추가
        String sortname = (String) map.get("sortname");
        if (sortname != null && !sortname.isEmpty()) {
            if (sortname.equals("asc")) {
                query += " ORDER BY act_name ASC, act_leftroom ASC, act_price ASC";
            } else if (sortname.equals("desc")) {
                query += " ORDER BY act_name DESC, act_leftroom DESC, act_price DESC";
            } else if (sortname.equals("asc_leftroom")) {
                query += " ORDER BY act_leftroom ASC, act_name ASC, act_price ASC";
            } else if (sortname.equals("desc_leftroom")) {
                query += " ORDER BY act_leftroom DESC, act_name DESC, act_price DESC";
            } else if (sortname.equals("asc_price")) {
                query += " ORDER BY act_price ASC, act_name ASC, act_leftroom ASC";
            } else if (sortname.equals("desc_price")) {
                query += " ORDER BY act_price DESC, act_name DESC, act_leftroom DESC";
            }
        } else {
            query += " ORDER BY act_number DESC "; // 기본적으로 게시물 번호를 기준으로 내림차순 정렬
        }
        
        query += "     ) Tb "
               + " ) "
               + " WHERE rNum BETWEEN ? AND ?"; 
        try {

            // 쿼리문 완성 
            psmt = con.prepareStatement(query);
            psmt.setString(1, map.get("start").toString());
            psmt.setString(2, map.get("end").toString());
            
            // 쿼리문 실행
            rs = psmt.executeQuery();          
            while (rs.next()) { //rs에 값이 있을경우 해당값을 dto에 저장 
            	String actnum = rs.getString("act_number");		// 숙소 번호
            	String actname = rs.getString("act_name");		// 숙소 이름
            	String actinfo = rs.getString("act_info");		// 숙소 정보
            	String actadd = rs.getString("act_address");	// 숙소 주소
            	String actph = rs.getString("act_phone");		// 숙소 전화번호
            	int actroom = rs.getInt("act_room");			// 숙소 총객실
            	String actid = rs.getString("act_id");			// 숙소 작성자 아이디
            	int actpr = rs.getInt("act_price");				// 숙소 가격
            	int actle = rs.getInt("act_leftroom");			// 숙소 남은객실
            	String actdiv = rs.getString("act_div");		// 숙소 종류
            	ActDTO dto = new ActDTO();
                dto.setActNumber(actnum);
                dto.setActName(actname);
                dto.setActInfo(actinfo);
                dto.setActAddress(actadd);
                dto.setActPhone(actph);
                dto.setActRoom(actroom);
                dto.setActId(actid);
                dto.setActPrice(actpr);
                dto.setActLeftRoom(actle);	
                dto.setActDiv(actdiv);
            	bbs.add(dto); //dto의 값을 리스트에 추가
                
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bbs;
    }
    
    // 현재 로그인되있는 아이디의 관심목록을 리스트에 넣기
    public List<ActDTO> bmCheck(Map<String, Object> map) {
        List<ActDTO> bbs = new Vector<ActDTO>();  // 결과(게시물 목록)를 담을 변수
        
        //현재 로그인되있는 아이디의 관심목록을 가져오는 쿼리문
        String quer = "select act_number from accommodationtbl where "
                +"act_number in (select act_number from bookmarktbl where bm_id = '" + map.get("bmid")+"')" ;

        
        try {
        	psmt = con.prepareStatement(quer);
            rs = psmt.executeQuery();

            
			/* bmDTO */             
            while (rs.next()) {
            	ActDTO dto = new ActDTO();
            	String bmAct = rs.getString("act_number");	// 숙소 번호
            	
                // 한 행(게시물 하나)의 데이터를 DTO에 저장

				dto.setActBookMark(bmAct);
				
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
    


    // actWrite에서 작성완료를 누를 경우 accommodationtbl에 입력값 추가
    public int insertWrite(ActDTO dto) {
        int result = 0;
        
        try {
        	// actWrite에서 작성완료를 누를 경우 accommodationtbl에 입력값 추가하는 쿼리문 
            String query = "insert into accommodationtbl(act_number,\n"
            		+ "                             act_name,\n"
            		+ "                             act_address,\n"
            		+ "                             act_phone,\n"
            		+ "                             act_room,\n"
            		+ "                             act_info,\n"
            		+ "                             act_id, act_price, act_leftroom,"
            		+ "act_div) "
                         + " VALUES ( "
                         + " seq_act_num.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";  

            psmt = con.prepareStatement(query);  // 동적 쿼리 
            psmt.setString(1, dto.getActName());  	// 숙소 이름
            psmt.setString(2, dto.getActAddress());	// 숙소 주소
            psmt.setString(3, dto.getActPhone());  	// 숙소 전화번호
            psmt.setInt(4, dto.getActRoom()); 		// 숙소 총객실
            psmt.setString(5, dto.getActInfo()); 	// 숙소 정보
            psmt.setString(6, dto.getActId());		// 숙소 작성자아이디
            psmt.setInt(7, dto.getActPrice()); 		// 숙소 가격
            psmt.setInt(8, dto.getActRoom()); 		// 숙소 남은객실
            psmt.setString(9, dto.getActDiv());		// 숙소 종류
            result = psmt.executeUpdate(); 
            if (result == 1) {
            	try {
                    // 숙소 작성 완료 시 해당숙소의 리뷰점수테이블(review_score) 작성
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

    // actView에서 출력할 데이터 가져오기
    public ActDTO selectView(String num) { 
    	ActDTO dto = new ActDTO();
    	
        
        // 입력값(숙소번호)와 act_number가 같은 데이터 가져오는 쿼리문
        String query = "SELECT *" 
                     + " FROM accommodationtbl" 
                     + " WHERE act_number=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) { //rs에 값이 있을경우 dto에 저장
                dto.setActNumber(rs.getString(1)); 	// 숙소 번호
                dto.setActName(rs.getString(2));    // 숙소 이름
                dto.setActAddress(rs.getString(3)); // 숙소 주소
                dto.setActPhone(rs.getString(4));	// 숙소 전화번호
                dto.setActRoom(rs.getInt(5));		// 숙소 총객실
                dto.setActInfo(rs.getString(6));	// 숙소 정보
                dto.setActId(rs.getString(7));		// 숙소 작성자아이디
                dto.setActPrice(rs.getInt(8));		// 숙소 가격
                dto.setActLeftRoom(rs.getInt(9));	// 숙소 남은객실
                dto.setActDiv(rs.getString(10));	// 숙소 종류
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
    
    // edit 페이지에서 수정완료 시 db의 accommodationtbl를 수정
    public int updateEdit(ActDTO dto) { 
        int result = 0;
        
        try {
            // 쿼리문 템플릿 
            String query = "UPDATE accommodationtbl SET "
                         + " act_name=?, act_info=?, act_address=?, act_Phone=?, act_room=?, act_price=? "
                         + " WHERE act_number=?";
            
            // 쿼리문 완성
            psmt = con.prepareStatement(query);
            psmt.setString(1, dto.getActName());	// 숙소 이름
            psmt.setString(2, dto.getActInfo());	// 숙소 정보
            psmt.setString(3, dto.getActAddress()); // 숙소 주소
            psmt.setString(4, dto.getActPhone());	// 숙소 전화번호
            psmt.setInt(5, dto.getActRoom());		// 숙소 총객실
            psmt.setInt(6, dto.getActPrice());		// 숙소 가격
            psmt.setString(7, dto.getActNumber());	// 숙소 번호
            // 쿼리문 실행 
            result = psmt.executeUpdate();

        }
        

        catch (Exception e) {
            System.out.println("게시물 수정 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환 
    }
    // 리뷰테이블의 숙소명 업데이트
    public int updateRev(ActDTO dto) { 
        int result = 0;
        
    	try {
            // 리뷰테이블의 숙소명 수정하는 쿼리문
            String quer = "update reviewtbl SET rev_hotel = ?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(quer); 
            
            psmt.setString(1, dto.getActName()); // 숙소 이름

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환 
    }
    // 리뷰스코어 테이블의 숙소명 업데이트
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
    //리뷰 스코어 업데이트
    public int scoreUpdate(int num) {
        
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
             psmt.setInt(1, num); 
             psmt.setInt(2, num); 
             psmt.setInt(3, num); 
             psmt.setInt(4, num); 
             psmt.setInt(5, num); 
             psmt.setInt(6, num); 
             psmt.setInt(7, num);
             psmt.setInt(8, num); 

             // 쿼리문 실행
             result = psmt.executeUpdate(); 
         } 
         catch (Exception e) {
             System.out.println("게시물 삭제 중 예외 발생");
             e.printStackTrace();
         }
    	
    	return result; // 결과 반환
    }
    
 // 북마크추가
    public int addBookmark(ActDTO dto) { 
        int result = 0;
    	try {
            // 쿼리문 템플릿
            String quer = "insert into bookmarktbl"+
            "(bm_number,bm_id,act_number)" +
            "values(seq_bm_num.nextVAL,?,?)"; 

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
}

