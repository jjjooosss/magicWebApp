<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.NamingException"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!
		Connection conn = null;
		DataSource ds = null;
	%>
	<%
		try{
// 			InitialContext : dbcp 사용하기 위한 객체 생성
			Context ctx = new InitialContext();
// 			java:comp/env/ :server.xml에서 Resourse 태그에 name을 찾아감
			ds =(DataSource)ctx.lookup("java:comp/env/jdbc/oracle");
			conn = ds.getConnection();
			System.out.println("DBCP 연결 성공");
		}catch(NamingException ne){//dbcp name을 못 찾을때 오류
			ne.printStackTrace();
		}catch(SQLException se){
			se.printStackTrace();
		}finally{
			try{
// 				dbcp 연결된 정보가 있으면 자원 반납
				if(conn != null) conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	%>
</body>
</html>