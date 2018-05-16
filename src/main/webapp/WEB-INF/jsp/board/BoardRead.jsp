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
//id값 전송 함수-회원수정 
function fn_id_sumbit(){
	var f = document.form_id;
	f.submit();
}

//탑 검색
function fn_search(){
	document.searchform.submit();	
}	   
//댓글저장
function fn_formSubmit(){
	var id = document.form_Reply.reg_id.value; 
	
	var form_Reply = document.form_Reply;
	
	if(id == null || id == ""){
		  alert("로그인이 필요합니다.");
		  return false;
	}	
	
	if (form_Reply.rememo.value=="") {
		alert("글 내용을 입력해주세요.");
		form_Reply.rememo.focus();
		return false;
	}
	form_Reply.submit();	
}
//답글저장
function fn_formSubmit2(reno){
	//폼명이 댓글번호(reno)에따라 변경되로독 eval함수 사용
	
	var f = eval("frm"+reno);
	var id = document.form_Reply.reg_id.value; 
	
	if(id == null || id == ""){
		  alert("로그인이 필요합니다.");
		  return false;
	}		
	
	if (f.de_memo.value=="") {
		alert("글 내용을 입력해주세요.");
		f.de_memo.focus();
		return false;
	}
	f.submit();	
}

function fn_replyDelete(reno){
	if (!confirm("삭제하시겠습니까?")) {
		return false;
	}
	var form = document.form2;

	form.action="boardReplyDelete.do";
	form.reno.value=reno;
	form.submit();	
} 


//댓글 글자수세기300자제한
function fn_counting(){
	document.getElementById("sp01").innerHTML = document.getElementById("rememo").value.length;
}
//답글 글자수세기300자제한
function fn_counting_re(reno){
	document.getElementById("sp"+reno).innerHTML = document.getElementById("de_memo"+reno).value.length;
}

//답글 보이기버튼 
function fn_replyShow(obj){
      if (obj.style.display=='none') obj.style.display = 'block';
      else if (obj.style.display=='block') obj.style.display = 'none';
}

$(document).ready(function() {
	$('#like_cancle').hide();
	//좋아요 클릭(증가+) ajax구현
	$('#like').click(function(){
		
	  var id = $(this).val(); 
	  var brdno = $(this).val();
	  var check = document.form_Reply.reg_id.value; //체크아이디용
	  
	  if(check == null || check == ""){
		  alert("로그인이 필요합니다.");
		  return false;
	  }
	  
	  $.ajax({
		  type: "POST",
	      url: "myLikeUp.do", // 통신할 url을 지정한다.
	      data: { "user_id" : $('#reg_id').val(),
	    	  	  "brdno" : $('#brdno').val()						 
	    	  	}, // 서버로 데이터를 전송할 때 이 옵션을 사용한다.
	      dataType: "json", // 서버측에서 전송한 데이터를 어떤 형식의 데이터로서 해석할 것인가를 지정한다. 없으면 알아서 판단한다.
	      success: function(data){
	        // 요청이 성공했을 경우 좋아요/싫어요 개수 레이블 업데이트
	        
	        if($.trim(data) == -1){
	        	alert("해당 게시물에 이미 좋아요를 누르셨습니다.");
	        	return false;
	        }
	        else {
		        alert("좋아요를 눌렀습니다.")
		        $('#like_count').html(data);	
		        $('#like_cancle').show();
	        }
	      },
	      error:function(error){
	        // 요청이 실패했을 경우
	        alert("서비스 요청에 실패했습니다.")
	      }
	  });
	})

	//좋아요 취소(감소-) ajax구현
	$('#like_cancle').click(function(){
		
	  var id = $(this).val(); 
	  var brdno = $(this).val();   
	  $.ajax({
		  type: "POST",
	      url: "myLikeDown.do", // 통신할 url을 지정한다.
	      data: { "user_id" : $('#reg_id').val(),
	    	  	  "brdno" : $('#brdno').val(),						 
	    	  	}, // 서버로 데이터를 전송할 때 이 옵션을 사용한다.
	      dataType: "json", // 서버측에서 전송한 데이터를 어떤 형식의 데이터로서 해석할 것인가를 지정한다. 없으면 알아서 판단한다.
	      success: function(data){
		        alert("좋아요를 취소하였습니다.")
		        $('#like_count').html(data);
		        $('#like_cancle').hide();
	      },
	      error:function(error){
	        // 요청이 실패했을 경우
	        alert("서비스 요청에 실패했습니다.")
	      }
	  });
	})	
	
	//좋아요 취소2 -이미 좋아요가 눌러졌을때 위한버튼
	$('#like_cancle2').click(function(){
		
	  var id = $(this).val(); 
	  var brdno = $(this).val(); 
	  $.ajax({
		  type: "POST",
	      url: "myLikeDown.do", // 통신할 url을 지정한다.
	      data: { "user_id" : $('#reg_id').val(),
	    	  	  "brdno" : $('#brdno').val(),						 
	    	  	}, // 서버로 데이터를 전송할 때 이 옵션을 사용한다.
	      dataType: "json", // 서버측에서 전송한 데이터를 어떤 형식의 데이터로서 해석할 것인가를 지정한다. 없으면 알아서 판단한다.
	      success: function(data){
		        alert("좋아요를 취소하였습니다.")
		        $('#like_count').html(data);
		        $('#like_cancle2').hide();
	      },
	      error:function(error){
	        // 요청이 실패했을 경우
	        alert("서비스 요청에 실패했습니다.")
	      }
	  });
	})		
	
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
          <h2><span>소비자 경험<br>커뮤니티</span></h2>
	          <ul class="lnb-menu">
	            <li><a href="${path}/board/noticeList.do">공지사항</a></li>
	            <li class="active"><a href="${path}/board/consumerList.do">사용자 커뮤니티</a></li>
	            <li><a href="${path}/board/issueList.do">뉴스/보도자료</a></li>
	          </ul>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>사용자 커뮤니티</h3>
             <div class="path"><span class="loc">HOME</span><span class="loc">소비자 경험 커뮤니티</span><em class="loc">사용자 커뮤니티</em></div>
          </div>
          <!-- //sub-title -->
          <table class="view-tb">
            <caption>공지사항 상세</caption>
            <colgroup>
              <col style="width:100px">
              <col style="width:220px">
              <col style="width:100px">
              <col style="width:auto">
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
              </tr>
              <tr>
                <th>제품명</th>
                <td colspan="3"><c:out value="${boardInfo.pro_name}"/></td>              	
              </tr>
              <tr>
                <th>첨부파일</th>
                <td colspan="3">
				<c:forEach var="listview" items="${listview}" varStatus="status">	
					<a class="ico-file-link" href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"><c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
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
                <td colspan="6" class="tb-ctrl"><span class="tb-prev">이전</span><a href="boardRead.do?brdno=<c:out value="${boardInfo.prev_brdno}"/>">이전글 클릭</a></td>
              </tr>
              <tr>
                <td colspan="6" class="tb-ctrl"><span class="tb-next">다음</span><a href="boardRead.do?brdno=<c:out value="${boardInfo.next_brdno}"/>">다음글 클릭</a></td>
              </tr>
            </tbody>
          </table>          
	          	<div class="board-btm">	          	
		           	 <a href="consumerList.do" class="btn large">목록</a>	
				  <!-- 수정권한 본인id 혹은 관리자-->
				  <c:choose>
					 	<c:when test="${sessionScope.id eq boardInfo.reg_id || sessionScope.id eq 'admin'}">		           	           	
				     <a href="boardForm.do?brdno=<c:out value="${boardInfo.brdno}"/>" class="btn large blue">수정</a>
				     <a href="boardDelete.do?brdno=<c:out value="${boardInfo.brdno}"/>" class="btn large">삭제</a>
			            </c:when>
			            <c:otherwise>
							<br>
						</c:otherwise>
				  </c:choose>			            			           
	          	</div>		
          <div class="reply-tit">
            <span class="re-tex">댓글 <c:out value="${boardInfo.replycnt}"/></span>
            <span class="btn-good"><button type="button" id="like" ><span class="ico-heart on">좋아요</span></button><span id="like_count" class="count"><c:out value="${boardInfo.brdlike}"/></span></span>
            <c:if test="${boardInfo.brdlike_yn == 'Y'}">
           		<button type="button" class="btn-good-cancel" id="like_cancle2">좋아요 취소</button>
            </c:if>
            	<button type="button" class="btn-good-cancel" id="like_cancle">좋아요 취소</button>
          </div>     
          <div class="reply-form">
          	<form name="form_Reply" action="boardReplySave.do" method="post">
	            <div class="reply-log"><span class="u-id"><c:out value="${sessionScope.id}"/></span><span class="u-date"><c:out value="${boardInfo.sysdate}"/></span></div>
	            <textarea id="rememo" name="rememo" rows="3" cols="80" maxlength="300"   onkeyup="fn_counting()"></textarea>
	            <div align="right">
	            <span id="sp01">0</span>/300&nbsp;&nbsp;&nbsp;
	            </div>
	            <div class="btns"><button type="button" class="btn large blue" onclick="fn_formSubmit()">등록</button></div>
	            <input type="hidden" name="brdno" id="brdno" value="<c:out value="${boardInfo.brdno}"/>">
	            <input type="hidden" name="reg_id" id="reg_id" value ="<c:out value="${sessionScope.id}"/>">
	            <input type="hidden" name="rewriter" id="rewriter" value="<c:out value="${sessionScope.name}"/>">
            </form>
          </div>  
          <!-- 댓글 start-->         
          <c:forEach var="replylist" items="${replylist}" varStatus="status">  
	          <div class="reply-list">																		
	            <div class="reply-log"><span class="u-id"><c:out value="${replylist.reg_id}"/></span><span class="u-date"><c:out value="${replylist.reg_dttm}"/></span></div>
	            <div class="reply-cont">
	              <c:out value="${replylist.rememo}"/>
	            </div>
	            <button type="button" class="reply-count" id="reply-re" onclick="fn_replyShow(document.getElementById('reply<c:out value="${replylist.reno}"/>'))" >답글
	            <c:forEach var="replycnt" items="${replycnt}" varStatus="status">  
	              <c:if test="${replylist.reno == replycnt.reno}">
	              	<c:out value="${replycnt.cnt}"/>
	              </c:if>
	            </c:forEach>
	            </button>
	          </div>
		          <!-- 답글 start-->
		          	   <div id="reply<c:out value="${replylist.reno}"/>" style="display: none">
				          <c:forEach var="replydeatil" items="${replydeatil}" varStatus="status"> 
					          <c:if test="${replylist.reno == replydeatil.reno}">
								  <div class="replay-list-re" >
								  	<div class="reply-log"><span class="u-id"><c:out value="${replydeatil.reg_id}"/></span><span class="u-date"><c:out value="${replydeatil.reg_dttm}"/></span></div>
								    <div class="reply-cont">
								  		<c:out value="${replydeatil.de_memo}"/>
								    </div>
								  </div>  	
							  </c:if>	          		                    	
				           </c:forEach>            
			 			      <div class="replay-list-re">
						            <div class="reply-form">
						            	<form name="frm<c:out value="${replylist.reno}"/>" action="replyDetailSave.do" method="post">
							                <div class="reply-log"><span class="u-id"><c:out value="${sessionScope.id}"/></span><span class="u-date"><c:out value="${boardInfo.sysdate}"/></span></div>
							                <textarea id="de_memo<c:out value="${replylist.reno}"/>" name="de_memo" rows="3" cols="80" maxlength="300" onkeyup="fn_counting_re(<c:out value="${replylist.reno}"/>)"></textarea>
								            <div align="right">
								            	<span id="sp<c:out value="${replylist.reno}"/>">0</span>/300&nbsp;&nbsp;&nbsp;
								            </div>
								            <div class="btns"><button type="button" class="btn large blue" onclick="fn_formSubmit2(<c:out value="${replylist.reno}"/>)">등록</button></div>
								            <input type="hidden" name="brdno" id="brdno" value="<c:out value="${boardInfo.brdno}"/>">
								            <input type="hidden" name="reno" id="reno" value="<c:out value="${replylist.reno}"/>">					            
								            <input type="hidden" name="reg_id" id="reg_id" value ="<c:out value="${sessionScope.id}"/>">
								            <input type="hidden" name="de_writer" id="de_writer" value="<c:out value="${sessionScope.name}"/>">
						                </form>
						            </div>
						      </div>  
				  	   </div> 
				  <!-- 답글 end -->            
          </c:forEach>   
        <!-- 댓글 end-->               	  
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