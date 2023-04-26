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
	String sql = "SELECT * FROM MEMBER2";

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String mem_uid= "",pw= "",name= "",sclass= "",p1= "",p2= "",p3= "";
	mem_uid = request.getParameter("mem_uid");
		pw = request.getParameter("pw");
		name = request.getParameter("name");
		sclass = request.getParameter("mclass");
		p1 = request.getParameter("phone1");
		p2 = request.getParameter("phone2");
		p3 = request.getParameter("phone3");
		
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement();
			StringBuffer insertQuery = new StringBuffer();
// 			insert 쿼리 조립
			insertQuery.append("INSERT INTO memberT VALUES('");
			insertQuery.append(mem_uid+"','");
			insertQuery.append(pw+"','");
			insertQuery.append(name+"','");
			insertQuery.append(sclass+"','");
			insertQuery.append(p1+"-"+p2+"-"+p3+"')");
			
// 			조립한 쿼리 확인
			System.out.println(insertQuery.toString());
// 			executeUpdate 메소드 : insert 할때 사용됨
			int re = stmt.executeUpdate(insertQuery.toString());
			
			if(re == 1){
				%>
				추가 성공
				<br>
				<a href="addForm.html">추가작업</a>
				<a href="viewMember.jsp">검색작업</a>
				<%
			}else{
				%>
				<font color="red">추가 실패 ㅠ.ㅠ</font>
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