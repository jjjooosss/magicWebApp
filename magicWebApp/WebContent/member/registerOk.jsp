<%@page import="magic.member.MemberBean"%>
<%@page import="magic.member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mb" class="magic.member.MemberBean"></jsp:useBean>
<!-- 폼 양식에서 전달되는 파라미터 값 얻어와서 -->
<!-- mb 객체의 프로퍼티 값으로 저장 -->
<jsp:setProperty property="*" name="mb"/>
<script>
<%
 	request.setCharacterEncoding("utf-8");
	MemberDBBean manager = MemberDBBean.getInstatnce();
	
	if(manager.confirmID(mb.getMem_uid())==1){//아이디 중복
		%>
		alert("중복되는 아이디가 존재합니다.");
		history.back();
		<%
	}else{// 아이디 중복이 아님
		int re =manager.insertMember(mb);
		if(re ==1){//insert 정상적으로 실행
		%>
		alert("회원가입을 축하드립니다.\n회원으로 로그인 해주세요.");
		document.location.href="login.jsp";
		<%
		}else {//insert 정상적으로 실행이 안됨
		%>
		alert("회원가입에 실패했습니다.");
		document.location.href="login.jsp";//document 생략 가능
		<%
		}
	}
%>
</script>