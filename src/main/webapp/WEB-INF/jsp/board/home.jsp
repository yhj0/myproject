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


<script> 
$(document).ready(function(){
	var slider =	$('.bxslider').bxSlider({
			auto: true, autoControls: true, mode:'fade'
		});
		// 클릭시 멈춤 현상 해결 //
		$(document).on('click','.bx-next, .bx-prev',function() {
			slider.stopAuto();
			slider.startAuto();
			slider_01.stopAuto();
			slider_01.startAuto();
		});
		$(document).on('mouseover','.bx-pager, #bx-pager1',function() {
			slider.stopAuto();
			slider.startAuto();
			slider_01.stopAuto();
			slider_01.startAuto();
			slider_02.stopAuto();
			slider_02.startAuto();
		});	
});
</script>
<style>
</style>

<title>Insert title here</title>
</head>

<body>
		<div class="col-lg-2 col-lg-offset-2">
			<table class="table-bordered">
				<tr>
					<td><jsp:include page="include/top.jsp" /></td>
				</tr>
				<tr>
					<td><jsp:include page="include/menu.jsp" /></td>	
				</tr>
				<tr>
					<td align="center">
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
					<td align="center"><img src="./img/bg2.png" height="180" width="900" /></td>
				</tr>
				<tr>
					<td align="center"><jsp:include page="include/bottom.jsp" /></td>
				</tr>
			</table>	
		</div>	
</body>
</html>