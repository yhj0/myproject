<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />
<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/bootstrap.js"></script>

<script>
//직접입력박스
function fn_emailbox(){
	 if (formMember.email_2.value == 'etc') {
		 $('#email_3').show();
		 $('#email_3').attr("readonly",false);
		 $('#email_3').focus();
		 formMember.email_3.value ='';
	 }
	 else {
		 $('#email_3').hide();
	 }
}

// 기본값 체크
function fn_validation() { 

	var formMember = document.formMember;
	
	if (formMember.id.value=="") {
		alert("ID를 입력해주세요.");
		formMember.id.focus();
		return;
	}
	if (formMember.password.value=="") {
		alert("비밀번호를 입력해주세요.");
		formMember.password.focus();
		return;
	}
	if (formMember.name.value=="") {
		alert("이름을 입력해주세요.");
		formMember.name.focus();
		return;
	}
	if (formMember.nick_name.value=="") {
		alert("닉네임을 입력해주세요.");
		formMember.nick_name.focus();
		return;
	}	
	if (formMember.email_1.value=="") {
		alert("이메일을 입력해주세요.");
		formMember.email_1.focus();
		return;
	}		
	//이메일 직접입력 or 선택유무
	if(formMember.email_2.value != 'etc')
	{	
		var e = formMember.email_1.value +"@"+formMember.email_2.value 
		document.formMember.email.value = e;
		document.formMember.submit();	
	}
	else
	{
		var e = formMember.email_1.value +"@"+formMember.email_3.value 
		document.formMember.email.value = e;
		document.formMember.submit();		
	}
}

$(document).ready(function(){
//이메일 박스
		 if (formMember.email_2.value == 'etc') {
			 $('#email_3').show();
			 $('#email_3').focus();
			 formMember.email_3.value ='';
		 }
		 else {
			 $('#email_3').hide();
			 $('#email_3').attr("readonly",true);
			 
		 }	  
	  
//중복ID 체크
	  	$('#id').keyup(function(){
		        	var id = $(this).val();
		            $.ajax({
		                type: "POST",
		                url: "checkID.do",
		                data: {
		                    "id" : $('#id').val()
		                },
		                success: function(data){
		                    if($.trim(data) == 0){
		                    	$('#chkMsg').html("");   
		                    	$('#joinMember').attr("disabled", false); //회원가입버튼 활성화유무
		                    }
		                    else{
		                    	$('#chkMsg').html("<a> 이미 사용중이거나 탈퇴한 아이디입니다.</a>");
		                    	$('#joinMember').attr("disabled", true);
		                    }
		                }
		            }); //비동식 ajax DB접근
  		});
	  	
//비밀번호
	    $('#password').focusout(function(){
	   		var val = $(this).val(); regex = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{4,16}$/;
	   
	   	
	   	if(val=="" | val == null){ 	//필수입력
	   		$('#joinMember').attr("disabled", true);
	   	}
	   	else if(!regex.test(val)){ //불일치
	   		$('#chkPass1').html("<a> 비밀번호는 4자리 이상 16이하 숫자 혹은 특수문자를 반드시 포함해야합니다.</a>");
	   		$('#joinMember').attr("disabled", true);
	   	}
	   	else{    //확인
	   		$('#chkPass1').html("");
        	$('#joinMember').attr("disabled", false); //회원가입버튼 활성화
	   	}
	    });		  	

//비밀번호 확인
	    $('#re_password').focusout(function(){
	    	var orgin = $('#password').val();
	    	
	    	val = $(this).val();
	    	
	    	if(val=="" | val == null){ 	//필수입력
		   		$('#joinMember').attr("disabled", true);
	    	}
	    	else if(val != orgin){  //불일치
	    		$('#chkPass2').html("<a> 비밀번호가 불일치합니다.</a>");	
	    		$('#joinMember').attr("disabled", true);
	    	}
	    	else{    //확인
	    		$('#chkPass2').html("");
            	$('#joinMember').attr("disabled", false); //회원가입버튼 활성화
	    	} 
	  });	
	  	  
});	  
</script>

<script>  
//이미지 불러오기 
function loadname(img, previewName){  

var isIE = (navigator.appName=="Microsoft Internet Explorer");  
var path = img.value;  
var ext = path.substring(path.lastIndexOf('.') + 1).toLowerCase();  

 if(ext == "gif" || ext == "jpeg" || ext == "jpg" ||  ext == "png" )  
 {       
    if(isIE) {  
       $('#'+ previewName).attr('src', path);  
    }else{  
       if (img.files[0]) 
        {  
            var reader = new FileReader();  
            reader.onload = function (e) {  
                $('#'+ previewName).attr('src', e.target.result);  
            }
            reader.readAsDataURL(img.files[0]);  
        }  
    }  

 }else{  
  "incorrect file type"  
 }   
}  
</script>
<title>회원가입</title>
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
						<form name ="formMember" class="form-horizontal" action="memberSave.do" method="post" enctype="multipart/form-data" >
								 <div class="form-group">
									<label class="col-sm-2 control-label">프로필사진</label>
									<div class="col-sm-5">
											<c:forEach var="imagelist" items="${imagelist}" varStatus="status">
												<input type="checkbox" name="imgno" value="<c:out value="${imagelist.imgno}"/>">	
					            				<a href="fileDownload?filename=<c:out value="${imagelist.name}"/>&downname=<c:out value="${imagelist.realname }"/>"> 							 
												<c:out value="${imagelist.name}"/></a> <c:out value="${imagelist.size2String()}"/><br/>
											</c:forEach>
											<img class="photo1" src="./upload_img/basic.jpg" width="200" height="150" name="previewimg" id="previewimg" alt="">
											<input type="file" class="form-control" id ="uploadfile" name="uploadfile" onchange="loadname(this,'previewimg')" >											
									</div>
								 </div>								
								 <div class="form-group">
									<label class="col-sm-2 control-label">아이디</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" id ="id" name="id" placeholder="필수입력" value="<c:out value="${memberInfo.id}"/>" > 
										<span id="chkMsg"></span>
									</div>
								 </div>
								 <div class="form-group" >
									<label class="col-sm-2 control-label" >비밀번호</label>
									<div class="col-sm-5">
										<input type="password" class="form-control" id ="password" name="password" placeholder="필수입력"  value="<c:out value="${memberInfo.password}"/>">
										<span id="chkPass1"></span>
									</div>
								</div>	
		 						 <div class="form-group">
									<label class="col-sm-2 control-label">비밀번호확인</label>
									<div class="col-sm-5">
										<input type="password" class="form-control" id ="re_password" name="re_password" placeholder="필수입력" value="<c:out value="${memberInfo.password}"/>">
										<span id="chkPass2"></span>
									</div>
								 </div>
								 <div class="form-group">
									<label class="col-sm-2 control-label">이름</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" name="name" placeholder="필수입력" value="<c:out value="${memberInfo.name}"/>">
										<br>
									</div>
								</div>	
								 <div class="form-group">
									<label class="col-sm-2 control-label">별명</label>
									<div class="col-sm-5">
										<input type="text" class="form-control" name="nick_name"   value="<c:out value="${memberInfo.nick_name}"/>">
									</div>
								 </div>
								 <div class="form-group">
										<label class="col-sm-2 control-label">이메일</label>
										<div class="col-sm-5">
											<input type="hidden" name = "email" value="">
											<input type="text" class="form-control" id="email_1" name="email_1" placeholder="필수입력"  value="${email_1}"/>
										</div>
										<div class="col-sm-1">
										@
										</div>
										<div class="col-sm-3">
											<select class ="form-control" name="email_2" id="email_2" onChange="fn_emailbox()">
												<option value="" >선택하세요</option>
												<option value="gmail.com" >gmail.com</option>
												<option value="nate.com"  >nate.com</option>
												<option value="naver.com" >naver.com</option>
												<option value="hanmail.com" >hanmail.com</option>
												<option value="etc">직접입력</option>
											</select>
											<input type="text" class="form-control" id="email_3" name="email_3" placeholder="필수입력" value="${email_2}" >
										</div>
								</div>
								<div class="form-group" >
									<div align="center">
										<button type="button" class="btn btn-lg btn-success" id="joinMember" onclick="fn_validation()" >회원가입</button>
									</div>
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