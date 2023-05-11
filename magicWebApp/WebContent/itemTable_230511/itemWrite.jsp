<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	Connection conn = null;
	PreparedStatement pstmt  = null;
	ResultSet rs = null;
	String sql = "SELECT * FROM ITEM_TABLE";
		
	List<Object> list = new ArrayList<>();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>	
		<%
			try{
				Context ctx = new InitialContext();
				DataSource ds =(DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
				conn = ds.getConnection();
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					list.add(rs.getString(1));
					 list.add(rs.getInt(2));
					 list.add(rs.getString(3));
				}
				
			}catch(SQLException se){
				se.printStackTrace();
			}finally{
			      try{
			          if(pstmt!=null)pstmt.close();
			          if(conn!=null)conn.close();
			      	 }catch(Exception e){
			          
			       }
			    }

			%>
			<table width = "800" border="1" cellspacing = "0";>
				<h1>입력 완료된 정보</h1>
				<tr align="center">
					<td width="80">상품 이름</td>
					<td width="80" >상품 가격</td>
					<td width="200" >상품 설명</td>
				</tr>
				<%
					for(int i = 0; i < list.size(); i+=3){
						String name = (String) list.get(i);
						int price = (int) list.get(i+1);
						String description = (String) list.get(i+2);
				%>
					<tr>
						<td width="80"><%= name %></td>
						<td width="80"><%= price %></td>
						<td width="200"><%= description %></td>
					</tr>
					<%
					}
			
				%>
		</table>
</body>
</html>