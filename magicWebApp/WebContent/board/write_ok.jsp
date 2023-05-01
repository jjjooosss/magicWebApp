<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
 %>
<jsp:useBean class="magic.board.BoardBean" id="boardBean"></jsp:useBean>
<jsp:setProperty property="*" name="boardBean"/>
<script>
<%
	request.setCharacterEncoding("utf-8");
	BoardDBBean manager = BoardDBBean.getInstance();
	
	//오늘 날짜 추가 // 위의 setProperty에서 보드빈 객체에 세팅 할때 날짜도 같이 세팅 해주는 것
	boardBean.setB_date(new Timestamp(System.currentTimeMillis()));
	
	
	int re= manager.insertBoard(boardBean);
	if(re==1){
		%>
		alert("글이 정상적으로 등록 되었습니다.");
// 		location.href="list.jsp";
		<%
		response.sendRedirect("list.jsp");
	}else{
		%>
		alert("글이 등록되지 않았습니다. 다시 작성해주세요.");
// 		history.back();
		<%
		response.sendRedirect("write.jsp");
	}
%>
</script>