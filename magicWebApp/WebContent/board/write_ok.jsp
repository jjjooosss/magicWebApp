<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="java.net.InetAddress"%>
<%@page import="sun.net.util.IPAddressUtil"%>
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
<%
	out.print("getB_name()### 01===>>>"+boardBean.getB_name());
// 	파일 업로드 처리
	SmartUpload upload = new SmartUpload();
	upload.initialize(pageContext);
	upload.upload();
	String fName="";
	int fileSize=0;
	
	File file = upload.getFiles().getFile(0);
	
	if(!file.isMissing()){
		fName = file.getFileName();
// 		file.saveAs("/upload/"+file.getFieldName());
// 		file.saveAs("./upload/"+file.getFileName());
// 		file.saveAs("../upload/"+file.getFileName());
		file.saveAs("upload/"+file.getFileName());
		fileSize = file.getSize();
	}
%>
<script>
<%
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	
	
	request.setCharacterEncoding("utf-8");
	BoardDBBean manager = BoardDBBean.getInstance();
	
	//오늘 날짜 추가 // 위의 setProperty에서 보드빈 객체에 세팅 할때 날짜도 같이 세팅 해주는 것
	boardBean.setB_date(new Timestamp(System.currentTimeMillis()));
	
	out.print("getB_name()### 02===>>>"+boardBean.getB_name());
// 	String test2 = boardBean.getB_name();
	//파일 업로드 처리
	boardBean.setB_name(upload.getRequest().getParameter("b_name"));
	boardBean.setB_email(upload.getRequest().getParameter("b_email"));
	boardBean.setB_title(upload.getRequest().getParameter("b_title"));
	boardBean.setB_content(upload.getRequest().getParameter("b_content"));
	boardBean.setB_pwd(upload.getRequest().getParameter("b_pwd"));
	
// 	boardBean.setB_ip(request.getRemoteAddr());
	boardBean.setB_ip(ip);
	
	boardBean.setB_fname(fName);
	boardBean.setB_fsize(fileSize);
	
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