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

<script type="text/javascript">
//id값 전송 함수
function fn_id_sumbit(){
	var f = document.form_id;
	f.submit();
}
//탑 검색
function fn_search(){
	document.searchform.submit();	
}

//직접입력박스-아이디
function fn_emailbox(){
	 if (frmId.email_2.value == 'etc') {
		 $('#email_3').show();
		 $('#email_3').attr("readonly",false);
		 $('#email_3').focus();
		 frmId.email_3.value ='';
	 }
	 else {
		 $('#email_3').hide();
	 }
}

//직접입력박스-비밀번호
function fn_emailboxPw(){
	 if (frmPw.email_2Pw.value == 'etc') {
		 $('#email_3Pw').show();
		 $('#email_3Pw').attr("readonly",false);
		 $('#email_3Pw').focus();
		 frmPw.email_3Pw.value ='';
	 }
	 else {
		 $('#email_3Pw').hide();
	 }
}

$(document).ready(function() {
	 //이메일선택 자동숨김
	 if (frmId.email_2.value == 'etc') {
		 $('#email_3').show();
		 $('#email_3').focus();
		 frmId.email_3.value ='';
	 }
	 else {
		 $('#email_3').attr("readonly",true);
	 }
	 
	//아이디찾기
	$('#confirmID').click(function(){
		//기본값 체크
		var frmId = document.frmId;
		
		if (frmId.user_name.value=="") {
			alert("성명을 입력해주세요.");
			frmId.user_name.focus();
			return false;
		}
		if (frmId.email_1.value=="") {
			alert("이메일을 입력해주세요.");
			frmId.email_1.focus();
			return false;
		}
		
		if (frmId.email_2.value=="") {
			alert("이메일을 입력해주세요.");
			frmId.email_3.focus();
			return false;
		}		
	    
		 var user_name = $("#user_name").val();
	     var email = '';
	     
		 	//이메일 직접입력 or 선택유무
		 	if(frmId.email_2.value != 'etc')
		 	{
		 		email = frmId.email_1.value +"@"+frmId.email_2.value 
		 	}
		 	else
		 	{
		 		email = frmId.email_1.value +"@"+frmId.email_3.value 
		 	}	     
		 	
	 	 var params = {"name":user_name, "email":email };
	 	 
	        $.ajax({
	                type: "POST",
	                dataType : 'json',
	                url: "memberSerachID.do",
	                headers : {
	                    "Content-Type" : "application/json",
	                    "X-HTTP-Method-Override" : "POST"
	                },
	            	contentType : "application/json; charset=UTF-8",
	                data: JSON.stringify(params),
	                
	                success: function(data){
	                	
	                	if (data.errId != -1)
	                	{
	                		alert("귀하의 아이디는 '"+data.id+"' 입니다.");
	                	} 
	                	else 
	                	{
	                		alert("입력하신 정보와 일치하는 데이터가 없습니다.");	
	                	}
	                }               
	            }); //비동식 ajax DB접근
		});	 
	 
	//비밀번호찾기
	$('#confirmPw').click(function(){
	    //기본값 체크
		var frmPw = document.frmPw;
	
		if (frmPw.user_id.value=="") {
			alert("아이디를 입력해주세요.");
			frmPw.user_id.focus();
			return false;
		}	
		
		if (frmPw.email_1Pw.value == "") {
			alert("이메일을 입력해주세요.");
			frmPw.email_1Pw.focus();
			return false;
		}
		
		if (frmPw.email_2Pw.value == "") {
			alert("이메일을 입력해주세요.");
			frmPw.email_3Pw.focus();
			return false;
		}
	     
		 var user_id = $("#user_id").val();
	     var emailPw = '';
	     
		 	//이메일 직접입력 or 선택유무
		 	if(frmPw.email_2Pw.value != 'etc')
		 	{
		 		emailPw = frmPw.email_1Pw.value +"@"+frmPw.email_2Pw.value 
		 	}
		 	else
		 	{
		 		emailPw = frmPw.email_1Pw.value +"@"+frmPw.email_3Pw.value 
		 	}	     
		 	
	 	 var params = {"id":user_id, "email":emailPw };
	 	 
	        $.ajax({
	                type: "POST",
	                dataType : 'json',
	                url: "memberSerachPW.do",
	                headers : {
	                    "Content-Type" : "application/json",
	                    "X-HTTP-Method-Override" : "POST"
	                },
	            	contentType : "application/json; charset=UTF-8",
	                data: JSON.stringify(params),
	                
	                success: function(data){
	                	
	                	if (data.errId != -1)
	                	{
	                		alert("귀하의 비밀번호는 '"+data.password+"' 입니다.");
	                	} 
	                	else 
	                	{
	                		alert("입력하신 정보와 일치하는 데이터가 없습니다.");	
	                	}
	                }               
	            }); //비동식 ajax DB접근
		});	 
});

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
          <h2><span>회원정보</span></h2>
          <ul class="lnb-menu">
            <li><a href="${path}/board/memberJoinAgree.do">회원가입</a></li>
            <li class="active"><a href="${path}/board/memberFindID.do">아이디/비밀번호 찾기</a></li>
            <li><a href="${path}/board/memberPrivacyInfo.do">개인정보 처리방침</a></li>
            <li><a href="${path}/board/memberAgreeInfo.do">이용약관</a></li>  
          </ul>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>아이디/비밀번호 찾기</h3>
            <div class="path"><span class="loc">HOME</span><span class="loc">회원정보</span><em class="loc">아이디/비밀번호 찾기</em></div>
          </div>
          <!-- //sub-title -->

          <div class="find-idpw">
            <h4 class="hTy4">아이디 찾기</h4>
            <div class="find-bx">
              <p class="tx">- 회원정보에 저장된 성명, 이메일 주소로 아이디를 찾으실 수 있습니다.</p>
              <form id="frmId" name="frmId" method="post" enctype="multipart/form-data" >  
              <div class="ln-wp">
                <div class="ln">
                  <span class="ln-th">성명</span>
                  <span class="ln-td"><input type="text" title="성명" class="ipt-nor" id="user_name" name="user_name" ></span>
                </div>
                <div class="ln">
                  <span class="ln-th">이메일</span>
                  <span class="ln-td">
                   <input type="hidden" name = "email" value="">
                   <input type="text" class="ipt-nor" title="이메일 아이디" id="email_1" name="email_1" value="${email_3}" style="ime-mode:inactive" > @
                   <input type="text" class="ipt-nor" title="이메일 주소" id="email_3" name="email_3" value="${email_2}" style="ime-mode:inactive" >
	                <select class="select" title="이메일 회사" name="email_2" onChange="fn_emailbox()">
						<option value="" >선택하세요</option>
						<option value="gmail.com" 	<c:if test="${email_2 eq 'gmail.com'}">selected</c:if> >gmail.com</option>
						<option value="nate.com"  	<c:if test="${email_2 eq 'nate.com'}">selected</c:if> >nate.com</option>
						<option value="naver.com" 	<c:if test="${email_2 eq 'naver.com' }">selected</c:if> >naver.com</option>
						<option value="hanmail.com" <c:if test="${email_2 eq 'hanmail.com' }">selected</c:if> >hanmail.com</option>
						<option value="etc">직접입력</option>
					 </select>
                  </span>
                </div>
              </div>
              </form>
            </div>
            <div class="board-btm-agc">
              <button type="submit" class="btn large blue" id="confirmID" >확인</button>
            </div>
          </div>
          <!-- // -->

          <div class="find-idpw">
            <h4 class="hTy4">비밀번호 찾기</h4>
            <div class="find-bx">
              <p class="tx">- 회원정보에 저장된 아이디, 이메일 주소로 비밀번호를 찾으실 수 있습니다.</p>
              <form id="frmPw" name="frmPw" method="post" enctype="multipart/form-data" >  
              <div class="ln-wp">
                <div class="ln">
                  <span class="ln-th">아이디</span>
                  <span class="ln-td"><input type="text" title="아이디" class="ipt-nor" id="user_id" name="user_id" ></span>
                </div>
                <div class="ln">
                  <span class="ln-th">이메일</span>
                  <span class="ln-td">
                  <input type="hidden" name = "emailPw" value="">
                  <input type="text" class="ipt-nor" title="이메일 아이디" id="email_1Pw" name="email_1Pw" value="${email_3}" style="ime-mode:inactive" > @
                  <input type="text" class="ipt-nor" title="이메일 주소" id="email_3Pw" name="email_3Pw" value="${email_2}" style="ime-mode:inactive" >
	                <select class="select" title="이메일 회사" name="email_2Pw" onChange="fn_emailboxPw()">
						<option value="" >선택하세요</option>
						<option value="gmail.com" 	<c:if test="${email_2 eq 'gmail.com'}">selected</c:if> >gmail.com</option>
						<option value="nate.com"  	<c:if test="${email_2 eq 'nate.com'}">selected</c:if> >nate.com</option>
						<option value="naver.com" 	<c:if test="${email_2 eq 'naver.com' }">selected</c:if> >naver.com</option>
						<option value="hanmail.com" <c:if test="${email_2 eq 'hanmail.com' }">selected</c:if> >hanmail.com</option>
						<option value="etc">직접입력</option>
					 </select>
                  </span>
                </div>
              </div>
              </form>
            </div>
            <div class="board-btm-agc">
              <button type="submit" class="btn large blue" id="confirmPw" >확인</button>
            </div>
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