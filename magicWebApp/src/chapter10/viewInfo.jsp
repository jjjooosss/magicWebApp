<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<
<!--     오류발생시 보내는 메시지 -->
<!-- 해당 파일이 없으면 http 상태 404 - 찾을 수 없음 -->
<%@ page errorPage ="error02.jsp" %>
<%!
	String s_name;
	int age;
%>
<%
// 	요청 들어오는 것을 utf-8 인코딩으로 한글처리
	request.setCharacterEncoding("utf-8");// 서블릿과 달리 contentType이 아니라 setCha~로 인코딩
	s_name = request.getParameter("name");
// 	request.getParameter() : 반환타입 String
// 	한글이 넘어오면 HTTP 상태 500- 내부서버오류
	age = Integer.parseInt(request.getParameter("age"));
%>
<h3>회원 정보 출력</h3>
당신의 이름은 <%= s_name %>입니다.<br>
당신의 나이는 <%= age %>살입니다.<br>