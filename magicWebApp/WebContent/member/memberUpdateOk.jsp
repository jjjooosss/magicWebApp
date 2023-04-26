<!-- 데이터 update 처리하는 jsp -->
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean class="magic.member.MemberBean" id="member"></jsp:useBean>
<!-- name="mem_pwd" -->
<!-- name="mem_check" -->
<!-- name="mem_email" -->
<!-- name="mem_address" -->
<!-- 넘어온 값을 셋팅 -->
<!-- 	private String mem_uid; -->
<!-- 	private String mem_pwd; -->
<!-- 	private String mem_name; -->
<!-- 	private String mem_email; -->
<!-- 	private String mem_address; -->
<jsp:setProperty property="*" name="member"/>

<!-- 오류 발생시 데이터 확인할때 -->
<!-- 1. db쪽에 로그 추가해서 확인 -->
<!-- 2. 오류 발생 시점에 더블클릭해서 표시를 하고 debug모드로 톰캣을 재시작해서 f8로 이동하면서  -->
<!-- 값을 확인 -->

<%
	MemberDBBean manager = MemberDBBean.getInstatnce();
	String uid = (String)session.getAttribute("uid");
	member.setMem_uid(uid);
	int re = manager.updateMember(member);
	
	
	if(re==1){
		%>
		<script>
			alert("입력하신 대로 회원 정보가 수정되었습니다");
			location.href="main.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("수정이 실패했습니다.");
			history.go(-1);//back()도 가능
		</script>
		<%
	}
%>