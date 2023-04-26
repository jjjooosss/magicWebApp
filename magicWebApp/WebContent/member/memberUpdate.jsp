<%@page import="magic.member.MemberDBBean"%>
<%@page import="magic.member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		String uid = (String)session.getAttribute("uid");
    
    	MemberDBBean mdb = MemberDBBean.getInstatnce();
    	MemberBean mb = mdb.getMember(uid);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js" charset="utf-8"></script>
</head>
<body>
	<table border="1" align ="center">
		<form action="memberUpdateOk.jsp" name="update_frm" method="post">
			<tr height="50">
				<td colspan="2" align="center">
				<h1>회원 정보 수정</h1> <br>
				'*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr height="30">
				<td width="80">User ID</td>
<%-- 			<td><%= mb.getMem_uid() %></td> --%>
				<td><%= uid %></td>
			</tr>
			<tr height="30">
				<td width="80">암호</td>
				<td><input type="password" size="20"  name="mem_pwd">*</td>
			</tr>
			<tr height="30">
				<td width="80">암호 확인</td>
				<td><input type="password" size="20"  name="mem_check">*</td>
			</tr>
			<tr height="30">
				<td width="80">이름</td>
				<td><%= mb.getMem_name() %></td>
			</tr>
			<tr height="30">
				<td width="80">E-mail</td>
				<td><input type="text" size="30" value="<%=mb.getMem_email() %>" name="mem_email">*</td>
			</tr>
			<tr height="30">
				<td width="80">주 소</td>
				<td><input type="text" size="30" name="mem_address">*</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" onclick="update_check_ok()" value="수정">
				<input type="reset" value="다시입력">
				<input type="button" value="수정안함" 
				onclick="javascript:window.location='login.jsp'">
				</td>
			</tr>
		</form>
	</table>
</body>
</html>