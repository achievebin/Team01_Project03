//로그인 유효성 검증
function signInFormCheck() {
	let id = document.getElementById("sinid");
	let pw = document.getElementById("sinpw");
	
	let regId = /^(?=.*[a-z0-9])[a-z0-9]{5,12}$/;
	let regPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,12}/;
	
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

//아이디 찾기 폼 유효성 검증
function findMyIdFormCheck() {
	let name = document.getElementById("name");
	let phone = document.getElementById("phone");
	
	let regName = /^[가-힇a-zA-Z]+$/;
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	
	if (!name.value) {
		alert("이름을 입력해주세요.");
		name.focus();
		return false;
	}
	if (regName.test(name.value) == false) {
			alert("한글 혹은 영어로 된 이름이어야 합니다.");
			phone.focus();
			return false;
			}
	if (!phone.value) {
		alert("전화번호를 입력해주세요.");
		name.focus();
		return false;
	}
	if (regPhone.test(phone.value) == false) {
			alert("잘못된 형식의 전화번호입니다.");
			phone.focus();
			return false;
			}
	document.findMyIdForm.submit();
	}
	
//비밀번호 찾기 폼 유효성 검증
function findMyPwdFormCheck() {
	let name = document.getElementById("name");
	let phone = document.getElementById("phone");
	let id = document.getElementById("id");
	
	let regName = /^[가-힇a-zA-Z]+$/;
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	let regId = /^(?=.*[a-z0-9])[a-z0-9]{5,12}$/;
	
	if (!name.value) {
		alert("이름을 입력해주세요.");
		name.focus();
		return false;
	}
	if (regName.test(name.value) == false) {
			alert("한글 혹은 영어로 된 이름이어야 합니다.");
			phone.focus();
			return false;
			}
	if (!phone.value) {
		alert("전화번호를 입력해주세요.");
		name.focus();
		return false;
	}
	if (regPhone.test(phone.value) == false) {
			alert("잘못된 형식의 전화번호입니다.");
			phone.focus();
			return false;
			}
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
	document.findMyIdForm.submit();
	}

//회원가입 유효성 검증
function joinFormCheck() {
		let id = document.getElementById("id");
		let pw = document.getElementById("pw");
		let pwCheck = document.getElementById("pwCheck");
		let name = document.getElementById("name");
		let nickname = document.getElementById("nickname");
		const birth = document.getElementById("birth");
		let address = document.getElementById("address");
		let phone = document.getElementById("phone");
		let email = document.getElementById("email");
		
		let regId = /^(?=.*[a-z0-9])[a-z0-9]{5,12}$/;
		let regPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,12}/;
		let regName = /^[가-힇a-zA-Z]+$/;
		let regNickname = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;
		let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
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
		if (regName.test(name.value) == false) {
			alert("한글 혹은 영어로 된 이름이어야 합니다.");
			phone.focus();
			return false;
			}
		if (!nickname.value) {
			alert("닉네임을 입력해주세요.");
			nickname.focus();
			return false;
			}
		if (regNickname.test(nickname.value) == false) {
			alert("영어 또는 숫자 또는 한글로 된 2~16자리의 닉네임을 입력해주세요");
			nickname.focus();
			return false;
			}
		if (!birth.value) {
			alert("생년월일을 입력해주세요");
			birth.focus();
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
			alert("이메일을 입력해주세요.");
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
	let id = document.getElementById("newId");
	let pw = document.getElementById("newPw");
	let name = document.getElementById("newName");
	let nickname = document.getElementById("newNickname");
	const birth = document.getElementById("newBirth");
	let address = document.getElementById("newAddress");
	let phone = document.getElementById("newPhone");
	let email = document.getElementById("newEmail");
	
	let regId = /^(?=.*[a-z0-9])[a-z0-9]{5,12}$/;
	let regPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,12}/;
	let regName = /^[가-힇a-zA-Z]+$/;
	let regNickname = /^(?=.*[a-z0-9가-힣])[a-z0-9가-힣]{2,16}$/;
	let regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	let regEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
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
	if (regName.test(name.value) == false) {
			alert("한글 혹은 영어로 된 이름이어야 합니다.");
			phone.focus();
			return false;
			}
	if (!nickname.value) {
		alert("닉네임을 입력해주세요.");
		nickname.focus();
		return false;
		}
	if (!birth.value) {
		alert("생년월일을 입력해주세요");
		birth.focus();
		return false;
		}
	if (regNickname.test(nickname.value) == false) {
		alert("영어 또는 숫자 또는 한글로 된 2~16자리의 닉네임을 입력해주세요");
		nickname.focus();
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
		alert("이메일을 입력해주세요.");
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
	
//회원탈퇴 유효성 검증
function withdrawFormCheck() {
	let pw = document.getElementById("widpw");
	let regPw = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,12}/;
	
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
	document.withdrawForm.submit();
	}