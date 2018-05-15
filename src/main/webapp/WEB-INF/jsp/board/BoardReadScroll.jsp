<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />
<link rel="stylesheet" href="css/fonts.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">

<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/common.js"></script>

<!-- 다음에디터 링크 -->
<link rel=stylesheet type=text/css href="daumeditor/css/editor.css" charset=utf-8 />
<script type=text/javascript charset=utf-8 src="daumeditor/js/editor_loader.js"></script>
<title>소비자경험커뮤니티 뉴스피드</title>
<script>
//id값 전송 함수
function fn_id_sumbit(){
	var f = document.form_id;
	f.submit();
}
//탑 검색
function fn_search(){
	document.searchform.submit();	
}

function fn_formSubmit(){
	document.form1.submit();	
}

$(document).ready(function() {
	loadContent();
});

//에디터 본문 내용 불러오기
function loadContent() {
    Editor.modify({
    	"content": document.getElementById("brdmemo") /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
    	});
    }    

// 스크롤 이벤트 발생
$(window).scroll(function(){ // ① 스크롤 이벤트 최초 발생
     
	 var maxHeight = $(document).height();
	 var currentScroll = $(window).scrollTop() + $(window).height();
	 
        // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
         if (maxHeight <= currentScroll ) { //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면
            // 3. class가 scrolling인 것의 요소 중 마지막인 요소를 선택한 다음 그것의 data-bno속성 값을 받아온다.
            //      즉, 현재 뿌려진 게시글의 마지막 bno값을 읽어오는 것이다.( 이 다음의 게시글들을 가져오기 위해 필요한 데이터이다.)
            var lastbno = $(".scrolling:last").attr("data-bno");
         
            $("#loading").append("<img src="+"'./img/loading.gif'"+">");
            
            // 4. ajax를 이용하여 현재 뿌려진 게시글의 마지막 bno를 서버로 보내어 그 다음 게시물 데이터를 받아온다.
            $.ajax({
                type : 'POST',  // 요청 method 방식
                url : 'scrollDown.do',// 요청할 서버의 url
                headers : {
                    "Content-Type" : "application/json",
                    "X-HTTP-Method-Override" : "POST"
                },
                dataType : 'json', // 서버로부터 되돌려받는 데이터의 타입을 명시하는 것이다.
                data : JSON.stringify({ // 서버로 보낼 데이터 명시
                	brdno : lastbno 
                }),
                
                success : function(data){// ajax 가 성공했을시에 수행될 function이다. 이 function의 파라미터는 서버로 부터 return받은 데이터이다.
                	
                    var str = "";
                	
                    // 5. 받아온 데이터가 ""이거나 null이 아닌 경우에 DOM handling을 해준다.
                    if(data != ""){
                    	
                    	//6. 서버로부터 받아온 data가 list이므로 이 각각의 원소에 접근하려면 each문을 사용한다.
                        $(data).each(
                            // 7. 새로운 데이터를 갖고 html코드형태의 문자열을 만들어준다.
                          
                         function(){  
                            	if(this.filecnt > 0){
                                    str += "<div class=" + "'listToChange'" + ">"
                                    +	"<div class=" + "'com-list'" + ">"
                                	+	 "<div class="+ "'com-list-tit'"+">"
                                    +		"<span class="+"'scrolling'"+ "data-bno="+ this.brdno +">No."+ this.brdno +"</span>"	
                                	+		 "<p class="+"'tit'"+">"+ this.brdtitle + "</p>"
                                    +	 "</div>"
                                    +	 "<div class="+ "'com-list-users'"+">"
                                    +	 	"<div class="+ "'users-photo'"+"><img src="+"'./upload_img/" + this.reg_id +"/"+ this.imgName + "'"+"alt="+"'글쓴이사진'"+"></div>"
                                    +       "<div class="+ "'users-info'"+">"                            	
                                    +			"<span class="+"'users-name'"+">"+ this.brdtitle +"</span>"	
                                    +			"<span class="+"'users-date'"+">"+ this.brddate +"</span>"
                                    +       "</div>"     
                                    +    "</div>" 
                                    +	 "<div class="+ "'com-list-cont'"+">"
                                    +		 "<div id="+ "'editor_frame'"+"></div>"+ this.brdmemo
                                    +	 "</div>"     
                                    +    "<div class="+ "'com-list-info'"+">"   
                                    +	"<div class="+"'list-file'"+">" 
                                    +	"<span class="+"'ico-file'"+">첨부파일</span><span class="+ "'num'"+">"+ this.filename +"</span>"	
                                    +	"</div>"
                                    +    "<div class="+ "'list-feed'"+">"                                 
                                    +		"<a href="+"boardRead.do?brdno="+ this.brdno +">"
    								+			"<span class="+"'ico-re'"+">댓글</span><span class="+ "'num'" +">"+ this.replycnt + "</span>"	
    								+			"<span class="+"'ico-heart'"+">좋아요</span><span class="+ "'num'" +">"+ this.brdlike + "</span>"	
    								+		"</a>"
    								+	 "</div>"   						
    								+	"</div>" 
    								+"</div>" 
    								+"</div>"                            		
                            		
                            	}
                            	else 
                            	{
                                    str += "<div class=" + "'listToChange'" + ">"
                                    +	"<div class=" + "'com-list'" + ">"
                                	+	 "<div class="+ "'com-list-tit'"+">"
                                    +		"<span class="+"'scrolling'"+ "data-bno="+ this.brdno +">No."+ this.brdno +"</span>"	
                                	+		 "<p class="+"'tit'"+">"+ this.brdtitle + "</p>"
                                    +	 "</div>"
                                    +	 "<div class="+ "'com-list-users'"+">"
                                    +	 	"<div class="+ "'users-photo'"+"><img src="+"'./upload_img/" + this.reg_id +"/"+ this.imgName + "'"+"alt="+"'글쓴이사진'"+"></div>"
                                    +       "<div class="+ "'users-info'"+">"                            	
                                    +			"<span class="+"'users-name'"+">"+ this.brdtitle +"</span>"	
                                    +			"<span class="+"'users-date'"+">"+ this.brddate +"</span>"
                                    +       "</div>"     
                                    +    "</div>" 
                                    +	 "<div class="+ "'com-list-cont'"+">"
                                    +		 "<div id="+ "'editor_frame'"+"></div>"+ this.brdmemo
                                    +	 "</div>"     
                                    +    "<div class="+ "'com-list-info'"+">"   
                                    +    "<div class="+ "'list-feed'"+">"                                 
                                    +		"<a href="+"boardRead.do?brdno="+ this.brdno +">"
    								+			"<span class="+"'ico-re'"+">댓글</span><span class="+ "'num'" +">"+ this.replycnt + "</span>"	
    								+			"<span class="+"'ico-heart'"+">좋아요</span><span class="+ "'num'" +">"+ this.brdlike + "</span>"	
    								+		"</a>"
    								+	 "</div>"   						
    								+	"</div>" 
    								+"</div>" 
    								+"</div>"                               	
                            	}   	
                            }
                         );
                    	// each
                        // 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다. 
                        $(".listToChange:last").after(str); 
                        $("#loading").remove(); //로딩이미지지움
                    }// if : data!=null
                    else{ // 9. 만약 서버로 부터 받아온 데이터가 없을때
                        alert("더 불러올 데이터가 없습니다.");
                    }// else
     
                }// success
            });// ajax
        }
  
});// scroll event

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
          
          <!-- //list 시작 -->
          <c:forEach var="listview" items="${listview}" varStatus="status">	
			<c:url var="link" value="scrollDown.do">
				<c:param name="brdno" value="${listview.brdno}" />
			</c:url>
          <div class="com-list">
            <div class="com-list-tit">
              <span class="scrolling" data-bno="${listview.brdno}">No.<c:out value="${listview.brdno}"/></span>
              <p class="tit"><c:out value="${listview.brdtitle}"/></p>
            </div>
            <div class="com-list-users">
              <div class="users-photo"><img src="./upload_img/${listview.reg_id}/${listview.imgName}" alt="글쓴이사진"></div>
              <div class="users-info">
                <span class="users-name"><c:out value="${listview.brdwriter}"/></span>
                <span class="users-date"><c:out value="${listview.brddate}"/></span>
              </div>
            </div>
            <div class="com-list-cont">
             <div id="editor_frame"></div><c:out value="${listview.brdmemo}" escapeXml="false"/>
            </div>
            <div class="com-list-info">
			<c:if test="${listview.filecnt > 0}">            
              <div class="list-file">
                <span class="ico-file">첨부파일</span><span class="num"><c:out value="${listview.filename}"/></span>
              </div>
			</c:if>              
              <div class="list-feed">
                <a href="boardRead.do?brdno=<c:out value="${listview.brdno}"/>" >
	                <span class="ico-re">댓글</span><span class="num"><c:out value="${listview.replycnt}"/></span>
	                <span class="ico-heart">좋아요</span><span class="num"><c:out value="${listview.brdlike}"/></span>
                </a>
              </div>
            </div>
          </div>
		  </c:forEach>  

		<!-- 다운스크롤시 조회 추가 -->	
		<div class="listToChange"></div>	
					          
          <div class="side-btns">
			<c:choose>
				<c:when test="${sessionScope.id == null}">
					<br>
				</c:when>
				<c:otherwise>
					<a class="btn-write" href="boardForm.do?brdno=''">글쓰기</a>
				</c:otherwise>
			</c:choose>		          
            <button type="button" class="btn-top">Top</button>
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
