<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>

<%!
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String url="jdbc:oracle:thin:@localhost:1521:xe";
	String user="oscott";
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
	<table border="1">
		<tr>
			<td>컬럼명</td>
			<td>컬럼형식</td>
			<td>컬럼길이</td>
			<td>널값여부</td>
		</tr>
		<%
			try{
				String tableName = request.getParameter("table");
				sql = "SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH, NULLABLE "+ 
						"FROM USER_TAB_COLUMNS where TABLE_NAME= ?";
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url, user, password);
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, tableName.toUpperCase());
				pstmt.executeUpdate();
				rs = pstmt.executeQuery(sql);
				
				
				if(!rs.next()){
					%>
					<script>
					alert("존재하지 않는 컬럼명입니다.");
					history.back();
					</script>
					<%
				}
				while(rs.next()){
					%>
					<tr>
						<td><%= rs.getString("COLUMN_NAME") %></td>
						<td><%= rs.getString("DATA_TYPE") %></td>
						<td><%= rs.getInt("DATA_LENGTH") %></td>
						<td><%= rs.getString("NULLABLE") %></td>
					</tr>
					<%
				}
			}catch(SQLException se){
				se.printStackTrace();
			}finally{
				try{
					if(rs != null) rs.close();
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				}catch(SQLException se){
					se.printStackTrace();
				}
			}
		%>
	</table>
</body>
</html>