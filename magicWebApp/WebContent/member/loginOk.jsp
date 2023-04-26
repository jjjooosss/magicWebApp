<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<%
	MemberDBBean manager = MemberDBBean.getInstatnce();

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	int check= manager.userCheck(id, pw);
	
	MemberBean mb = manager.getMember(id);
	
	if(mb == null){
		%>
		alert("존재하지 않는 회원");
		<%
	}else{
		String name= mb.getMem_name();
		
			if(check==1){
				session.setAttribute("uid", id);
				session.setAttribute("uName", name);
				session.setAttribute("Member", "yes");//회원여부
				response.sendRedirect("main.jsp");
			}
			else if(check==0){
			%>
			alert("비밀번호가 맞지 않습니다.");
			history.back();//history.go(-1);도 가능
			<%
			}else {//아이디가 불일치(실제 발생되지 않음- 생략 가능)
			%>
			alert("아이디가 맞지 않습니다.");
			history.back();
			<%
			}
		}
%>
</script>
</body>
</html>