<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Date Range Selection</title>
    <script>
    window.onload = function() {
        var today = new Date();
        var startDateInput = document.getElementById("startDate");
        var endDateInput = document.getElementById("endDate");

        // 시작 날짜를 오늘 날짜로 설정
        var startDate = today.toISOString().split('T')[0];
        startDateInput.value = startDate;

        // 시작 날짜의 최소값을 오늘 날짜로 설정
        startDateInput.setAttribute("min", startDate);
		
     	// 시작 날짜의 최대값을 오늘로부터 3개월 후로 설정
        var maxStartDate = new Date(today.getFullYear(), today.getMonth() + 3, today.getDate());
        var maxStartDateStr = maxStartDate.toISOString().split('T')[0];
        startDateInput.setAttribute("max", maxStartDateStr);
        
        startDateInput.addEventListener("input", function() {
            var selectedStartDate = new Date(startDateInput.value);

            // 끝 날짜의 최소값을 선택된 시작 날짜로 설정
            endDateInput.setAttribute("min", selectedStartDate.toISOString().split('T')[0]);

            // 끝 날짜의 최대값을 선택된 시작 날짜 + 7일 또는 오늘로부터 3개월 후로 설정
            var maxEndDate = new Date(selectedStartDate.getTime() + (7 * 24 * 60 * 60 * 1000));
            var maxEndDate3Months = new Date(today.getFullYear(), today.getMonth() + 3, today.getDate());
            var maxEndDateStr = (maxEndDate < maxEndDate3Months) ? maxEndDate.toISOString().split('T')[0] : maxEndDate3Months.toISOString().split('T')[0];
            endDateInput.setAttribute("max", maxEndDateStr);
        });

        // 끝 날짜의 최대값을 오늘로부터 3개월 후로 설정
        var maxEndDate = new Date(today.getFullYear(), today.getMonth() + 3, today.getDate());
        var maxEndDateStr = maxEndDate.toISOString().split('T')[0];
        endDateInput.setAttribute("max", maxEndDateStr);

        endDateInput.style.display = "none"; // 초기에 endDate 숨김
        
        startDateInput.addEventListener("input", function() {
            if (startDateInput.value !== "") {
                endDateInput.style.display = "block"; // startDate 입력 시 endDate 표시
            } else {
                endDateInput.style.display = "none"; // startDate 삭제 시 endDate 숨김
            }
        });
    }
    </script>
</head>
<body>
    <h3>날짜 선택</h3>
    
    <form method="get" action="your_action.jsp">
        <label for="startDate">날짜 선택:</label>
        <br><br>
        <input type="date" name="startDate" id="startDate" required>
        <input type="date" name="endDate" id="endDate" required>
        

        
        <input type="submit" value="Submit">
    </form>
</body>
</html>