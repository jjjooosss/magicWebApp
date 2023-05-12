<%@page import="java.io.File"%>
<%@page import="magic.board.BoardBean"%>
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
	
// 	파일 삭제를 위한 처리
	BoardBean board = manager.getBoard(num, false);
	String fName = board.getB_fname();
// 	upload폴더경로
// 	String up ="D:\\dev\\work_java_josu\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\magicWebApp\\upload";
	String up ="D:\\dev\\work_java_josu\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp1\\wtpwebapps\\magicWebApp\\upload\\";
	
	int re= manager.deleteBoard(num, pwd);
	
	//deleteBoard()에서 글 정상 삭제되면 1 리턴, 아니면 0 리턴
	//글 삭제하면서 파일도 삭제 (좀비파일 없애기 위해)
	if(re==1){
		response.sendRedirect("list.jsp?pageNum="+pageNum);
		if(fName != null){
			//파일 삭제:java.io.File
			File file = new File(up + fName);//객체생성(파일경로+파일이름)
			file.delete();
		}
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

