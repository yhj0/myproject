<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
function fn_search()
{
	document.searchform.submit();
}
</script>
</head>
<body>
	<div class="container">
		<nav class="navbar navbar-right" role="navigation">
			 	 <ul class="nav navbar-nav">
			 		<li><a class="menuLink" href="http://localhost:8080/board/home.do">홈</a></li>
			 		<li><a class="menuLink" href="http://localhost:8080/board/boardList.do">소비자경험커뮤니티</a></li>
			 		<li><a class="menuLink">데이터분석시각화</a></li>
			 		<c:if test="${sessionScope.id == null}">
			 		<li><a class="menuLink" href="${path}/board/login.do">로그인</a></li>	 		
			 		<li><a class="menuLink" href="${path}/board/memberJoinForm.do">회원가입</a></li>
			 		</c:if>		
			 		<li>
			 		<form id='searchform' name="searchform" action="search.do" method="post" enctype="multipart/form-data">
			 			<div id='form-group'>
			 					<a class="menuLink">
									<input type='text' name='searchKeyword' class='searchInput' placeholder='검색어를 입력하세요' name="searchKeyword" style="width:150px;" maxlength="50" value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}">
									<input type='submit' name='go' class='searchButton' onclick="fn_search()">
								</a>
							</div>
						</form>
			 		</li>
			 	</ul>
		</nav>
	</div>
</body>
</html>