<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
 %>
<%!
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String url="jdbc:oracle:thin:@localhost:1521:xe";
	String user="scott";
	String password="tiger";
	String sql = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		String name = "", dec =""; 
		int price;

		name = request.getParameter("name");
		price = Integer.parseInt(request.getParameter("price"));
		dec = request.getParameter("description");
		
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement();
			StringBuffer insertQuery = new StringBuffer();
			insertQuery.append("INSERT INTO ITEM_TABLE (NAME, PRICE, DESCRIPTION) VALUES('");
			insertQuery.append(name+"',");
			insertQuery.append(price+",'");
			insertQuery.append(dec+"')");
			int re = stmt.executeUpdate(insertQuery.toString());
			
			if(re == 1){
				%>
				<a href="itemWrite.jsp"><font size="50">결과보기</font></a>
				<%
			}else{
				%>
				<font color="red">추가 실패</font>
				<%
			}
		}catch(SQLException se){
			se.printStackTrace();
			%>
			서버 불량 잠시 후 다시 시도
			<%
		}
	%>
</body>
</html>