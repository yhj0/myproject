<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />
<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui.min.js"></script>
<!-- 다음에디터 링크 -->
<link rel=stylesheet type=text/css href="daumeditor/css/editor.css" charset=utf-8 />
<script type=text/javascript charset=utf-8 src="daumeditor/js/editor_loader.js"></script>
<title>소비자경험커뮤니티 뉴스피드</title>
<script>
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
                            	
                                str += "<tr class=" + "'listToChange'" + ">"
                            	+ 	"<td>"
                            	+	 "<div class="+ "'well'"+">"
                            	+		"<table class="+"'table table-bordered'"+">"
                            	+		 "<tbody>"
                                +			"<tr>"
                                +				"<td>번호</td>"	
                                +				"<td>" + this.brdno + "</td>"  
                                +       	"</tr>"                              	
                                +			"<tr>"
                                +				"<td class="+"'scrolling'"+ "data-bno="+ this.brdno +">제목</td>"	
                                +				"<td>" + this.brdtitle + "</td>"  
                                +       	"</tr>"     
                                +			"<tr>"
                                +				"<td>작성자</td>"	
                                +				"<td>" + this.brdwriter +"("+ this.brddate +")"+ "</td>"  
                                +       	"</tr>"                                     
                                +			"<tr>"
                                +				"<td>내용</td>"	
                                +				"<td>" + this.brdmemo +"</td>"  
                                +       	"</tr>"                                     
                                +			"<tr>"
                                +				"<td>첨부파일</td>"	
                                +				"<td>" + "</td>"
                                +       	"</tr>" 
                                +			"<td colspan="+"'2'"+ "align="+"'right'"+">"
                                +			"<a href="+"boardRead.do?brdno="+ this.brdno +">댓글 "+ this.replycnt + "개</a>"
								+			"&nbsp;&nbsp;좋아요 "+ this.brdlike+"개</td>" 
								+			"</tr>"
								+			"<tr id="+"'showComment'"+">"
								+			"</tr>"								
								+		  "</tbody>"
								+		"</table>"    	
								+		"<a><input type="+"'hidden'"+"value ="+this.id+"></a>"
								+	"</div>"
								+  "</td>"
								+ "</tr>"	
                            }
                         );
                    	// each
                        // 8. 이전까지 뿌려졌던 데이터를 비워주고, <th>헤더 바로 밑에 위에서 만든 str을  뿌려준다.
                        $(".listToChange:last").empty();// 셀렉터 태그 안의 모든 텍스트를 지운다.    
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
	<div class="col-lg-2 col-lg-offset-2">
		<table class="table-bordered">
			<tr>
				<td align="right"><jsp:include page="include/top.jsp" /></td>
			</tr>
			<tr>
				<td align="right"><jsp:include page="include/menu.jsp" /></td>
			</tr>
			<tr>
				<td align="left"  >
					<c:choose>
						<c:when test="${sessionScope.id == null}">
						    <br>
						</c:when>
						<c:otherwise>
						&nbsp;<a class="btn btn-info" href="boardForm.do?brdno=''">글쓰기</a>
						</c:otherwise>
					</c:choose>			
				</td>
			</tr>
			<tr>
				<td>
				<form id="form_menu" name="form_menu" action="boardList.do" method="post" enctype="multipart/form-data">
				<input type="hidden" id="final_reply_no" name="final_reply_no">
						<input type="hidden" name="boardtype"></input>
							<ul class="nav navbar-nav">
								<li><a class="menuLink" href="noticeList.do" >공지사항</a></li>
								<li><a class="menuLink" href="consumerList.do" >최근글</a></li>
								<li><a class="menuLink" href="issueList.do" >최근이슈</a></li>
							</ul>
					</form>
				</td>
			</tr>
			<tr>
				<td align="center">
					<div class="container">
							<table class="table table-bordered" >
									<c:forEach var="listview" items="${listview}" varStatus="status">	
										<c:url var="link" value="scrollDown.do">
											<c:param name="brdno" value="${listview.brdno}" />
										</c:url>		
										<!-- 스크롤시 추가되는 본문 -->  				
										<tr >
											<td>
												<div class="well">			
													<table class="table table-bordered" >
														<tbody>
															<tr>
																<td>번호</td>
																<td class="scrolling" data-bno="${listview.brdno}"><c:out value="${listview.brdno}"/></td>
															</tr>
															<tr>
																<td >제목</td> 
																<td><c:out value="${listview.brdtitle}"/></td> 
															</tr>															
															<tr>
																<td>작성자</td> 
																<td><c:out value="${listview.brdwriter}"/>(<c:out value="${listview.brddate}"/>)</td> 
															</tr>														
															<tr>
																<td>내용</td> 
																<td><div id="editor_frame"></div><c:out value="${listview.brdmemo}" escapeXml="false"/></td> 
															</tr>
															<tr>
																<td>첨부파일</td> 
																<td><c:out value="${listview.filename}"/>(<c:out value="${listview.filesize}"/>)</td> 
															</tr>
															<tr>
																<td colspan="2" align="right" >
																<a href="boardRead.do?brdno=<c:out value="${listview.brdno}"/>" > 댓글 <c:out value="${listview.replycnt}"/>개</a>
																&nbsp;&nbsp;좋아요 <c:out value="${listview.brdlike}"/>개</td> 
															</tr>
															<!-- Comment 태그 추가 -->
															<tr id="showComment">
															</tr>								
														</tbody>
													</table>    
													<!--  
													<div align="center">
														<a class="btn btn-default btn-sm">좋아요+</a>
														<a class="btn btn-default btn-sm">댓글달기+</a>
													</div>		
													-->
													<a><input type="hidden" value ="<c:out value="${sessionScope.id}"/>"></a>
												</div>
											</td>
										</tr>
									</c:forEach>
															
								<!-- 다운스크롤시 조회 추가 -->	
									<tr class="listToChange">
									</tr>									
							</table>
							<div id="loading" align="center" >
							</div>
							<!--  검색창
							<form id="form1" name="form1"  method="post" enctype="multipart/form-data" >
								<div>
									<input type="checkbox" name="searchType" value="brdtitle" <c:if test="${fn:indexOf(searchVO.searchType, 'brdtitle')!=-1}">checked="checked"</c:if>/>
									<label class="chkselect" for="searchType1">제목</label>
									<input type="checkbox" name="searchType" value="brdmemo" <c:if test="${fn:indexOf(searchVO.searchType, 'brdmemo')!=-1}">checked="checked"</c:if>/>
									<label class="chkselect" for="">내용</label>
									<input type="text" name="searchKeyword" style="width:150px;" maxlength="50" value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}">
									<input name="btn_search" value="검색" class="btn btn-success" type="button" onclick="fn_formSubmit()" />
								</div>
							</form>  
							-->	
						</div>			
				</td>
			</tr>
			<tr>
				<td align="center"><jsp:include page="include/bottom.jsp" /></td>
			</tr>
		</table>
	</div>	
</body>
</html>
