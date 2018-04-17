<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />
<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/bootstrap.js"></script>

<script type="text/javascript">
function fn_submit(){
	document.form.submit();
}
</script>
<title>Insert title here</title>
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
			<td  height="522">
			<div class="container">
				<div class="col-md-8 col-md-offset-2">
				<div class="well">
						<form name ="form" class="form-horizontal" action="JoinLogin.do" method="post" enctype="multipart/form-data" >
								 <div class="form-group">
								 <input type="hidden" id ="id" name="id"value="<c:out value="${memberInfo.id}"/>">
								 <h3>(<c:out value="${memberInfo.name}"/>)님의 회원가입을 진심으로 축하합니다!<br/> 가입하신 ID로 로그인하실려면 아래 버튼을 클릭해주세요.</h3>
								 <button type="button" class="btn btn-lg btn-success" onclick="fn_submit()">가입한 ID로 로그인</button>
								</div>
						</form>	
						</div>	
						</div>
					</div>
			</td>
		</tr>
		<tr>
			<td align="center"><jsp:include page="include/bottom.jsp" /></td>
		</tr>
	</table>
	</div>
</body>
</html>