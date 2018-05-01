<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>개인맞춤형 생활화학제품 사용 플랫폼</title>
  <link rel="stylesheet" href="css/fonts.css">
  <link rel="stylesheet" href="css/common.css">
  <link rel="stylesheet" href="css/style.css">
  <script src="js/jquery-2.2.3.min.js"></script>  
  <script src="js/common.js"></script>
  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  
<script type="text/javascript">
//id값 전송 함수-회원수정 
function fn_id_sumbit(){
	var f = document.form_id;
	f.submit();
}
//id값 전송 함수2-나의커뮤니티
function fn_id_sumbit2(){
	var f = document.form_id2;
	f.submit();
}
//탑 검색
function fn_search(){
	document.searchform.submit();	
}	    
</script>

<script>
$(document).ready(function() {
	 //이메일선택 자동숨김
	 if (formMember.email_2.value == 'etc') {
		 $('#email_3').show();
		 $('#email_3').focus();
		 formMember.email_3.value ='';
	 }
	 else {
		 $('#email_3').attr("readonly",true);
	 }
	 
	 //프로필사진 input type
	 var fileTarget = $('.upload'); 
	 fileTarget.on('change', function(){ // 값이 변경되면 
		 if(window.FileReader){ // modern browser 
			 var filename = $(this)[0].files[0].name; } 
		 else { // old IE 
			 var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			 } 
	 
	 // 추출한 파일명 삽입 
	 	$(this).siblings('.upload-name').val(filename); 
	 });

	 
//비밀번호
	    $('#password').focusout(function(){
	   	var val = $(this).val(); regex = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,16}$/;
	   
	   	
	   	if(val=="" | val == null){ 	//필수입력
	   		$('#joinMember').attr("disabled", true);
	   	}
	   	else if(!regex.test(val)){ //불일치
	   		$('#chkPass1').html("<font color='red'>비밀번호는 8자리 이상 16이하 영문/숫자를 포함해야합니다. </font>");
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
	    		$('#chkPass2').html("<font color='red'> 비밀번호가 불일치합니다.</font>");	
	    		$('#joinMember').attr("disabled", true);
	    	}
	    	else{    //확인
	    		$('#chkPass2').html("");
         		$('#joinMember').attr("disabled", false); //회원가입버튼 활성화
	    	} 
	  });		  	  	
});

//다음우편번호검색
//load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.
function fn_postSearch() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	                if(fullRoadAddr !== ''){
	                    fullRoadAddr += extraRoadAddr;
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('post_no').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('road_address').value = fullRoadAddr;
	                document.getElementById('jibun_address').value = data.jibunAddress;
						
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    //예상되는 도로명 주소에 조합형 주소를 추가한다.
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';

	                } else {
	                    document.getElementById('guide').innerHTML = '';
	                }
	            }
	        }).open();
	        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
	}


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
 }
 else
 {  
	alert('jpg, gif, png, bmp 확장자만 업로드 가능합니다.');
   	return false;
 }   
}  

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
function fn_formSubmit(){
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

	if (formMember.email_1.value=="") {
		alert("이메일을 입력해주세요.");
		formMember.email_1.focus();
		return;
	}
	
	if (formMember.hom_phone3.value=="") {
		alert("일반전화를 입력해주세요");
		formMember.hom_phone3.focus();
		return;
	}		

	if (formMember.mobile3.value=="") {
		alert("휴대전화를 입력해주세요");
		formMember.mobile3.focus();
		return;
	}			

	if (formMember.road_address.value=="") {
		alert("주소를 입력해주세요");
		formMember.post_no.focus();
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

</script>
</head>

<body>
<p id="accessibility"><a href="#container">본문바로가기</a></p>
<div id="wrap">
  <div id="header">
    <div class="header-top">
      <div class="static">
	      	<c:choose>
	      		<c:when test="${sessionScope.id == null}">
	      		 <div class="log-before"><a href="${path}/board/login.do">로그인</a><a href="memberJoinAgree.do">회원가입</a></div>
	      		</c:when>
	      		<c:otherwise>
	      		 <form id="form_id" name="form_id"  action="memberMypage.do" method="post">
		         <div class="log-after"><span class="my"><strong>${sessionScope.name}(${sessionScope.id})</strong>님 환영합니다.</span>
		         <input type="hidden" name="id" value="${sessionScope.id}">
		         <a href="#" onclick="fn_id_sumbit();">마이페이지</a><a href="${path}/board/logout.do">로그아웃</a></div>
		         </form>
		         <form id="form_id2" name="form_id2"  action="myBoardList.do" method="post">
                 <input type="hidden" name="id" value="${sessionScope.id}">
            	 </form>
		        </c:otherwise>
	        </c:choose>
      </div>
    </div>
    <!-- //header-top -->
    <div class="header-gnb">
      <div class="static clearfix">
        <h1 class="logo"><a href="${path}/board/home.do">개인맞춤형 생활화학제품 사용 플랫폼</a></h1>
        <h2 class="skip">메인메뉴</h2>
        <ul class="gnb">
          <li><a href="${path}/board/home.do">소비자 경험 커뮤니티</a>
            <ul>
              <li><a href="${path}/board/noticeList.do">공지사항</a></li>
              <li><a href="${path}/board/consumerList.do">사용자 커뮤니티</a></li>
              <li><a href="${path}/board/issueList.do">뉴스/보도자료</a></li>
            </ul>
          </li>
          <li><a href="${path}/board/home.do">데이터 분석 시각화</a>
            <ul>
              <li><a href="${path}/board/formalData_User.do">정형 데이터 분석</a>
              <li><a href="${path}/board/informalData_User.do">비정형 데이터 분석</a>
            </ul>
          </li>
          <li><a href="${path}/board/home.do">플랫폼 소개</a>
            <ul>
              <li><a href="${path}/board/infoHome.do">개요</a></li>
              <li><a href="${path}/board/infoSub.do">목적</a></li>
            </ul>
          </li>
        </ul>
        <div class="search-form">
	          <form id='searchform' name="searchform" action="search.do" method="post" enctype="multipart/form-data" >
	            <fieldset>
	              <legend>검색</legend>
	                <input type="text" name='searchKeyword' title="검색어" placeholder='검색어를 입력하세요' value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}">
	                <button type="button" class="btn-search" name='go' onclick="fn_search()">검색</button>
	            </fieldset>
	          </form>
        </div>
      </div>
    </div>
    <!-- //header-gnb -->
    <div class="header-sub"></div>
  </div>
  <!-- //header -->
  <div id="container">
    <div class="sub-visual">
      <div class="static">
        <div class="sub-visual-txt">
          <p class="tx1">안전한 생활화학제품 사용을 위해<br>개인맞춤형 생활화학제품 사용 플랫폼으로 사용한 경험을 나누어 보세요.</p>
        </div>
        <!-- //sub-visual-txt -->
      </div>
      <!-- //static -->
    </div>
    <!-- //sub-visual-txt -->
    <div class="sub-section">
      <div class="static clearfix">
        <div class="lnb">
          <h2>마이페이지</h2>
          <ul class="lnb-menu">
            <li class="active"><a href="#" onclick="fn_id_sumbit();">회원정보 관리</a></li>
            <li><a href="#" onclick="fn_id_sumbit2();">나의 커뮤니티</a></li>
            <li><a href="${path}/board/memberQuit.do">회원탈퇴</a></li>
          </ul>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>회원정보 관리</h3>
            <div class="path"><span class="loc">HOME</span><span class="loc">마이페이지</span><em class="loc">회원정보 관리</em></div>
          </div>
          <!-- //sub-title -->
		  <form name ="formMember" class="form-horizontal" action="memberSave.do" method="post" enctype="multipart/form-data" >  
          <table class="edit-tb mbr-tb">
            <caption>회원가입폼</caption>
            <colgroup>
              <col style="width:16%">
              <col style="width:84%">
            </colgroup>
            <tbody>
              <tr>
                <th><span>프로필 사진</span></th>
                <td>	                
                  <span class="photo"><img src="./upload_img/${memberInfo.id}/${memberInfo.filename}" width="200" height="150" name="previewimg" id="previewimg" alt="사진"></span>
                  <span class="photo-find"></span>
                  <br>
				  <c:forEach var="imagelist" items="${imagelist}" varStatus="status">
				  	<input type="checkbox" name="imgno" value="<c:out value="${imagelist.imgno}"/>">	
				  	<a href="fileDownload?filename=<c:out value="${imagelist.name}"/>&downname=<c:out value="${imagelist.realname }"/>"> 							 
				  <c:out value="${imagelist.name}"/></a> <c:out value="${imagelist.size2String()}"/><br/>
				  </c:forEach>                  
                    <input type="text" id="filename" name="filename" class="upload-name" readonly="readonly" size="13">

                    <label class="btn medium" for="uploadfile" style="cursor:pointer">이미지 찾기</label>
                    <input type="file" style='display: none;'   class="upload"  id="uploadfile" name="uploadfile" onchange="loadname(this,'previewimg')" >
                    <!--<button type="button" class="btn medium blue">확인</button>-->
                </td>
              </tr>            
              <tr>
                <th><span><em class="ess">필수</em>아이디</span></th>
                <td><input type="text" class="ipt-nor" title="아이디" id ="id" name="id" readonly="readonly" value="<c:out value="${memberInfo.id}"/>"></td> 
              </tr>
              <tr>
                <th><span><em class="ess">필수</em>비밀번호</span></th>
                <td><input type="password" class="ipt-nor" title="비밀번호" id ="password" name="password" value="<c:out value="${memberInfo.password}"/>">
                  	<span class="noti">영문/숫자 혼용 8~16자리, 대소문자 구별</span>
                  	<br><span id="chkPass1"></span>
                </td>
              </tr>
              <tr>
                <th><span><em class="ess">필수</em>비밀번호 확인</span></th>
                <td><input type="password" class="ipt-nor" title="비밀번호 확인" id ="re_password" name="re_password" value="<c:out value="${memberInfo.password}"/>">
                	<br><span id="chkPass2" ></span>
                </td>
              </tr>
              <tr>
                <th><span><em class="ess">필수</em>성명(한글)</span></th>
                <td><input type="text" class="ipt-nor" title="성명" name="name" value="<c:out value="${memberInfo.name}"/>"></td>
              </tr>
              <tr>
                <th><span><em class="ess">필수</em>이메일</span></th>
                <td>
                  <input type="hidden" name = "email" value="">
                  <input type="text" class="ipt-nor" title="이메일 아이디" id="email_1" name="email_1" value="<c:out value="${email_1}"/>"> @
                  <input type="text" class="ipt-nor" title="이메일 주소" id="email_3" name="email_3" value="${email_2}">
                  <select class="select" title="이메일 회사" name="email_2" onChange="fn_emailbox()">
						<option value="" >선택하세요</option>
						<option value="gmail.com" 	<c:if test="${email_2 eq 'gmail.com'}">selected</c:if> >gmail.com</option>
						<option value="nate.com"  	<c:if test="${email_2 eq 'nate.com'}">selected</c:if> >nate.com</option>
						<option value="naver.com" 	<c:if test="${email_2 eq 'naver.com' }">selected</c:if> >naver.com</option>
						<option value="hanmail.com" <c:if test="${email_2 eq 'hanmail.com' }">selected</c:if> >hanmail.com</option>
						<option value="etc">직접입력</option>
					</select>
                </td>
              </tr>
              <tr>
                <th><span><em class="ess">필수</em>일반전화</span></th>
                <td>
                  <div class="f-phone">
                    <select class="select" name = "hom_phone1" title="전화번호 지역">
					     <option value="0002" <c:if test="${memberInfo.hom_phone1 eq '0002'}">selected</c:if>>02</option> 
					     <option value="0031" <c:if test="${memberInfo.hom_phone1 eq '0031'}">selected</c:if>>031</option> 
					     <option value="0032" <c:if test="${memberInfo.hom_phone1 eq '0032'}">selected</c:if>>032</option> 
					     <option value="0033" <c:if test="${memberInfo.hom_phone1 eq '0033'}">selected</c:if>>033</option> 
					     <option value="0041" <c:if test="${memberInfo.hom_phone1 eq '0041'}">selected</c:if>>041</option> 
					     <option value="0042" <c:if test="${memberInfo.hom_phone1 eq '0042'}">selected</c:if>>042</option> 
					     <option value="0043" <c:if test="${memberInfo.hom_phone1 eq '0043'}">selected</c:if>>043</option> 
					     <option value="0051" <c:if test="${memberInfo.hom_phone1 eq '0051'}">selected</c:if>>051</option> 
					     <option value="0052" <c:if test="${memberInfo.hom_phone1 eq '0052'}">selected</c:if>>052</option> 
					     <option value="0053" <c:if test="${memberInfo.hom_phone1 eq '0053'}">selected</c:if>>053</option> 
					     <option value="0054" <c:if test="${memberInfo.hom_phone1 eq '0054'}">selected</c:if>>054</option> 
					     <option value="0055" <c:if test="${memberInfo.hom_phone1 eq '0055'}">selected</c:if>>055</option> 
					     <option value="0061" <c:if test="${memberInfo.hom_phone1 eq '0061'}">selected</c:if>>061</option> 
					     <option value="0062" <c:if test="${memberInfo.hom_phone1 eq '0062'}">selected</c:if>>062</option> 
					     <option value="0063" <c:if test="${memberInfo.hom_phone1 eq '0063'}">selected</c:if>>063</option> 
					     <option value="0064" <c:if test="${memberInfo.hom_phone1 eq '0064'}">selected</c:if>>064</option> 
					     <option value="0502" <c:if test="${memberInfo.hom_phone1 eq '0502'}">selected</c:if>>0502</option> 
                    </select> -
                    <input type="text" class="ipt" maxlength="4" title="전화번호 가운데" name = "hom_phone2" value="<c:out value="${memberInfo.hom_phone2}"/>"> -
                    <input type="text" class="ipt" maxlength="4" title="전화번호 끝자리" name = "hom_phone3"value="<c:out value="${memberInfo.hom_phone3}"/>">
                    <!--<button type="button" class="btn medium">수정</button>-->
                  </div>
                </td>
              </tr>
              <tr>
                <th><span><em class="ess">필수</em>휴대전화</span></th>
                <td>
                  <div class="f-phone">
                    <select class="select" name = "mobile1" title="핸드폰 통신사">
					     <option value="0010" <c:if test="${memberInfo.mobile1 eq '0010'}">selected</c:if>>010</option> 
					     <option value="0011" <c:if test="${memberInfo.mobile1 eq '0011'}">selected</c:if>>011</option> 
					     <option value="0016" <c:if test="${memberInfo.mobile1 eq '0016'}">selected</c:if>>016</option> 
					     <option value="0017" <c:if test="${memberInfo.mobile1 eq '0017'}">selected</c:if>>017</option> 
					     <option value="0018" <c:if test="${memberInfo.mobile1 eq '0018'}">selected</c:if>>018</option> 
					     <option value="0019" <c:if test="${memberInfo.mobile1 eq '0019'}">selected</c:if>>019</option> 
                    </select> -
                    <input type="text" class="ipt" maxlength="4" title="핸드폰 가운데" name = "mobile2" value="<c:out value="${memberInfo.mobile2}"/>"> -
                    <input type="text" class="ipt" maxlength="4" title="핸드폰 끝자리" name = "mobile3" value="<c:out value="${memberInfo.mobile3}"/>">
                    <!--<button type="button" class="btn medium">수정</button>-->
                  </div>
                </td>
              </tr>
              <tr>
                <th rowspan="2"><span><em class="ess">필수</em>주소</span></th>
                <td>
                  <div class="f-address">
                    <input type="text" class="ipt-zipc" title="우편번호" id="post_no" name="post_no" placeholder="우편번호" maxlength="5" value="<c:out value="${memberInfo.post_no}"/>">
                    <button type="button" class="btn medium" id="post_Search"  onclick="fn_postSearch()" >우편번호 검색</button>
                  </div>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="f-address">
                    <input type="text" class="full" title="도로명주소" placeholder="도로명주소" id="road_address" name="road_address" readonly value="<c:out value="${memberInfo.road_address}"/>"> 
                    <input type="text" class="full" title="지번주소" placeholder="지번주소" id="jibun_address" name="jibun_address" maxlength="200" value="<c:out value="${memberInfo.jibun_address}"/>"> 
                    <span id="guide" style="color:#999"></span>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
          </form>  
          
          <div class="board-btm-agc">
            <button type="submit" class="btn large blue" id="joinMember" name ='joinMember' onclick="fn_formSubmit()">수정</button>
          </div>
        </div>
        <!-- //contents -->
      </div>
    </div>
    <!-- //sub-section  -->
  </div>
  <!-- //container -->
  <div id="footer">
    <div class="static">
      <div class="copyright">
        <address>서울특별시 광진구 능동로 209 세종대학교 학술정보원 7층 ·  TEL 02-3408-4468  ·  EMAIL bjshin@sejong.ac.kr </address>
        <p class="copy">COPYRIGHT &copy; 인공지능-빅데이터연구센터 ABRC. ALL RIGHTS RESERVED</p>
      </div>
    </div>
  </div>
  <!-- //footer -->
</div>
</body>
</html>