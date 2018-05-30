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
<link rel="stylesheet" href="css/custom.css" />
<link rel="stylesheet" href="css/fonts.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">

<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/common.js"></script>

<script type="text/javascript">
//게시판 검색
function fn_board_search(){
	document.formS.submit();	
}

//페이지 전송 
function fnSubmitForm(page){ 
	document.formPage.page.value=page;
	document.formPage.submit();
}
//부모창 전달함수
function fn_select(item,item2){
	window.opener.document.form1.pro_name.value = item;
	window.opener.document.form1.pro_no.value = item2;
	self.close();
}
</script>
</head>

<body>
<!-- 제품검색팝업 -->
	<div class="layer-pop">
	  <div class="layer-pop-head">
	    <h1>제품검색</h1>
	    <!-- <button type="button" class="layer-close">레이어닫기</button> -->
	  </div>
	  <div class="layer-pop-body">
	    <div class="board-search">
	       <form id="formS" name="formS"  method="post" enctype="multipart/form-data" >   
	        <fieldset>
	          <legend>게시판 검색</legend>
	            <select class="select" name="searchType" >
	               <option value= "pro_name" <c:if test="${searchVO.searchType eq 'pro_name'}">selected</c:if>>제품명</option>
	               <option value= "pro_maker" <c:if test="${searchVO.searchType eq 'pro_maker'}">selected</c:if>>제조사</option>
	            </select>      
	          <input type="text" title="검색어" class="ipt" name="searchKeyword2"  value='<c:out value="${searchVO.searchKeyword2}"/>' onkeydown="if(event.keyCode == 13) { fn_board_search();}">
	          <button type="submit" class="btn" name="btn_search" onclick="fn_board_search()" >검색</button>
	        </fieldset>
	      </form>
	    </div>
	    <!-- //board-search -->
	    <form name="c_form"> 
	    <table class="list-tb mgT2">
	      <caption>공지사항 리스트</caption>
	      <colgroup>
	        <col style="width:8%">
	        <col style="width:8%">
	        <col style="width:auto">
	        <col style="width:15%">
	        <col style="width:15%">
	        <col style="width:15%">
	        <col style="width:10%">
	      </colgroup>
	      <thead>
	        <tr>
	          <th>No</th>
	          <th>이미지</th>
	          <th>제품명</th>
	          <th>제품군</th>
	          <th>제품형태</th>
	          <th>제조사</th>
	          <th>유해도</th>
	        </tr>
	      </thead>
	      <tbody>
	      <c:choose>
			  <c:when test="${count > 0}">
				 <c:forEach var="prolist" items="${prolist}" varStatus="status">	   		
				        <tr>
				          <td><c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount2 + status.index)}"/></td>
				          <td><span class="p-photo"><img src="<c:out value="${prolist.pro_img_url}"/>" alt="사진"></span></td>
				          <td class="title"><a href="javascript:fn_select('${prolist.pro_name}','${prolist.pro_no}');"><c:out value="${prolist.pro_name}"/></a></td>
				          <td><c:out value="${prolist.pro_gubun_cd}"/></td>
				          <td><c:out value="${prolist.pro_kind_cd}"/></td>
				          <td><c:out value="${prolist.pro_maker}"/></td>
				          <td><c:out value="${prolist.pro_risk}"/></td>
				        </tr>		
				        			     																        
				</c:forEach>	
			  </c:when>     
		  	  <c:otherwise>
						<tr>
						  <td colspan="7"><div class="no-result">검색결과가 없습니다.</div></td>
					    </tr> 
		  	  </c:otherwise>	
		  </c:choose>               
	      </tbody>
	    </table>
	    </form>
	    
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
		          <input type="hidden" name="searchKeyword2"  value='<c:out value="${searchVO.searchKeyword2}"/>'>
		          <c:if test="${searchVO.searchType eq 'pro_name'}">
		          <input type="hidden" name="searchType" value="pro_name" />  
		          </c:if>
		          <c:if test="${searchVO.searchType eq 'pro_maker'}">
		          <input type="hidden" name="searchType" value="pro_maker" />  
		          </c:if>		
		      </form>   
			  <br>    	
	    <div class="board-btm list-tb-btm">
	      <button class="btn large layer-close" onClick="self.close()" >닫기</button>
	    </div>
	  </div>
	</div>
</body>
</html>