<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
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
	      		 <div class="log-before"><a href="${path}/board/login.do">로그인</a><a href="memberJoinForm.do">회원가입</a></div>
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
        <div class="lnb">
          <h2>데이터 분석 시각화</h2>
          <ul class="lnb-menu">
            <li class="active has-sub"><a href="${path}/board/formalData_User.do">정형 데이터 분석</a>
              <ul class="sub">
                <li class="active"><a href="${path}/board/formalData_User.do">사용자 커뮤니티</a></li>
                <li><a href="${path}/board/formalData_Pattern.do">이용패턴 별 사용자 분류</a></li>
                <li><a href="${path}/board/formalData_Product.do">종별 제품별 사용 통계</a></li>
              </ul>
            </li>
            <li class="has-sub"><a href="${path}/board/informalData_User.do">비정형 데이터 분석</a>
              <ul class="sub">
                <li><a href="${path}/board/informalData_User.do">이용 트렌드 분석</a></li>
                <li><a href="${path}/board/informalData_Review.do">리뷰 데이터 감성 분석</a></li>
              </ul>
            </li>
          </ul>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>사용자 커뮤니티</h3>
            <div class="path"><span class="loc">HOME</span><span class="loc">데이터 분석 시각화</span><span class="loc">정형 데이터 분석</span><em class="loc">사용자 커뮤니티</em></div>
          </div>
          <!-- //sub-title -->

          <h4 class="hTy4 alone">분석조건</h4>
          <div class="sel-tb-bx">
            <table class="sel-tb">
              <colgroup>
                <col style="width:150px">
                <col style="width:auto">
                <col style="width:200px">
              </colgroup>
              <tbody>
              <tr>
                <th>분석 기간</th>
                <td colspan="2">
                  <span class="sel-cell cell3"><label for="u-gender">성별</label>
                    <select class="select" id="u-gender">
                      <option>남성</option>
                      <option>여성</option>
                    </select>
                  </span>
                  <span class="sel-cell cell3"><label for="u-age">나이대</label>
                    <select class="select" id="u-age">
                      <option>20</option>
                      <option>30</option>
                    </select>
                  </span>
                  <span class="sel-cell cell3"><label for="u-local">지역</label>
                    <select class="select" id="u-local">
                      <option>서울</option>
                      <option>경기</option>
                    </select>
                  </span>
                </td>
              </tr>
              <tr>
                <th>대상 생활화학 제품</th>
                <td>
                  <span class="sel-cell">
                    <label for="s-date">시작일</label>
                    <input type="text" id="s-date" class="ipt"><button type="button"><img src="./images/ico_calen.png" alt="달력"></button>
                  </span>
                  <span class="sel-cell">
                    <label for="e-date">종료일</label>
                    <input type="text" id="e-date" class="ipt"><button type="button"><img src="./images/ico_calen.png" alt="달력"></button>
                  </span>
                </td>
                <td><button type="button" class="btn medium">분석시작</button></td>
              </tr>
            </tbody>
            </table>
          </div>
          <div class="result">
            시각화 영역
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