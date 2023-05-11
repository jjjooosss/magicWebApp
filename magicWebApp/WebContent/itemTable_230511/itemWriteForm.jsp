<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <table>
    <h1>정보 입력 폼</h1>
    <form method="post" action="itemWriteResult.jsp">
	    <tr>
	      <td>상품명</td>
	      <td><input type="text" name="name" size="20" maxlength="20"></td>
	    </tr>
	    <tr>
	      <td>가격</td>
	      <td><input type="text" name="price" size="20" maxlength="8"></td>
	    </tr>
	    <tr>
	      <td>설명</td>
	      <td><textarea name="description" rows="20" cols="80" maxlength="100"></textarea></td>
	    </tr>
	    <tr align="center">
	      <td colspan="2">
	        <input type="submit" value="전송">&nbsp;
	        <input type="reset" value="취소">
	      </td>
    </tr>
  </form>
  </table>
</body>
</html>