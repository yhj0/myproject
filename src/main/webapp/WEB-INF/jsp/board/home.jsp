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
  
<script type="text/javascript">
//id값 전송 함수
function fn_id_sumbit(){
	var f = document.form_id;
	f.submit();
}

function fn_board_contents(boardValue)
{
	document.form.boardtype.value = boardValue;
	document.form.submit();
}
</script>  
  
  <title>개인맞춤형 생활화학제품 사용 플랫폼</title>
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
      		 <div class="log-before"><a href="${path}/board/login.do">로그인</a><a href="${path}/board/memberJoinForm.do">회원가입</a></div>
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
        <div class="search-form" >
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
    <div class="main-visual">
      <div class="static">
        <div class="main-visual-txt">
          <p class="tx1">안전한 생활화학제품 사용을 위한 커뮤니티</p>
          <p class="tx2">개인맞춤형 생활화학제품 사용 플랫폼</p>
          <div class="search-total-form">
            <form id='searchform' name="searchform" action="search.do" method="post" enctype="multipart/form-data" >
              <fieldset>
                <legend>통합검색폼</legend>
                <input type="text" title="통합검색어" name='searchKeyword' placeholder="사용한 경험을 나누고 유용한 빅데이터 정보를 찾아보세요." value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}">
                <button type="button" class="btn-total-search" name='go' onclick="fn_search()">통합검색</button>
              </fieldset>
            </form>
          </div>
          <!-- //search-total-form -->
        </div>
        <!-- //main-visual-txt -->
      </div>
      <!-- //static -->
    </div>
    <!-- //main-visual-txt -->
    <div class="main-section">
      <div class="sect1">
        <div class="static">
          <h3 class="skip">서비스 링크</h3>
          <ul class="srv-link-list">
            <li><a href="#" class="srv-link1">사용자 행태<br>분석</a></li>
            <li><a href="#" class="srv-link2">이용 트렌드<br>분석</a></li>
            <li><a href="#" class="srv-link3">이용패턴 기반<br>사용자 분류</a></li>
            <li><a href="#" class="srv-link4">리뷰데이터<br>감성 분석</a></li>
            <li><a href="#" class="srv-link5">종별/제품별<br>사용 통계</a></li>
          </ul>
        </div>
      </div>
      <!-- //sect1 -->
      <div class="sect2">
        <div class="static">
          <div class="sect-tit"><h3>커뮤니티</h3><a href="${path}/board/consumerList.do" class="btn-more">더보기</a></div>
          <p class="tx">생활화학제품을 사용한 경험을 나누어 보세요.</p>
          <ul class="comunity-list">
			 <c:forEach var="consumerList" items="${consumerList}" varStatus="status">            
            	<c:url var="link" value="mainRead.do">
					<c:param name="brdno" value="${consumerList.brdno}" />
					<c:param name="brdtype" value="${consumerList.brdtype}" />
				</c:url>  
				
				<c:choose>	
				   <c:when test="${consumerList.notice_flag1 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${consumerList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${consumerList.brdmemo}"/></p>
			                <p class="date"><c:out value="${consumerList.brddate}"/></p>
			                <p class="imgs"><img src="./images/cu_img1.jpg" alt="GMO(유전자조작생물체)오염지도 환경안전지도에 넣어야 한다"></p>
		              	</a>
		             </li>
	              </c:when>
				  <c:when test="${consumerList.notice_flag2 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${consumerList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${consumerList.brdmemo}"/></p>
			                <p class="date"><c:out value="${consumerList.brddate}"/></p>
			                <p class="imgs"><img src="./images/cu_img2.jpg" alt="GMO(유전자조작생물체)오염지도 환경안전지도에 넣어야 한다"></p>
		              	</a>
		             </li>
	              </c:when>	    
				  <c:when test="${consumerList.notice_flag3 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${consumerList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${consumerList.brdmemo}"/></p>
			                <p class="date"><c:out value="${consumerList.brddate}"/></p>
			                <p class="imgs"><img src="./images/cu_img3.jpg" alt="GMO(유전자조작생물체)오염지도 환경안전지도에 넣어야 한다"></p>
		              	</a>
		             </li>
	              </c:when>	 
				  <c:when test="${consumerList.notice_flag4 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${consumerList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${consumerList.brdmemo}"/></p>
			                <p class="date"><c:out value="${consumerList.brddate}"/></p>
			                <p class="imgs"><img src="./images/cu_img4.jpg" alt="GMO(유전자조작생물체)오염지도 환경안전지도에 넣어야 한다"></p>
		              	</a>
		             </li>
	              </c:when>	 	              	                        
				  <c:otherwise>
					<li>    
					</li>
               	  </c:otherwise>
             </c:choose>	
             </c:forEach> 
          </ul>
        </div>
      </div>
      <!-- //sect2 -->
      <div class="sect3">
        <div class="static">
          <div class="sect-tit"><h3>공지사항</h3><a href="${path}/board/noticeList.do" class="btn-more">더보기</a></div>
          <p class="tx">안전한 생활화학제품 사용을 위한 공지사항입니다.</p>
          <ul class="notices-list">
			 <c:forEach var="noticeList" items="${noticeList}" varStatus="status">            
            	<c:url var="link" value="mainRead.do">
					<c:param name="brdno" value="${noticeList.brdno}" />
					<c:param name="brdtype" value="${noticeList.brdtype}" />
				</c:url>  
				
				<c:choose>	
				   <c:when test="${noticeList.notice_flag1 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${noticeList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${noticeList.brdmemo}"/></p>
			                <p class="date"><c:out value="${noticeList.brddate}"/></p>          
		              	</a>
		             </li>
	              </c:when>
				  <c:when test="${noticeList.notice_flag2 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${noticeList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${noticeList.brdmemo}"/></p>
			                <p class="date"><c:out value="${noticeList.brddate}"/></p>
		              	</a>
		             </li>
	              </c:when>	    
				  <c:when test="${noticeList.notice_flag3 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${noticeList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${noticeList.brdmemo}"/></p>
			                <p class="date"><c:out value="${noticeList.brddate}"/></p>
		              	</a>
		             </li>
	              </c:when>	 
				  <c:when test="${noticeList.notice_flag4 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${noticeList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${noticeList.brdmemo}"/></p>
			                <p class="date"><c:out value="${noticeList.brddate}"/></p>               
		              	</a>
		             </li>
	              </c:when>	 	              	                        
				  <c:otherwise>
					<li>    
					</li>
               	  </c:otherwise>
             	</c:choose>	
             </c:forEach>             
          </ul>
        </div>
      </div>
      <!-- //sect3 -->
      <div class="sect4">
        <div class="static">
          <div class="sect-tit"><h3>뉴스/보도자료</h3><a href="${path}/board/issueList.do" class="btn-more">더보기</a></div>
          <p class="tx">생활화학제품 사용에 관련된 최신 뉴스 및 보도자료를 제공합니다.</p>
          <ul class="notices-list">
			 <c:forEach var="issueList" items="${issueList}" varStatus="status">            
            	<c:url var="link" value="mainRead.do">
					<c:param name="brdno" value="${issueList.brdno}" />
					<c:param name="brdtype" value="${issueList.brdtype}" />
				</c:url>  
				
				<c:choose>	
				   <c:when test="${issueList.notice_flag1 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${issueList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${issueList.brdmemo}"/></p>
			                <p class="date"><c:out value="${issueList.brddate}"/></p>          
		              	</a>
		             </li>
	              </c:when>
				  <c:when test="${issueList.notice_flag2 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${issueList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${issueList.brdmemo}"/></p>
			                <p class="date"><c:out value="${issueList.brddate}"/></p>
		              	</a>
		             </li>
	              </c:when>	    
				  <c:when test="${issueList.notice_flag3 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${issueList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${issueList.brdmemo}"/></p>
			                <p class="date"><c:out value="${issueList.brddate}"/></p>
		              	</a>
		             </li>
	              </c:when>	 
				  <c:when test="${issueList.notice_flag4 == 'Y'}">
				     <li>
		               	<a href="${link}" class="noti-item">            
			                <h4 class="tit"><c:out value="${issueList.brdtitle}"/></h4>
			                <p class="con"><c:out value="${issueList.brdmemo}"/></p>
			                <p class="date"><c:out value="${issueList.brddate}"/></p>               
		              	</a>
		             </li>
	              </c:when>	 	              	                        
				  <c:otherwise>
					<li>    
					</li>
               	  </c:otherwise>
             	</c:choose>	
             </c:forEach>  
          </ul>
        </div>
      </div>
      <!-- //sect4 -->
    </div>
    <!-- //main-section  -->
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
