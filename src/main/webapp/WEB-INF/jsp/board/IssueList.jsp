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
      30% {color: grey;}
      to {color: black; font-weight: bold;}
      /* 0% {color:white;}
      30% {color: yellow;}
      100% {color:red; font-weight: bold;} */
    }   
 </style>
<title>board</title>
<script>
function fn_formSubmit(){
	document.form1.submit();	
}

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
						&nbsp;<a class="btn btn-info" href="issueForm.do">글쓰기</a>
						</c:otherwise>
					</c:choose>			
				</td>
			</tr>
			<tr>
				<td>
				<form id="form_menu" name="form_menu" action="issueList.do" method="post" enctype="multipart/form-data">
						<input type="hidden" name="boardtype"></input>
							<ul class="nav navbar-nav">
								<li><a class="menuLink" href="noticeList.do" >공지사항</a></li>
								<li><a class="menuLink" href="boardList.do" >최근글</a></li>
								<li><a class="menuLink" href="issueList.do" >최근이슈</a></li>
							</ul>
					</form>
				</td>
			</tr>
			<tr>
				<td align="center">
					<div class="container">
							<table class="table table-hover" >
								<colgroup>
									<col width='8%' />
									<col width='*%' />
									<col width='15%' />
									<col width='15%' />
									<col width='10%' />
									<col width='10%' />
								</colgroup>
								<thead>
									<tr>
										<th>#</th> 
										<th>제목</th>
										<th>작성일</th>
										<th>작성자</th>
										<th>조회</th>
										<th>댓글</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="listview" items="${listview}" varStatus="status">	
										<c:url var="link" value="issueRead.do">
											<c:param name="brdno" value="${listview.brdno}" />
										</c:url>		
																  				
										<tr>
											<td><c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/></td>
											<td style="max-width: 100px;  overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
												<a href="${link}"><c:out value="${listview.brdtitle}"/></a>
												<!-- 
												<c:if test="${listview.replycnt>0}">
													(<c:out value="${listview.replycnt}"/>)
												</c:if>
												 -->
												<!-- 인기게시글 표시 -->
												<c:if test="${listview.brdhit>30}">
													<span class="hit">인기글</span>
												</c:if>												
											</td>
											<td><c:out value="${listview.brddate}"/></td>
											<td><c:out value="${listview.brdwriter}"/></td>
											<td><c:out value="${listview.brdhit}"/></td>
											<td><c:out value="${listview.replycnt}"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<form id="form1" name="form1"  method="post" enctype="multipart/form-data" >
							    <jsp:include page="/WEB-INF/jsp/common/pagingforSubmit.jsp" />
							    
								<div>
									<!--  
									<select name ="seach_item">
									<option value= "" selected ="selected">통합검색</option>
									<option value= "brdtitle" <c:if test="${fn:indexOf(searchVO.searchType, 'brdtitle')!=-1}">selected="selected"</c:if>>제목</option>
									<option value= "brdmemo"<c:if test="${fn:indexOf(searchVO.searchType, 'brdmemo')!=-1}">selected="selected"</c:if>>내용</option>
									</select>
									-->
									
									<input type="checkbox" name="searchType" value="brdtitle" <c:if test="${fn:indexOf(searchVO.searchType, 'brdtitle')!=-1}">checked="checked"</c:if>/>
									<label class="chkselect" for="searchType1">제목</label>
									<input type="checkbox" name="searchType" value="brdmemo" <c:if test="${fn:indexOf(searchVO.searchType, 'brdmemo')!=-1}">checked="checked"</c:if>/>
									<label class="chkselect" for="">내용</label>
									<input type="text" name="searchKeyword" style="width:150px;" maxlength="50" value='<c:out value="${searchVO.searchKeyword}"/>' onkeydown="if(event.keyCode == 13) { fn_formSubmit();}">
									<input name="btn_search" value="검색" class="btn btn-success" type="button" onclick="fn_formSubmit()" />
								</div>
							</form>  
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
