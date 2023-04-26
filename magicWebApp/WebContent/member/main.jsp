
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("Member")==null){
		%>
		<jsp:forward page="login.jsp"></jsp:forward>
		<%
	}
%>
<%
	String uName = (String)session.getAttribute("uName");//오브젝트타입, 다운캐스팅
	String uid = (String)session.getAttribute("uid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" align="center">
		<form method="post" action="logOut.jsp">
			<tr height="30">
				<td>안녕하세요, <%= uName %>(<%= uid %>)님</td>
			</tr>
			<tr height="30">
				<td align="center">
				<input type="submit" value="로그아웃">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" value="회원정보변경" 
				onclick="javascript:window.location='memberUpdate.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>