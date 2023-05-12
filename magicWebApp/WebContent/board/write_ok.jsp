<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
// 	out.print("getB_name()### 01===>>>"+boardBean.getB_name());
// 	파일 업로드 처리
	/*
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
	*/
	String path = request.getRealPath("upload");
	int size=1024*1024;
	int fileSize=0;
	String file="";
	String orifile="";
	
// 	DefaultFileRenamePolicy: 파일명 넘버링처리
	MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());
// 	파일명 가져오기
	Enumeration files = multi.getFileNames();
	String str = files.nextElement().toString();
// 	file : 넘버링 처리된 파일명
	file = multi.getFilesystemName(str);
	
	if(file != null){
// 		orifile : 실제파일명
		orifile = multi.getOriginalFileName(str);
		fileSize = file.getBytes().length;
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
	/*
	boardBean.setB_id(upload.getRequest().getParameter("b_id"));
	boardBean.setB_ref(upload.getRequest().getParameter("b_ref"));
	boardBean.setB_name(upload.getRequest().getParameter("b_name"));
	boardBean.setB_email(upload.getRequest().getParameter("b_email"));
	boardBean.setB_title(upload.getRequest().getParameter("b_title"));
	boardBean.setB_content(upload.getRequest().getParameter("b_content"));
	boardBean.setB_pwd(upload.getRequest().getParameter("b_pwd"));
	*/
	
	boardBean.setB_id(Integer.parseInt(multi.getParameter("b_id")));
	boardBean.setB_ref(Integer.parseInt(multi.getParameter("b_ref")));
	boardBean.setB_name(multi.getParameter("b_name"));
	boardBean.setB_email(multi.getParameter("b_email"));
	boardBean.setB_title(multi.getParameter("b_title"));
	boardBean.setB_content(multi.getParameter("b_content"));
	boardBean.setB_pwd(multi.getParameter("b_pwd"));
	
	if(file != null){
		boardBean.setB_fname(file);
		boardBean.setB_fsize(fileSize);
		boardBean.setB_rfname(orifile);
	}
	
// 	boardBean.setB_ip(request.getRemoteAddr());
	boardBean.setB_ip(ip);
	
// 	boardBean.setB_fname(fName);
// 	boardBean.setB_fsize(fileSize);
	
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