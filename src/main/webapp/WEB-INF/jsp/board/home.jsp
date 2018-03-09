<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/jquery.bxslider.min.js"></script>
<script src="js/bootstrap.js"></script>

<!--이미지 롤링 -->
<link rel="stylesheet" href="css/jquery.bxslider.min.css" /> 
<link rel="stylesheet" href="css/bootstrap.css" />
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />

<script> 
$(document).ready(function(){
	var slider =	$('.bxslider').bxSlider({
			auto: true, autoControls: true, mode:'fade'
		});
		// 클릭시 멈춤 현상 해결 //
		$(document).on('click','.bx-next, .bx-prev',function() {
			slider.stopAuto();
			slider.startAuto();
		});
		$(document).on('mouseover','.bx-pager, #bx-pager1',function() {
			slider.stopAuto();
			slider.startAuto();
		});	
});
</script>

<script type="text/javascript">
function fn_board_contents(boardValue)
{
	document.form.boardtype.value = boardValue;
	document.form.submit();
}
</script>

<title>빅데이터센터</title>
</head>

<body>
		<div class="col-lg-2 col-lg-offset-2">
			<table class="table-bordered">
				<tr>
					<td colspan="2"><jsp:include page="include/top.jsp" /></td>
				</tr>
				<tr>
					<td colspan="2"><jsp:include page="include/menu.jsp" /></td>	
				</tr>
				<tr>
					<td colspan="2" align="center">
						<div id="s_banner_wrap" align="center">
							<ul class="bxslider">
						      <li><img src="./img/bg.png" height="270" width="1300" /></li>
						      <li><img src="./img/test2.jpg" height="270" width="1300" /></li>
						      <li><img src="./img/test3.jpg" height="270" width="1300" /></li>
						      <li><img src="./img/test4.jpg" height="270" width="1300" /></li>
						    </ul>
						</div>
					</td>
				</tr>
				<tr>
					<!-- 메인화면 게시판 -->
					<td align="center" width="600" >
						<form id="form" name="form" action="home.do" method="post" enctype="multipart/form-data">
						<input type="hidden" name="boardtype"></input>
							<ul class="nav navbar-nav">
								<li><a class="menuLink" href="#" onclick="fn_board_contents('notice')">공지사항</a></li>
								<li><a class="menuLink" href="#" onclick="fn_board_contents('consumer')">최근글</a></li>
								<li><a class="menuLink" href="#" onclick="fn_board_contents('issue')">최근이슈</a></li>
							</ul>
						</form>
						<div>
							<table class="table table-hover" >
								<colgroup>
									<col width='10%' />
									<col width='45%' />
									<col width='20%' />
									<col width='20%' />
								</colgroup>
								<thead>
									<tr>
										<th>#</th> 
										<th>제목</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="listview" items="${listview}" varStatus="status">	
										<c:url var="link" value="mainRead.do">
											<c:param name="brdno" value="${listview.brdno}" />
											<c:param name="brdtype" value="${listview.brdtype}" />
										</c:url>										  				
										<tr>
											<td><c:out value="${listview.num}"/></td>
											<td style="max-width: 10px;  overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
												<a href="${link}"><c:out value="${listview.brdtitle}"/></a>										
											</td>
											<td><c:out value="${listview.brdwriter}"/></td>
											<td><c:out value="${listview.brddate}"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div> 
					</td>
					<td><img src="./img/bg2.png" height="370" width="600" /></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><jsp:include page="include/bottom.jsp" /></td>
				</tr>
			</table>	
		</div>	
</body>
</html>