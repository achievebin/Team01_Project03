//회원가입 유효성 검증
function signInFormCheck() {
	var id = document.getElementById("sinid");
	var pw = document.getElementById("sinpw");
	
	var regId = /^(?=.*[a-z0-9])[a-z0-9]{5,12}$/;
	var regPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,12}/;
	
	if (!id.value) {
		alert("아이디를 입력해주세요.");
		id.focus();
		return false;
	}
	if (regId.test(id.value) == false) {
		alert("영어와 숫자로 구성된 5~12자리의 아이디를 입력해주세요.");
		id.focus();
		return false;
		}
	if (!pw.value) {
		alert("비밀번호를 입력해주세요.");
		pw.focus();
		return false;
	}
	if (regPw.test(pw.value) == false) {
		alert("숫자, 대소문자, 특수문자를 포함한 8~12자리의 비밀번호를 입력해주세요");
		pw.focus();
		return false;
		}
	document.signInForm.submit();
}
//로그인 유효성 검증
function joinFormCheck() {
		var id = document.getElementById("id");
		var pw = document.getElementById("pw");
		var pwCheck = document.getElementById("pwCheck");
		var name = document.getElementById("name");
		var address = document.getElementById("address");
		var phone = document.getElementById("phone");
		var email = document.getElementById("email");
		
		var regId = /^(?=.*[a-z0-9])[a-z0-9]{5,12}$/;
		var regPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,12}/;
		var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if (!id.value) {
			alert("아이디를 입력해주세요.");
			id.focus();
			return false;
		}
		if (regId.test(id.value) == false) {
			alert("영어와 숫자로 구성된 5~12자리의 아이디를 입력해주세요.");
			id.focus();
			return false;
		}
		if (!pw.value) {
			alert("비밀번호를 입력해주세요.");
			pw.focus();
			return false;
		}
		if (regPw.test(pw.value) == false) {
			alert("숫자, 대소문자, 특수문자를 포함한 8~12자리의 비밀번호를 입력해주세요");
			pw.focus();
			return false;
		}
		if (pw.value != pwCheck.value) {
			alert("입력하신 비밀번호와 다릅니다.");
			pwCheck.focus();
			return false;
		}
		if (!name.value) {
			alert("이름을 입력해주세요.");
			name.focus();
			return false;
		}
		if (!address.value) {
			alert("주소를 입력해주세요.");
			address.focus();
			return false;
		}
		if (!phone.value) {
			alert("전화번호를 입력해주세요.");
			phone.focus();
			return false;
		}
		if (regPhone.test(phone.value) == false) {
			alert("잘못된 형식의 전화번호입니다.");
			phone.focus();
			return false;
		}
		if (!email.value) {
			alert("이름을 입력해주세요.");
			phone.focus();
			return false;
		}
		if (regEmail.test(email.value) == false) {
			alert("잘못된 형식의 이메일입니다.");
			email.focus();
			return false;
		}
		document.joinForm.submit();
	}
//정보수정 유효성 검증	
function updateInfoFormCheck() {
	var id = document.getElementById("newId");
	var pw = document.getElementById("newPw");
	var name = document.getElementById("newName");
	var address = document.getElementById("newAddress");
	var phone = document.getElementById("newPhone");
	var email = document.getElementById("newEmail");
	
	var regId = /^(?=.*[a-z0-9])[a-z0-9]{5,12}$/;
	var regPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,12}/;
	var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	var regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
	if (!id.value) {
		alert("아이디를 입력해주세요.");
		id.focus();
		return false;
	}
	if (regId.test(id.value) == false) {
		alert("영어와 숫자로 구성된 5~12자리의 아이디를 입력해주세요.");
		id.focus();
		return false;
	}
	if (!pw.value) {
		alert("비밀번호를 입력해주세요.");
		pw.focus();
		return false;
	}
	if (regPw.test(pw.value) == false) {
		alert("숫자, 대소문자, 특수문자를 포함한 8~12자리의 비밀번호를 입력해주세요");
		pw.focus();
		return false;
		}
	if (!name.value) {
		alert("이름을 입력해주세요.");
		name.focus();
		return false;
		}
	if (!address.value) {
		alert("주소를 입력해주세요.");
		address.focus();
		return false;
		}
	if (!phone.value) {
		alert("전화번호를 입력해주세요.");
		phone.focus();
		return false;
		}
	if (regPhone.test(phone.value) == false) {
		alert("잘못된 형식의 전화번호입니다.");
		phone.focus();
		return false;
		}
	if (!email.value) {
		alert("이름을 입력해주세요.");
		phone.focus();
		return false;
		}
	if (regEmail.test(email.value) == false) {
		alert("잘못된 형식의 이메일입니다.");
		email.focus();
		return false;
		}
	document.updateInfoForm.submit();
}
//아이디 중복 체크
function idDuplicateCheck() {
	
}