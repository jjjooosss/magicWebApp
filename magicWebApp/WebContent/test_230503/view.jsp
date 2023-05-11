<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String select = request.getParameter("pageChange");
	
// 	처음 아무 버튼도 안눌렀을때 뜨는 화면 안해놓으면 select 값이 없어 오류뜬다
// 	== "" || .equals("null") 이렇게 널값뜨는 조건 다 or로 걸기도함.
	if(select == null){
		select="notice.jsp";
	}
	
%>
	<table border="1" width="1000" height="700">
		<tr>
			<td colspan="2">
				<jsp:include page="top.jsp"></jsp:include>
			</td>
		</tr>
		<tr>
			<td width="100" height="500">
				<jsp:include page="left.jsp"></jsp:include>
			</td>
			<td>
				<jsp:include page="<%= select %>"></jsp:include>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<jsp:include page="bottom.jsp"></jsp:include>
			</td>
		</tr>
	</table>
</body>
</html>