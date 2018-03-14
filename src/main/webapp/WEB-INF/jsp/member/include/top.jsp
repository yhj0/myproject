<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/custom.css" />
<title>Insert title here</title>
</head>
<body>
	<div class="container" align="right">
	<c:choose>
	    <c:when test="${sessionScope.id == null}">
	        <a href="${path}/board/login.do"><br></a>
	    </c:when>
	    <c:otherwise>
	    	<img class='photo2' alt="" src="./upload_img/${sessionScope.id}/${sessionScope.filename}" height="50" width="50" >&nbsp;
	        ${sessionScope.name}(${sessionScope.id}) 님 환영합니다.
	        <a href="${path}/board/memberMypage.do">마이페이지</a>&nbsp;
	        <a href="${path}/board/logout.do">로그아웃</a>
	    </c:otherwise>
	</c:choose>
	</div>
</body>
</html>