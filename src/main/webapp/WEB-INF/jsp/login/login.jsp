<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
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
  <script src="js/jquery.cookie.js"></script>
  
<script type="text/javascript">
//*로그인 스크립트*
    $(document).ready(function(){
    	
        //최초 쿠키에 login_id라는 쿠키값이 존재하면
        var login_id = $.cookie('login_id');
        if(login_id != undefined) {
            //아이디에 쿠키값을 담는다
            $("#id").val(login_id);
            //아이디저장 체크박스 체크를 해놓는다
            $("#id-save").prop("checked",true);
        }
    	
        $("#btnLogin").click(function(){
            var id = $("#id").val();
            var password = $("#password").val();
            if(id == ""){
                alert("아이디를 입력하세요.");
                $("#id").focus(); 
                return; 
            }
            if(password == ""){
                alert("비밀번호를 입력하세요.");
                $("#password").focus();
                return;
            }
            
            //아이디저장 체크되어있으면 쿠키저장
	        if($("#id-save").prop("checked")) {
	            $.cookie('login_id', $("#id").val());
	        //아이디저장 미체크면 쿠키에 정보가 있던간에 삭제
	        } else {
	            $.removeCookie("login_id");
	        }
	        
            document.formLogin.submit();
        });
    });
    
    function fn_formSubmit(){
        var id = $("#id").val();
        var password = $("#password").val();
        if(id == ""){
            alert("아이디를 입력하세요.");
            $("#id").focus(); // 입력포커스 이동
            return; // 함수 종료
        }
        if(password == ""){
            alert("비밀번호를 입력하세요.");
            $("#password").focus();
            return;
        }
        
        //아이디저장 체크되어있으면 쿠키저장
        if($("#id-save").prop("checked")) {
            $.cookie('login_id', $("#id").val());
        //아이디저장 미체크면 쿠키에 정보가 있던간에 삭제
        } else {
            $.removeCookie("login_id");
        }
        
        document.formLogin.submit();	
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
        <div class="sub-title">       
          <h3>로그인</h3>
          <div class="path"><span class="loc">HOME</span><em class="loc">로그인</em></div>
        </div>
        <!-- //sub-title -->
 		<form name="formLogin" action="loginCheck.do" method="post" enctype="multipart/form-data">        
        <div class="log-content">
          <div class="log-form">
            <input type="text" title="아이디" placeholder="아이디" class="ipt" id="id" name="id"  autofocus/>
            <input type="password" title="비밀번호" placeholder="비밀번호" class="ipt" id="password" name="password" onkeydown="if(event.keyCode == 13) { fn_formSubmit();}"/>
            <button type="button" class="btn large blue" id="btnLogin" >로그인</button>
          </div>
          <div class="log-btn"><input type="checkbox" id="id-save"><label for="id-save">아이디저장</label></div>
          <div class="log-links"><a href="memberJoinAgree.do">회원가입</a><a href="${path}/board/memberFindID.do">아이디/비밀번호 찾기</a></div>
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
        <!-- //log-content -->
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