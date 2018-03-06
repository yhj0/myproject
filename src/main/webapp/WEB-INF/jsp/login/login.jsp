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
<title>Insert title here</title>
</head>

<body>
<script type="text/javascript">
//*로그인 스크립트*
    $(document).ready(function(){
        $("#btnLogin").click(function(){
            // 태크.val() : 태그에 입력된 값
            // 태크.val("값") : 태그의 값을 변경 
            var id = $("#id").val();
            var password = $("#password").val();
            if(id == ""){
                alert("아이디를 입력하세요.");
                $("#id").focus(); // 입력포커스 이동
                return; // 함수 종료
            }
            if(password == ""){
                alert("아이디를 입력하세요.");
                $("#password").focus();
                return;
            }
            // 폼 내부의 데이터를 전송할 주소
            //document.formLogin.action="${path}/login/loginCheck"
            // 제출
            document.formLogin.submit();
        });
    });
</script> 
	<div class="col-lg-2 col-lg-offset-2">
		<table class="table-bordered">
			<tr>
				<td align="center"><jsp:include page="include/top.jsp" /></td>
			</tr>
			<tr>
				<td align="center"><jsp:include page="include/menu.jsp" /></td>
			</tr>
			<tr>
				<td align="center" height="522">
					<div class="conainter">
						<div class="col-md-3 col-md-offset-5">
							<div class="login-box well">
								<form name="formLogin" action="loginCheck.do" method="post" enctype="multipart/form-data">
								 <legend>로그인</legend>
												<div class="form-group">
													<input type="text" class="form-control" id="id" name="id" placeholder="아이디" autofocus/>
												</div>
												<div class="form-group">
													<input type="password" class="form-control"  id="password" name="password" placeholder="패스워드"/>
												</div>
												<div class="form-group">
													<input type="button"  id="btnLogin" value="로그인" class="form-control btn-primary"/>
												</div>
												<div class="form-group">
													<a href="memberJoinForm.do">회원가입</a>&nbsp;|&nbsp;<a href="#">ID/PW조회</a>
												</div>
												<c:if test="${msg == 'failure'}">
										        <div style="color: red">
										        	<script type="text/javascript">alert("아이디 또는 비밀번호가 일치하지 않습니다.");</script>
										        </div>
										        </c:if>
										        <c:if test="${msg == 'logout'}">
										        <div style="color: red">
										        	<script type="text/javascript">alert("로그아웃되었습니다.");</script>
										        </div>
										        </c:if>		    	
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