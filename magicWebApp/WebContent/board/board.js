/**
 * 
 */
function check_ok() {
	if(reg_frm.b_name.value==""){
	   alert("작성자 칸은 반드시 입력해야 합니다.");
	   reg_frm.b_name.focus();
	   return;
	}
	if(reg_frm.b_title.value==""){
	   alert("글 제목 칸은 반드시 입력해야 합니다.");
	   reg_frm.b_title.focus();
	   return;
	}
	if(reg_frm.b_content.value==""){
	   alert("글 내용은 비워둘 수 없습니다.");
	   reg_frm.b_content.focus();
	   return;
	}
	document.reg_frm.submit();
}