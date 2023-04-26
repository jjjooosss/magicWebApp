<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="magic.board.BoardBean" id="boardBean"></jsp:useBean>
<jsp:setProperty property="*" name="boardBean"/>
<script type="text/javascript">
<%
	request.setCharacterEncoding("utf-8");
	BoardDBBean manager = BoardDBBean.getInstance();
	
	int re= manager.insertBoard(boardBean);
	if(re==1){
		%>
		alert("글이 정상적으로 등록 되었습니다.");
		location.href="write.jsp";
		<%
	}else{
		%>
		alert("글이 등록되지 않았습니다. 다시 작성해주세요.");
		history.back();
		<%
	}
%>
</script>