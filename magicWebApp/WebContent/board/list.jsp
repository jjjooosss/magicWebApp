<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="magic.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="magic.board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 	넘어오는 페이지 번호를 변수에 저장
	String pageNum = request.getParameter("pageNum");

// 	넘어오는 페이지 번호가 없으면 1페이지
	if(pageNum == null){
		pageNum = "1";
	}
// 	if(pageNum.equals("null")){
// 		pageNum = "1";
// 	}
	
	BoardDBBean db = BoardDBBean.getInstance();
	// 호출된 메소드의 데이터 타입으로 받아주면 됨
// 	ArrayList<BoardBean> boardList = db.listBoard();
	ArrayList<BoardBean> boardList = db.listBoard(pageNum);
	
	int b_id = 0, b_hit=0, b_level =0;
	String b_name, b_email, b_title, b_content, b_ip;
	Timestamp b_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"></script>
</head>
<body>
	<center>
		<h1>게시판에 등록된 글 목록 보기</h1>
		<table width="600">
			<tr>
				<td align="right">
<!-- 				<a href="write.jsp">글쓰기</a> -->
				<a href="write.jsp?pageNum=<%= pageNum %>">글쓰기</a>
				</td>
			</tr>
		</table>
	</center>
	<center>
		<table cellspacing="0" border="1" width="800">
			<tr height="25" align="center">
				<td width="40">번호</td>
				<td width="450">글제목</td>
				<td width="120">작성자</td>
				<td width="120">작성일</td>
				<td width="120">조회수</td>
				<td width="120">ip</td>
			</tr>
			<%
				//boardList에 있는 오라클 데이터를 가져옴
			for (int i = 0; i < boardList.size(); i++) {
				//ArrayList 데이터의 BoardBean 객체를 가져온다.
				BoardBean board = boardList.get(i);
				//board객체에 있는 컬럼의 데이터를 가져온다.
				b_id = board.getB_id();
				b_name = board.getB_name();
				b_email = board.getB_email();
				b_title = board.getB_title();
				b_content = board.getB_content();
				b_date = board.getB_date();
				b_hit = board.getB_hit();
				b_ip = board.getB_ip();
				b_level = board.getB_level();
			%>
			<tr height="50" align="center" bgcolor="#f7f7f7"
				onmouseover="this.style.background='#eeeeef'"
				onmouseout="this.style.background='#f7f7f7'">
				<td align="center"><%=b_id%></td>
				<td>
					<%
// 						b_level 기준으로 화살표 이미지를 들여쓰기로 출력
						if(b_level > 0){//답변글
							for(int j=0; j< b_level; j++){//for 기준으로 들여쓰기를 얼마만큼 할 것인지를 정함
								%>
									&nbsp;
								<%
								}
// 							들여쓰기가 적용된 시점=> 이미지 추가!
							%>
								<img src="/magicWebApp/images/AnswerLine.gif" width="16" height="16">
							<%
							}
					%>
					<!-- 	글 번호를 가지고 글내용 보기 페이지로 이동 --> 
<%-- 					<a href="show.jsp?b_id=<%=b_id%>">  --%>
<!-- 						& => 쿼리스트링 연결 -->
					<a href="show.jsp?b_id=<%=b_id%>&pageNum=<%= pageNum %>"> 
					<%=b_title%>
				</a>
				</td>
				<td align="center"><a href="mailto:<%=b_email %>"> <%=b_name%>
				</a>
				</td>
				<td align="center">
				<%=sdf.format(b_date)%>
				</td>
				<td align="center">
				<%=b_hit%>
				</td>
				<td align="center">
				<%=b_ip%>
				</td>
			</tr>
			<%
				}
			%>

		</table>
<!-- 		페이지 표시 4개 -->
		<%= BoardBean.pageNumber(4) %>
	</center>
</body>
</html>
