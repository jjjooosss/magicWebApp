<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
 %>
<jsp:useBean class="magic.board.BoardBean" id="boardBean"></jsp:useBean>
<jsp:setProperty property="*" name="boardBean"/>

<%	

	//넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");

	
	int num = Integer.parseInt(request.getParameter("b_id"));
	String pwd = request.getParameter("b_pwd");

	BoardDBBean manager = BoardDBBean.getInstance();
	
	int re= manager.deleteBoard(num, pwd);
	if(re==1){
		%>
		<script>
		alert("글이 정상적으로 삭제 되었습니다.");
		location.href="list.jsp?pageNum="+pageNum;
		</script>
		<%
	}else if(re == 0){
		%>
		<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
		</script>
		<%
	}else{
		%>
		<script>
		alert("글 삭제 실패");
		history.back();
		</script>
		<%
	}
%>

