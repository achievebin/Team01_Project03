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
    // 게시글 데이터를 받아 DB에 추가합니다. 
    public int insertWrite(ReserveDTO dto) {
        int result = 0;
        
        try {
            // INSERT 쿼리문 작성 
            String query = "insert into reservationtbl(res_number,"
            		+"act_number,res_start,res_end,res_name,res_phone,res_purchase,res_price)\n"
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

    	
    }

