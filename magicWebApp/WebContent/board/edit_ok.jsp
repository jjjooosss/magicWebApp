<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="magic.board.BoardBean" id="board"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
    request.setCharacterEncoding("utf-8");
 %>
<%	

	//넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");


// 	b_id , b_pwd 를 edit.jsp에서 받는다
// 	int b_id = Integer.parseInt(request.getParameter("b_id"));
// 	String b_pwd = request.getParameter("b_pwd");
// 	useBean으로 board 객체 받아온거에 다 들어있는 내용, 필요없어짐

	BoardDBBean db = BoardDBBean.getInstance();
	int re= db.editBoard(board);
	
	if(re==1){
		response.sendRedirect("list.jsp?pageNum="+pageNum);
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
		alert("글 수정 실패");
		history.back();
		</script>
		<%
	}
%>

