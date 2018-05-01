<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>개인맞춤형 생활화학제품 사용 플랫폼</title>
<link rel="stylesheet" href="css/custom.css" />
<link rel="stylesheet" href="css/fonts.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">

<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/common.js"></script>
<!-- 다음에디터 링크 -->
<link rel=stylesheet type=text/css href="daumeditor/css/editor.css" charset=utf-8 />
<script type=text/javascript charset=utf-8 src="daumeditor/js/editor_loader.js"></script>
<script>
////////////////////////////////////다음 에디터 관련 로직 //////////////////////////////
//1.첫 로드시 다음에디터 부르기 
$(function(){
 $.ajax({
     url : "daumEditor.do",      
     success : function(data){
         $("#editor_frame").html(data);
     }
 });
 loadContent();

//2.본문 내용 불러오기
 function loadContent() {
 Editor.modify({
 	"content": document.getElementById("brdmemo") /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
 	});
 }    
 
//3.저장 버튼 클릭시 이벤트
 $("#save_button").click(function(){
     //다음에디터가 포함된 form submit
    var f = document.form_id2;
	f.submit();
 	Editor.save(); 
 })
})
//4.저장전 유효성 체크
//Editor.save() 호출 한 다음에 validation 검증을 위한 함수
//validation 체크해줄 입력폼들을 이 함수에 추가 지정해줍니다.
function validForm(editor) {
 var form1 = document.form1;
 var validator = new Trex.Validator();
 var content = editor.getContent();
 
	if (form1.brdwriter.value=="") {
		alert("작성자를 입력해주세요.");
		form1.brdwriter.focus();
		return false;
	}
	if (form1.brdtitle.value=="") {
		alert("글 제목을 입력해주세요.");
		form1.brdtitle.focus();
		return false;
	}
 
 if (!validator.exists(content)) {
     alert('내용을 입력하세요');
     return false;
 }
 return true;
}
//5.컨트롤러로 가기전 포멧지정
function setForm(editor) {
	    /*텍스트 본문 저장*/
	    var content = editor.getContent();
	    $("#brdmemo").val(content)

     /* 이미지값 저장 */
     //var images = editor.getAttachments('image');
     //for (i = 0; i < images.length; i++) {
         // existStage는 현재 본문에 존재하는지 여부
     //    if (images[i].existStage) {
             // data는 팝업에서 execAttach 등을 통해 넘긴 데이터
     //        alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data));
     //        input = document.createElement('input');
     //        input.type = 'hidden';
     //        input.name = 'attach_image';
     //        input.value = images[i].data.imageurl;  // 예에서는 이미지경로만 받아서 사용
     //        form.createField(input);
     //    }
     //}    
 
 return true;
}
////////////////////////////////////다음 에디터 관련 로직 끝 //////////////////////////////
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
                 <input type="hidden" name="brdno" value="${boardInfo.brdno}">
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
            <li><a href="#" onclick="fn_id_sumbit();">회원정보 관리</a></li>
            <li class="active"><a href="#" onclick="fn_id_sumbit2();">나의 커뮤니티</a></li>
            <li><a href="${path}/board/memberQuit.do">회원탈퇴</a></li>
          </ul>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>나의 커뮤니티</h3>
            <div class="path"><span class="loc">HOME</span><span class="loc">마이페이지</span><em class="loc">나의 커뮤니티</em></div>
          </div>
          <!-- //sub-title -->
          <form name="form1" action="myBoardSave.do" method="post" enctype="multipart/form-data">
          <table class="edit-tb">
            <caption>공지사항 편집</caption>
            <colgroup>
              <col style="width:100px">
              <col style="width:auto">
              <col style="width:100px">
              <col style="width:25%">
              <col style="width:100px">
              <col style="width:20%">
            </colgroup>
            <tbody>
              <tr>
                <th>제목</th>
                <td colspan="5"><input type="text" title="제목" class="full" name="brdtitle" size="50" maxlength="200" value="<c:out value="${boardInfo.brdtitle}"/>"></td>
              </tr>
              <tr>
                <th>작성자</th>
                <td><input type="text" name="brdwriter" size="20" maxlength="20" readonly="readonly" style="background-color:transparent;border:0px" value="<c:out value="${sessionScope.name}"/>"></td>
                <th>날짜</th>
                <td><c:out value="${sessionScope.sysdate}"/></td>
                <th>조회</th>
                <td><c:out value="${boardInfo.brdhit}"/></td>
              </tr>
              <tr>
                <th>첨부파일</th>
                <td colspan="5">
                  <div class="fileBox">
					<c:forEach var="listview" items="${listview}" varStatus="status">
								<input type="checkbox" name="fileno" value="<c:out value="${listview.fileno}"/>" checked="checked">	
							    <a type="text" href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
								<c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br> 	
					</c:forEach>	   
					<input type="text" class="fileName" readonly="readonly">	
					<label for="uploadBtn" class="btn_file" >찾아보기</label>	
					<input type="file" id="uploadBtn" class="uploadBtn" name="uploadfile" multiple="" />               
                  </div>                  
                </td>
              </tr>
              <tr>
                <td colspan="6">
                  <div id="editor_frame"></div>
                  <textarea name="brdmemo" id="brdmemo" rows="15" cols="80" style="width:600px; height:412px; display: none;"><c:out value="${boardInfo.brdmemo}"/></textarea>
                </td>
              </tr>
            </tbody>
          </table>
          
          <input type="hidden" name="id" value ="<c:out value="${sessionScope.id}"/>">
		  <input type="hidden" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
	          	<div class="board-btm">	          	          	      
		             <a href="#" onclick="fn_id_sumbit2();" class="btn large">목록</a>	            
		             <a href="#" id="save_button" class="btn large blue">확인</a>
		             <a href="myBoardList.do" class="btn large">취소</a>				     
	          	</div>	
          </form>			
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