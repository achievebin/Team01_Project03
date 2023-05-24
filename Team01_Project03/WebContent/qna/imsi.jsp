<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="qna.QnAtblDAO" %>
<%@ page import="qna.QnAtblDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>


<%
	//게시물의 일련번호와 댓글 작성자, 내용을 파라미터로 받음
String postId = request.getParameter("mit_Id");
/* String writer = request.getParameter("writer"); */
String content = request.getParameter("qna_content");

//현재 날짜와 시간을 생성
Date now = new Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String postDate = format.format(now);

//QnAtblDTO 객체 생성 및 데이터 설정
qna.QnAtblDTO comment = new qna.QnAtblDTO();
/* comment.setMit_id(writer); // 댓글 작성자 설정 */
comment.setQna_title(""); // 댓글 제목은 비워둘 수 있음
comment.setQna_content(content); // 댓글 내용 설정

//QnAtblDAO를 이용하여 댓글 추가 처리
qna.QnAtblDAO dao = new qna.QnAtblDAO(application); // DAO 생성
dao.Allboard(); // 댓글 추가 메서드 호출
dao.close(); // DB 연결 해제
%>

<!-- <script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script> -->
<!-- 댓글 추가 후 게시물 상세보기 페이지로 이동 -->
<script>
    alert("댓글이 추가되었습니다.");
    location.href = "qnaList.jsp";
</script>
