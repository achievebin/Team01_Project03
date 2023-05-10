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
            
            startDateInput.addEventListener("input", function() {
                var selectedStartDate = new Date(startDateInput.value);
                
                // 끝 날짜의 최소값을 선택된 시작 날짜 + 1일로 설정
                var minEndDate = new Date(selectedStartDate.getTime() + (24 * 60 * 60 * 1000));
                var minEndDateStr = minEndDate.toISOString().split('T')[0];
                endDateInput.setAttribute("min", minEndDateStr);
            });
        }
    </script>
</head>
<body>
    <h1>Date Range Selection</h1>
    
    <form method="get" action="your_action.jsp">
        <label for="startDate">Start Date:</label>
        <input type="date" name="startDate" id="startDate" required>
        <br><br>
        
        <label for="endDate">End Date:</label>
        <input type="date" name="endDate" id="endDate" required>
        <br><br>
        
        <input type="submit" value="Submit">
    </form>
</body>
</html>
