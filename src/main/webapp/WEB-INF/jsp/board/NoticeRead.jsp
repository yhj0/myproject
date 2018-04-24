<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/custom.css" />
<link rel="stylesheet" href="css/fonts.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">

<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/common.js"></script>

<title>개인맞춤형 생활화학제품 사용 플랫폼</title>

<script>
function fn_formSubmit(){
	var form1 = document.form1;
	
	if (form1.rewriter.value=="") {
		alert("작성자를 입력해주세요.");
		form1.rewriter.focus();
		return;
	}
	if (form1.rememo.value=="") {
		alert("글 내용을 입력해주세요.");
		form1.rememo.focus();
		return;
	}
	form1.submit();	
}

function fn_replyDelete(reno){
	if (!confirm("삭제하시겠습니까?")) {
		return;
	}
	var form = document.form2;

	form.action="boardReplyDelete.do";
	form.reno.value=reno;
	form.submit();	
} 

var updateReno = updateRememo = null;
function fn_replyUpdate(reno){
	var form = document.form2;
	var reply = document.getElementById("reply"+reno);
	var replyDiv = document.getElementById("replyDiv");
	replyDiv.style.display = "";
	
	if (updateReno) {
		document.body.appendChild(replyDiv);
		var oldReno = document.getElementById("reply"+updateReno);
		oldReno.innerText = updateRememo;
	} 
	
	form.reno.value=reno;
	form.rememo.value = reply.innerText;
	reply.innerText ="";
	reply.appendChild(replyDiv);
	updateReno   = reno;
	updateRememo = form.rememo.value;
	form.rememo.focus();
} 

function fn_replyUpdateSave(){
	var form = document.form2;
	if (form.rememo.value=="") {
		alert("글 내용을 입력해주세요.");
		form.rememo.focus();
		return;
	}
	
	form.action="boardReplySave.do";
	form.submit();	
} 

function fn_replyUpdateCancel(){
	var form = document.form2;
	var replyDiv = document.getElementById("replyDiv");
	document.body.appendChild(replyDiv);
	replyDiv.style.display = "none";
	
	var oldReno = document.getElementById("reply"+updateReno);
	oldReno.innerText = updateRememo;
	updateReno = updateRememo = null;
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
              <li><a href="#">정형 데이터 분석</a>
              <li><a href="#">비정형 데이터 분석</a>
            </ul>
          </li>
          <li><a href="${path}/board/home.do">플랫폼 소개</a>
            <ul>
              <li><a href="#">개요</a></li>
              <li><a href="#">목적</a></li>
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
          <table class="view-tb">
            <caption>공지사항 상세</caption>
            <colgroup>
              <col style="width:100px">
              <col style="width:auto">
              <col style="width:100px">
              <col style="width:25%">
              <col style="width:100px">
              <col style="width:25%">
            </colgroup>
            <tbody>
              <tr>
                <th>제목</th>
                <td colspan="5"><c:out value="${boardInfo.brdtitle}"/></td>
              </tr>
              <tr>
                <th>작성자</th>
                <td><c:out value="${boardInfo.brdwriter}"/></td>
                <th>날짜</th>
                <td><c:out value="${boardInfo.brddate}"/></td>
                <th>조회</th>
                <td><c:out value="${boardInfo.brdhit}"/></td>
              </tr>
              <tr>
                <th>첨부파일</th>
                <td colspan="5">
				<c:forEach var="listview" items="${listview}" varStatus="status">	
					<a class="ico-file-link" href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 <c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
				</c:forEach>	                
                </td>
              </tr>
              <tr>
                <td colspan="6">
                  <div class="view-cont">
                    <p><c:out value="${boardInfo.brdmemo}" escapeXml="false"/></p>
                  </div>
                </td>
              </tr>
              <tr>
                <td colspan="6" class="tb-ctrl"><span class="tb-prev">이전</span><a href="#">이전글 클릭</a></td>
              </tr>
              <tr>
                <td colspan="6" class="tb-ctrl"><span class="tb-next">다음</span><a href="#">다음글 클릭</a></td>
              </tr>
            </tbody>
          </table>          
	          	<div class="board-btm">
				  <!-- 수정권한 본인id 혹은 관리자-->
				  <c:choose>
					 	<c:when test="${sessionScope.id == boardInfo.reg_id || sessionScope.id == 'admin'}">	          	
				      		<a href="noticeForm.do?brdno=<c:out value="${boardInfo.brdno}"/>" class="btn large blue">수정</a>
				      		<a href="noticeDelete.do?brdno=<c:out value="${boardInfo.brdno}"/>" class="btn large blue">삭제</a>
			            </c:when>
			            <c:otherwise>
							<br>
						</c:otherwise>
				  </c:choose>			            
		           	 <a href="noticeList.do" class="btn large">목록</a>
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
