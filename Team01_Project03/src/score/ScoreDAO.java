package score;

import java.beans.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;

import Act.ActDTO;
import connect.JDBConnect;

public class ScoreDAO extends JDBConnect {
    public ScoreDAO(ServletContext application) {
        super(application);
    }

    // 지정한 게시물을 찾아 내용을 반환합니다.
    public ScoreDTO scoreView(String num) { 
    	ScoreDTO dto = new ScoreDTO();
        
        // 쿼리문 준비
        String query = "SELECT * FROM review_score WHERE act_number=?" ;

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, num);    // 인파라미터를 일련번호로 설정 
            rs = psmt.executeQuery();  // 쿼리 실행 

            // 결과 처리
            if (rs.next()) {
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

