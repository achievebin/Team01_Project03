//로그인 유효성 검증
function ReserverFrmCheck() {
		let reserv_name = document.getElementById("reserv_name");
		let reserv_phone = document.getElementById("reserv_phone");
		let chk_in = document.getElementById("chk_in");
		let chk_out = document.getElementById("chk_out");
	
	if (!reserv_name.value) {
		alert("이름을 입력해주세요.");
		reserv_name.focus();
		return false;
	}

	if (!reserv_phone.value) {
		alert("전화번호를 입력해주세요.");
		reserv_phone.focus();
		return false;
	}
	if (!chk_in.value) {
		alert("체크인날짜를 입력해주세요.");
		chk_in.focus();
		return false;
	}
	if (!chk_out.value) {
		alert("체크인날짜를 입력해주세요.");
		chk_out.focus();
		return false;
	}	
		

	document.ReserverFrm.submit();
}
