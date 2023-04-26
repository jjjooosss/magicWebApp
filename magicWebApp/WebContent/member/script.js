/**
 * 
 */
function check_ok(){
//	유효성 검사(validation check)
//	이상없으면 action 호출

//	if(document.reg_frm.mem_uid.value.length==0){
//	if(document.reg_frm.mem_uid.value==""){
//	폼 이름에 name 값으로 찾아감 (document생략 가능)
	if(reg_frm.mem_uid.value==""){
	   alert("아이디를 써주세요.");
	   reg_frm.mem_uid.focus();
	   return;
	}else if(reg_frm.mem_uid.value.length < 4){
	   alert("아이디는 4글자이상이어야 합니다.");
	   reg_frm.mem_uid.focus();
	   return;
	}
	if(reg_frm.mem_pwd.value==""){
	   alert("패스워드는 반드시 입력해야 합니다.");
	   reg_frm.mem_pwd.focus();
	   return;
	}
	if(reg_frm.mem_pwd.value != reg_frm.mem_check.value){
	   alert("패스워드가 일치하지 않습니다.");
	   reg_frm.mem_check.focus();
	   return;
	}
	if(reg_frm.mem_name.value==""){
	   alert("이름을 써주세요");
	   reg_frm.mem_name.focus();
	   return;
	}
	if(reg_frm.mem_email.value==""){
	   alert("Email을 써주세요.");
	   reg_frm.mem_email.focus();
	   return;
	}
//	폼이름 reg_frm 에서 action 속성의 파일을 호출
	document.reg_frm.submit();

}

function update_check_ok(){
	if(update_frm.mem_pwd.value==""){
	   alert("패스워드는 반드시 입력해야 합니다.");
	   update_frm.mem_pwd.focus();
	   return;
	}
	if(update_frm.mem_pwd.value != update_frm.mem_check.value){
	   alert("패스워드가 일치하지 않습니다.");
	   update_frm.mem_check.focus();
	   return;
	}
	if(update_frm.mem_email.value==""){
	   alert("Email을 써주세요.");
	   update_frm.mem_email.focus();
	   return;
	}
	document.update_frm.submit();
}