<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	String url="jdbc:oracle:thin:@localhost:1521:xe";
	String user="scott";
	String password="tiger";
	String sql = "SELECT * FROM ITEM_TABLE";

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>	
	<table width = "800" border="1" cellspacing = "0";>
		<h1>입력 완료된 정보</h1>
		<tr align="center">
			<td size="10">상품 이름</td>
			<td size="30">상품 가격</td>
			<td size="80">상품 설명</td>
		</tr>
		<%
			try{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url, user, password);
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);

				while(rs.next()){
					%>
					<tr>
						<td size="10"><%= rs.getString("NAME") %></td>
						<td size="30"><%= rs.getInt("PRICE") %></td>
						<td size="80"><%= rs.getString("DESCRIPTION") %></td>
					</tr>
					<%
					
				}
			}catch(SQLException se){
				se.printStackTrace();
			}finally{
// 				자원 반납할 때 오류 발생시 처리
				try{
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				}catch(SQLException se){
					se.printStackTrace();
				}
			}
		%>
	</table>
</body>
</html>