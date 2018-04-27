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

<style>
.hit {
      animation-name: blink;
      animation-duration: 1.5s; 
      animation-timing-function: ease;
      animation-iteration-count: infinite;
      /* 위 속성들을 한 줄로 표기하기 */
      /* -webkit-animation: blink 1.5s ease infinite; */
    }
    /* 애니메이션 지점 설정하기 */
    /* 익스플로러 10 이상, 최신 모던 브라우저에서 지원 */
    @keyframes blink {
      from {color: white;}
      30% {color: #CED8F6;}
      to {color: #2E64FE; font-weight: bold;}
      /* 0% {color:white;}
      30% {color: yellow;}
      100% {color:red; font-weight: bold;} */
    }   
 </style>
<script>
//한글파일 인코딩
function fn_encodeURL(filename,realname){
	  
	 var file = filename;
	 var real = realname	 

	 var url= "fileDownload?filename="+encodeURI(encodeURIComponent(file))+"&downname="+real; 

}

//id값 전송 함수
function fn_id_sumbit(){
	var f = document.form_id;
	f.submit();
}
//탑 검색
function fn_search(){
	document.searchform.submit();	
}

//게시판 검색
function fn_board_search(){
	document.formS.submit();	
}

//페이지 전송 
function fnSubmitForm(page){ 
	document.formPage.page.value=page;
	document.formPage.submit();
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
	        <div class="lnb">
	          <h2>소비자 경험 커뮤니티</h2>
	          <ul class="lnb-menu">
	            <li class="active"><a href="${path}/board/noticeList.do">공지사항</a></li>
	            <li><a href="${path}/board/consumerList.do">사용자 커뮤니티</a></li>
	            <li><a href="${path}/board/issueList.do">뉴스/보도자료</a></li>
	          </ul>
	        </div>
	        <!-- //lnb -->
	        <div class="contents">
	          <div class="sub-title">
	            <h3>공지사항</h3>
	            <div class="path"><span class="loc">HOME</span><span class="loc">소비자 경험 커뮤니티</span><em class="loc">공지사항</em></div>
	          </div>
	          <!-- //sub-title -->
	          <div class="board-search">
	            <form id="formS" name="formS"  method="post" enctype="multipart/form-data" >   
	              <fieldset>
	                <legend>게시판 검색</legend>
	                <select class="select" name="searchType" >
	                  <option value= "brdtitle" <c:if test="${searchVO.searchType eq 'brdtitle'}">checked="checked"</c:if>>제목</option>
	                  <option value= "brdmemo" <c:if test="${searchVO.searchType eq 'brdmemo'}">checked="checked"</c:if>>내용</option>
	                </select>               
	                <input type="text" title="검색어" class="ipt" name="searchKeyword2"  value='<c:out value="${searchVO.searchKeyword2}"/>' onkeydown="if(event.keyCode == 13) { fn_board_search();}">
	                <button type="submit" class="btn" name="btn_search" onclick="fn_board_search()" >검색</button>
	              </fieldset>
	            </form>
	          </div>
	          <!-- //board-search -->
	          <table class="list-tb mgT2">
	            <caption>공지사항 리스트</caption>
	            <colgroup>
	              <col style="width:10%">
	              <col style="width:auto">
	              <col style="width:10%">
	              <col style="width:20%">
	              <col style="width:8%">
	              <col style="width:12%">
	            </colgroup>
	            <thead>
	              <tr>
	                <th>No</th>
	                <th>제목</th>
	                <th>작성자</th>
	                <th>작성일</th>
	                <th>첨부파일</th>
	                <th>조회수</th>
	              </tr>
	            </thead>
	            <tbody>
					<c:forEach var="listview" items="${listview}" varStatus="status">	
						<c:url var="link" value="noticeRead.do">
							<c:param name="brdno" value="${listview.brdno}" />
						</c:url>
					  	<c:choose>
							<c:when test="${listview.brdwriter != null}">
				              <tr class="noti">
				                <td><c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/></td>
				                <td class="title"><a href="${link}"><c:out value="${listview.brdtitle}"/></a>&nbsp;
				                <!-- 인기게시글 표시 -->
								<c:if test="${listview.brdhit>30}">
										<span class="hit">인기글</span>
								</c:if>	
				                </td>
				                <td><c:out value="${listview.brdwriter}"/></td>
				                <td><c:out value="${listview.brddate}"/></td>
				                <td>				                
				                <c:if test="${listview.filecnt > 0}">
				                	<input type="hidden" name="filename" value="<c:out value="${listview.filename}"/>"/>  
				                	<input type="hidden" name="realname" value="<c:out value="${listview.realname}"/>"/> 
				                	<a href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>" class="ico-file" onclick="fn_encodeURL(filename,realname );">첨부파일</a>
				                </c:if>
				                </td>
				                <td><c:out value="${listview.brdhit}"/></td>
				              </tr>								
							</c:when>	
							<c:otherwise>
				              <tr>
				                <td colspan="6"><div class="no-result">검색결과가 없습니다.</div></td>
				              </tr>							
							</c:otherwise>	
		             	</c:choose> 				
					</c:forEach>
	            </tbody>
	          </table>   
	          
			  <form id="formPage" name="formPage"  method="post" enctype="multipart/form-data" >                   
		          <div class="paging">
		          	<c:if test="${searchVO.page>1}">
			            <a href="javascript:fnSubmitForm(1);" class="p-first"></a>
			            <a href="javascript:fnSubmitForm(${searchVO.page-1});" class="p-prev"></a>
		            </c:if>
	
					<c:forEach var="i" begin="${searchVO.pageStart}" end="${searchVO.pageEnd}" step="1" varStatus="status">		 
					 	<c:choose>      
					 		<c:when test="${i eq searchVO.page}">
					 			<strong><c:out value="${i}"/></strong>
					 		</c:when>
					 		<c:otherwise>
					 			<a href="javascript:fnSubmitForm(${i});"><c:out value="${i}"/></a>
					 		</c:otherwise>
					 	</c:choose>	
					 	<c:if test="${not status.last}">|</c:if>	
					 </c:forEach>	
				 
					 <c:if test="${searchVO.totPage > searchVO.page}">
						<a href="javascript:fnSubmitForm(${searchVO.page+1});" class="p-next"></a>
						<a href="javascript:fnSubmitForm(${searchVO.totPage});" class="p-end"></a>			 		    
			         </c:if> 	            
		          </div>
		          <input type="hidden" name="page" id="page" value="" />  
		     	</form>    
				<c:choose>
					<c:when test="${sessionScope.id == 'admin'}">
					<div class="board-btm list-tb-btm">
						<a href="noticeForm.do" class="btn large">글쓰기</a>
					</div>
					</c:when>
					<c:otherwise>

					</c:otherwise>
				</c:choose>		     	 
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
