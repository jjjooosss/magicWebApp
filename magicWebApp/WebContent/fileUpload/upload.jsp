<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	is 객체 생성 : 이전 데이터로 받기 위해서
	InputStream is = request.getInputStream();
// 	자바 채팅 프로그램 동일 방식
	BufferedReader br = new BufferedReader(new InputStreamReader(is));
	String str = null;
	
// 	readLine() : 문자열 읽어오는 메소드
	while((str = br.readLine()) != null){
		%>
		<%= str %>
		<%
	}
%>