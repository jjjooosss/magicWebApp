<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");

//    int num = Integer.parseInt(request.getParameter("b_id"));
	int num = Integer.parseInt(request.getParameter("b_id"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript" src="board3.js" charset="utf-8"></script>
</head>
<body>
	<form name="ppp" method="post" action="delete_ok.jsp?b_id=<%= num %>&pageNum=<%= pageNum %>">
		<table>
		<h1>글 삭 제 하 기</h1>
		<tr>
			<td>
				>> 암호를 입력하세요 <<		
			</td>
		</tr>
		<tr>
			<td>
				암 호<input type="password" name="b_pwd" size="12" maxlength="12">		
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" onclick="delete_ok()" value="글삭제">		
				<input type="reset" value="다시작성">		
				<input type="button" onclick="javascript:window.location='list.jsp?pageNum=<%= pageNum %>'" value="글목록">		
			</td>
		</tr>
		
		</table>
	</form>
</body>
</html>