package score;

import javax.servlet.ServletContext;
import connect.JDBConnect;

public class ScoreDAO extends JDBConnect {
    public ScoreDAO(ServletContext application) {
        super(application);
    }

    //  db에서 review_score테이블의 값을 가져와 ScoreDTO에 입력
    public ScoreDTO scoreView(String num) { 
    	ScoreDTO dto = new ScoreDTO();
        
        // 입력한 값을 review_score의 act_number와 비교해 같은 값일경우 가져오기
        String query = "SELECT * FROM review_score WHERE act_number=?" ;

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) { //rs가 존재할경우 ScoreDTO에 값 저장
                dto.setActnum(rs.getInt("act_number")); 
                dto.setCountAll(rs.getInt("count_all"));
                dto.setHotel(rs.getString("hotel"));
                dto.setAvgScore(rs.getInt("rev_avg"));
                dto.setCount5(rs.getInt("count5"));
                dto.setCount4(rs.getInt("count4"));
                dto.setCount3(rs.getInt("count3"));
                dto.setCount2(rs.getInt("count2"));
                dto.setCount1(rs.getInt("count1"));

               
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        
        return dto; 
    }

    	
    }

