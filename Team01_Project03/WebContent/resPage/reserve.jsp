<%@ page import="act.ActDAO"%>
<%@ page import="act.ActDTO"%>
<%@ page import="reserve.ReserveDAO"%>
<%@ page import="reserve.ReserveDTO"%>
<%@ page import="score.ScoreDAO"%>
<%@ page import="score.ScoreDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");  // 일련번호 받기 
String actnum = (String)session.getAttribute("actnumber");
ActDAO dao = new ActDAO(application);  // DAO 생성 
              
ActDTO dto = dao.selectView(actnum);        // 게시물 가져오기 
String actname = dto.getActName();
ScoreDAO sdao = new ScoreDAO(application); //점수 dao 생성

ScoreDTO sdto = sdao.scoreView(actnum); //점수 가져오기

int act_price = dto.getActPrice();



dao.close(); // 숙소DB 연결 해제    
sdao.close();// 점수DB 연결 해제
%>
<!DOCTYPE html>
<html>
<head>
<!-- css 연결 -->
<link href="./css/rescss.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<!-- 타이틀 -->
<title>숙소 예약</title>

<!-- 폼 예외처리 -->
<script type="text/javascript">
window.onload = function() {
    var today = new Date();
    var startDateInput = document.getElementById("chk_in");
    var endDateInput = document.getElementById("chk_out");

    // 체크인 날짜를 오늘 날짜로 설정
    var startDate = today.toISOString().split('T')[0];
    startDateInput.value = startDate;

    // 체크인 날짜의 최소값을 오늘 날짜로 설정
    startDateInput.setAttribute("min", startDate);

    // 체크인 날짜의 최대값을 오늘로부터 3개월 후로 설정
    var maxStartDate = new Date(today.getFullYear(), today.getMonth() + 3, today.getDate());
    var maxStartDateStr = maxStartDate.toISOString().split('T')[0];
    startDateInput.setAttribute("max", maxStartDateStr);

    startDateInput.addEventListener("input", function() {
        var selectedStartDate = new Date(startDateInput.value);

        // 체크아웃 날짜의 최소값을 선택된 체크인 날짜로 설정
        endDateInput.setAttribute("min", selectedStartDate.toISOString().split('T')[0]);

        // 체크아웃 날짜의 최대값을 선택된 체크인 날짜 + 7일 또는 오늘로부터 3개월 후로 설정
        var maxEndDate = new Date(selectedStartDate.getTime() + (7 * 24 * 60 * 60 * 1000));
        var maxEndDate3Months = new Date(today.getFullYear(), today.getMonth() + 3, today.getDate());
        var maxEndDateStr = (maxEndDate < maxEndDate3Months) ? maxEndDate.toISOString().split('T')[0] : maxEndDate3Months.toISOString().split('T')[0];
        endDateInput.setAttribute("max", maxEndDateStr);
    });

    // 체크아웃 날짜의 최대값을 오늘로부터 3개월 후로 설정
    var maxEndDate = new Date(today.getFullYear(), today.getMonth() + 3, today.getDate());
    var maxEndDateStr = maxEndDate.toISOString().split('T')[0];
    endDateInput.setAttribute("max", maxEndDateStr);
	}
	
	function validateForm(form) {  // 폼 내용 검증
		let regPhone = /([0-9]{2,4})-?([0-9]{3,4})-?([0-9]{4})$/;
		let regPrice = /([0-9])$/;
		
	    if (form.reserv_name.value == "") {
	        alert("예약자 성함을 입력하세요.");
	        form.reserv_name.focus();
	        return false;
	    }
	    
	    if (form.reserv_phone.value == "") {
	        alert("전화번호를 입력하세요.");
	        form.reserv_phone.focus();
	        return false;
	    }
	    
		if (regPhone.test(form.reserv_phone.value) == false) {
			alert("잘못된 형식의 전화번호입니다.");
			form.reserv_phone.focus();
			return false;
			}
		
	    if (form.intera.checked == false) {
	        alert("약관A에 동의해주세요");
	        form.intera.focus();
	        return false;
	    }
	    if (form.interb.checked == false) {
	        alert("약관B에 동의해주세요");
	        form.interb.focus();
	        return false;
	    }

    
}
</script>
<!-- 폼 예외처리 끝 -->

</head>
<body>
<!-- 헤더 -->
<jsp:include page="/common/header.jsp" />
<div id="resWrite">
<%-- <jsp:include page="../ActPage/MainLink.jsp" /> --%>
<!-- 숙소명 예약 출력 -->
<h2><%=actname%> 예약</h2>
        
        <!-- 예약 정보 입력 폼 -->
<form name="ReserverFrm" action="./reserveProcess.jsp" method="post" method="post"
	onsubmit="return validateForm(this);">
    <h2>예약자 정보</h2>
    <table border="1" style="width:50%" id="resWriteTable">

        <tr>
            <td>예약자 성함</td>
            <td>
                <input type="text" name="reserv_name" style="width: 90%;" id="reserv_name" />
            </td>
            
            <td>예약자 휴대번호</td>          
            <td>
                <input type="text" name="reserv_phone" style="width: 90%;" id="reserv_phone" />
            </td>
            </tr>
         <tr>
         <td>
		<label>체크인 날짜</label>
		
		</td>
		<td><input type="date" name="chk_in" id="chk_in" required></td>
		<td>
		<label>체크아웃 날짜</label>
		
		</td>
		<td><input type="date" name="chk_out" id="chk_out" required></td>
            
        </tr>
        </table>
        <hr width="50%" align="left">

	<h2>총 금액</h2>
    <table border="1" style="width:50%">
        <tr>
            <td width="15%">구매 총액</td>
            
            <td>
            <input type="hidden" name="reserv_price" value=<%=act_price %>/>
            <input type="hidden" name="reserv_hotel" value=<%=actname%>/>
            <input type="hidden" name="num" value=<%=num%>/>
                <%= act_price %></td>

            
        </tr>

        </table>
        <hr width="50%" align="left">

        <h2>결제수단 선택</h2>
            <select name="reserv_purchase" onchange="selectBoxChange(this.value);">
                <option value="신용카드">신용카드</option>
                <option value="무통장입금">무통장입금</option>
                <option value="간편결제">간편결제</option>   
            </select><br />
        <hr width="50%" align="left">
                
            <input type="checkbox" name="intera" value="terms_a" />약관A
            <input type="checkbox" name="interb" value="terms_b" />약관B
            
            <input type="submit" value="예약하기">
       
        </form> 
        <!-- 예약 정보 입력 폼 끝 -->
 
        

    

</div>
</body>
</html>
