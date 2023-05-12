package Reserve;

import java.beans.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;
import javax.servlet.ServletContext;

import Act.ActDTO;
import connect.JDBConnect;

public class ReserveDAO extends JDBConnect {
    public ReserveDAO(ServletContext application) {
        super(application);
    }

    // 지정한 게시물을 찾아 내용을 반환합니다.
    public ReserveDTO scoreView(String num) { 
    	ReserveDTO dto = new ReserveDTO();
        
        // 쿼리문 준비
        String query = "SELECT * FROM reservationtbl WHERE act_number=?" ;

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
    // 게시글 데이터를 받아 DB에 추가합니다. 
    public int insertWrite(ReserveDTO dto) {
        int result = 0;
        
        try {
            // INSERT 쿼리문 작성 
            String query = "insert into reservationtbl(res_number,"
            		+"act_number,res_start,res_end,res_name,res_phone,res_purchase,res_price)\n"
            		+ "values(seq_res_num.nextval, ?, ?, ?, ?, ?, ?, ?)";  

            psmt = con.prepareStatement(query);  // 동적 쿼리 
            psmt.setInt(1, dto.getActnumber());  
            psmt.setDate(2, dto.getResstart());
            psmt.setDate(3, dto.getResend());  
            psmt.setString(4, dto.getResname()); 
            psmt.setString(5, dto.getResphone()); 
            psmt.setString(6, dto.getRespurchase());
            psmt.setString(7, dto.getResprice()); 
            
            result = psmt.executeUpdate(); 

        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }

    	
    }

