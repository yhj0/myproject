<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>개인맞춤형 생활화학제품 사용 플랫폼</title>
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />
<link rel="stylesheet" href="css/fonts.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">

<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/common.js"></script>

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
          <h2>검색</h2>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>검색</h3>
            <div class="path"><span class="loc">HOME</span><em class="loc">검색</em></div>
          </div>       
                    
          
          <!-- //sub-title -->
          <div class="result-contents">	
	          		<br>
					<c:if test="${searchVO.searchKeyword ne ''}" >
					<div class="r-list">
						<span class="tit">검색어 "<font color="red"><c:out value="${searchVO.searchKeyword}"/></font>" 에 대한 검색결과입니다.( <c:out value="${searchCount}"/>건 )</span>
					</div>
					</c:if>
					<c:if test="${searchVO.searchKeyword eq ''}" >
					<div class="r-list">
						<span class="tit">검색어 "<font color="red"><c:out value="${searchVO.searchKeyword}"/></font>" 에 대한 검색결과입니다.( 0건 )</span>
					</div>
					</c:if>      
				</div>      
            <div class="result-list">
              <h4>공지사항</h4>
              <c:if test="${searchVO.searchKeyword eq ''}" >
              	<div class="r-list"><span class="tit">검색결과가 없습니다.</span></div>
			  </c:if>
              <c:forEach var="listview" items="${listview}" varStatus="status">
				<c:if test="${listview.brdtype eq 'N'}" >
					<c:url var="link" value="mainRead.do">
						<c:param name="brdno" value="${listview.brdno}" />
						<c:param name="brdtype" value="${listview.brdtype}" />
					</c:url>              
              		<div class="r-list"><span class="tit"><a href="${link}">제목 <c:out value="${listview.brdtitle}"/>; 조회수 <c:out value="${listview.brdtitle}"/>; 작성자 <c:out value="${listview.brdwriter}"/>; 본문 <c:out value="${listview.brdmemo}"/></a></span><span class="date"><c:out value="${listview.brddate}"/></span></div>
              	</c:if>	
              </c:forEach>
            </div>
            <!-- // -->
            <div class="result-list">
              <h4>사용자 커뮤니티</h4>
              <c:if test="${searchVO.searchKeyword eq ''}" >
              	<div class="r-list"><span class="tit">검색결과가 없습니다.</span></div>
			  </c:if>
              <c:forEach var="listview" items="${listview}" varStatus="status">
				<c:if test="${listview.brdtype eq 'C'}" >
					<c:url var="link" value="mainRead.do">
						<c:param name="brdno" value="${listview.brdno}" />
						<c:param name="brdtype" value="${listview.brdtype}" />
					</c:url>              
              		<div class="r-list"><span class="tit"><a href="${link}">제목 <c:out value="${listview.brdtitle}"/>; 조회수 <c:out value="${listview.brdtitle}"/>; 작성자 <c:out value="${listview.brdwriter}"/>; 본문 <c:out value="${listview.brdmemo}"/></a></span><span class="date"><c:out value="${listview.brddate}"/></span></div>
              	</c:if>	
              </c:forEach>
            </div>
            <!-- // -->
            <div class="result-list">
              <h4>뉴스/보도자료</h4>
              <c:if test="${searchVO.searchKeyword eq ''}" >
              	<div class="r-list"><span class="tit">검색결과가 없습니다.</span></div>
			  </c:if>
              <c:forEach var="listview" items="${listview}" varStatus="status">
				<c:if test="${listview.brdtype eq 'I'}" >
					<c:url var="link" value="mainRead.do">
						<c:param name="brdno" value="${listview.brdno}" />
						<c:param name="brdtype" value="${listview.brdtype}" />
					</c:url>              
              		<div class="r-list"><span class="tit"><a href="${link}">제목 <c:out value="${listview.brdtitle}"/>; 조회수 <c:out value="${listview.brdtitle}"/>; 작성자 <c:out value="${listview.brdwriter}"/>; 본문 <c:out value="${listview.brdmemo}"/></a></span><span class="date"><c:out value="${listview.brddate}"/></span></div>
              	</c:if>	
              </c:forEach>
            </div>
            <!-- // -->
            <div class="result-list">
              <h4>정형 데이터 분석</h4>
              <div class="r-list"><span class="tit">분석 내용입니다.</span><span class="date">2018-04-02</span></div>
            </div>
            <!-- // -->
            <div class="result-list">
              <h4>비정형 데이터 분석</h4>
              <div class="r-list"><span class="tit">분석 내용입니다.</span><span class="date">2018-04-02</span></div>
            </div>
            <!-- // -->
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