<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />
<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>검색결과</title>

</head>

<body>
	<div class="col-lg-2 col-lg-offset-2">
		<table class="table-bordered">
			<tr>
				<td align="right"><jsp:include page="include/top.jsp" /></td>
			</tr>
			<tr>
				<td align="right"><jsp:include page="include/menu.jsp" /></td>
			</tr>			
			<tr>
				<td>
					<h3>검색어 "<font color="red"><c:out value="${searchVO.searchKeyword}"/></font>" 에 대한 검색결과입니다.( <c:out value="${searchCount}"/>건 )</h3>
				</td>
			</tr>
			<tr>
				<td>
					<h4>키워드검색</h4>
					<h4>공지사항 게시판</h4>
					<ul>
						<c:forEach var="listview" items="${listview}" varStatus="status">
							<li>제목 <c:out value="${listview.brdtitle}"/> 
								작성일 <c:out value="${listview.brddate}"/> 
								조회수 <c:out value="${listview.brdhit}"/>
								작성자 <c:out value="${listview.brdwriter}"/> 
								본문 <c:out value="${listview.brdmemo}"/>
							</li>
						</c:forEach>	
					</ul>
					<h4>소비자경험 게시판</h4>
					<ul>
						<li>데이터</li>
					</ul>
					<h4>이슈 게시판</h4>										
					<ul>
						<li>데이터</li>
					</ul>
				</td>
			</tr>			
			<tr>
				<td align="center"><jsp:include page="include/bottom.jsp" /></td>
			</tr>
		</table>
	</div>	
</body>
</html>
