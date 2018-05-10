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

//체크여부
function fn_valid(){
	var chk1 = $('input:checkbox[id="chk-agree1"]').is(":checked");
	var chk2 = $('input:checkbox[id="chk-agree2"]').is(":checked");
	
	if(chk1 != 1){	
		alert('이용약관에 동의해주세요.');
		return false;
	}
	if(chk2 != 1) {
		alert("개인정보 취급방침에 동의해주세요.");
		return false;
	}
	return true;
}

//전송
function fn_submit(){
	if(fn_valid() == true){
		document.form.submit();
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
          <h2>회원정보</h2>
          <ul class="lnb-menu">
            <li class="active"><a href="${path}/board/memberJoinAgree.do">회원가입</a></li>
            <li><a href="${path}/board/memberFindID.do">아이디/비밀번호 찾기</a></li>
            <li><a href="${path}/board/memberPrivacyInfo.do">개인정보 처리방침</a></li>
            <li><a href="${path}/board/memberAgreeInfo.do">이용약관</a></li>  
          </ul>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>회원가입</h3>
            <div class="path"><span class="loc">HOME</span><span class="loc">회원정보</span><em class="loc">회원가입</em></div>
          </div>
          <!-- //sub-title -->

          <div class="agree-form">
            <h4 class="hTy4">이용약관(필수)</h4>
            <div class="terms-bx">
              <div class="terms">
                내용
              </div>
            </div>
            <div class="terms-agree-chk">
              <input type="checkbox" id="chk-agree1"><label for="chk-agree1">이용약관에 동의합니다.</label>
            </div>
            <h4 class="hTy4">개인정보 취급방침(필수)</h4>
            <div class="terms-bx">
              <div class="terms">
                내용
              </div>
            </div>
            <div class="terms-agree-chk">
              <input type="checkbox" id="chk-agree2"><label for="chk-agree2">개인정보 취급방침에 동의합니다.</label>
            </div>
        	<form name="form" action="memberJoinForm.do" method="post" enctype="multipart/form-data">              
	            <div class="board-btm-agc">
	              <button type="button" class="btn large blue" onclick="fn_submit()" >확인</button>
	              <button type="reset" class="btn large" onclick="javascript:history.go(-1)">취소</button>
	            </div>
			</form>              
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
      
