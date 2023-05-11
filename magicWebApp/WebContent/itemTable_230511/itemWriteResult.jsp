<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
 %>
<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	DataSource ds =null;
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
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
			conn = ds.getConnection();
			
			String sql ="INSERT INTO ITEM_TABLE VALUES(?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setInt(2, price);
			pstmt.setString(3, dec);
			int re = pstmt.executeUpdate();
			
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