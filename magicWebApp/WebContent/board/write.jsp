<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="board.js" charset="utf-8"></script>
<body>
	<center>
		<h1>글 올 리 기</h1>
		<form name="reg_frm" method="post" action="write_ok.jsp">
			<table>
				<tr height="50"> 
					<td width="80">작성자</td> 
					<td width="140">
<!-- 						maxlength : 화면단에서 데이터베이스 오류를 미리 방지 -->
						<input type="text" name="b_name" size="10" maxlength="20">
					</td>
				</tr>
				<tr height="50"> 
					<td width="80">이메일</td> 
					<td width="140">
<!-- 						maxlength : 화면단에서 데이터베이스 오류를 미리 방지 -->
						<input type="text" name="b_email" size="24" maxlength="50">
					</td>
				</tr>
				<tr height="30"> 
					<td width="140">글제목</td> 
					<td colspan="3" width="460">
<!-- 						maxlength : 화면단에서 데이터베이스 오류를 미리 방지 -->
						<input type="text" name="b_title" size="56" >
					</td>
				</tr>
				<tr height="50"> 
					<td colspan="4">
						<textarea rows="10" cols="65" name="b_content"></textarea>
					</td>
				</tr>
				<tr height="50" align="center"> 
					<td colspan="4">
						<input type="button" value="글쓰기" onclick="check_ok()">&nbsp;
						<input type="reset" value="다시작성">
					</td>
				</tr>
			</table>
		</form>
	</center>
</body>
</html>