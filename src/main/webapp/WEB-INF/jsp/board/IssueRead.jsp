<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 배경이미지css -->
<link rel="stylesheet" href="css/custom.css" />
<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/bootstrap.js"></script>

<title>board</title>

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
	<div class="col-lg-2 col-lg-offset-2">
		<table class="table-bordered">
			<tr>
				<td align="right"><jsp:include page="include/top.jsp" /></td>
			</tr>
			<tr>
				<td align="right"><jsp:include page="include/menu.jsp" /></td>
			</tr>
			<tr>
				<td height="522">
					<div class="container">
					<div class="col-md-8 col-md-offset-2">
					<div class="well">			
							<table class="table table-striped" >
								<tbody>
									<tr>
										<td>작성자</td> 
										<td><c:out value="${boardInfo.brdwriter}"/></td> 
									</tr>
									<tr>
										<td>제목</td> 
										<td><c:out value="${boardInfo.brdtitle}"/></td>  
									</tr>
									<tr>
										<td>내용</td> 
										<td><textarea rows="10" cols="90" readonly><c:out value="${boardInfo.brdmemo}" escapeXml="false"/></textarea></td> 
									</tr>
									<tr>
										<td>첨부파일</td> 
										<td>
											<c:forEach var="listview" items="${listview}" varStatus="status">	
					            				<a href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
												<c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
											</c:forEach>					
										</td> 
									</tr>
								</tbody>
							</table>    
							<a><input type="hidden" value ="<c:out value="${sessionScope.id}"/>"></a>
							<a class="btn btn-default btn-sm" href="issueList.do">돌아가기</a>
							<!-- 수정권한 본인id 혹은 관리자-->
							<c:choose>
							    <c:when test="${sessionScope.id == boardInfo.reg_id || sessionScope.id == 'admin'}">
							    	<a class="btn btn-default btn-sm" href="issueDelete.do?brdno=<c:out value="${boardInfo.brdno}"/>">삭제</a>
									<a class="btn btn-default btn-sm" href="issueForm.do?brdno=<c:out value="${boardInfo.brdno}"/>">수정</a>
							    </c:when>
							    <c:otherwise>
							    	<br>
							    </c:otherwise>
							</c:choose>		
							<p>&nbsp;</p>
							</div>
							 댓글부분 
							<div style="border: 1px solid; width: 600px; padding: 5px">
								<form name="form1" action="boardReplySave.do" method="post">
									<input type="hidden" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
									작성자: <input type="text"  name="rewriter" size="20" maxlength="20" readonly="readonly" style="background-color:transparent;border:0px "  value="<c:out value="${sessionScope.name}"/>"> <br/>
									<textarea name="rememo" rows="3" cols="60" maxlength="500" placeholder="댓글을 달아주세요."></textarea>
									<a class="btn btn-xs" href="#" onclick="fn_formSubmit()">저장</a>
									<a><input type="hidden" name="reg_id" value ="<c:out value="${sessionScope.id}"/>"></a>
								</form>
							</div>
							<c:forEach var="replylist" items="${replylist}" varStatus="status">
								<div >	
									<c:out value="${replylist.rewriter}"/> <c:out value="${replylist.redate}"/>
									<c:choose>
									    <c:when test="${sessionScope.id == replylist.reg_id || sessionScope.id == 'admin'}">
											<a class="btn btn-xs" href="#" onclick="fn_replyDelete('<c:out value="${replylist.reno}"/>')">삭제</a>
											<a class="btn btn-xs" href="#" onclick="fn_replyUpdate('<c:out value="${replylist.reno}"/>')">수정</a>
									    </c:when>
									    <c:otherwise>
									    </c:otherwise>
									</c:choose>					
									<br/>
									<div id="reply<c:out value="${replylist.reno}"/>"><c:out value="${replylist.rememo}"/></div>
								</div>
							</c:forEach>
							
							<div id="replyDiv" style="width: 99%; display:none">
								<form name="form2" action="boardReplySave.do" method="post">
									<input type="hidden" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
									<input type="hidden" name="reno"> 
									<textarea name="rememo" rows="3" cols="60" maxlength="500"></textarea>
									<a href="#" onclick="fn_replyUpdateSave()">저장</a>
									<a href="#" onclick="fn_replyUpdateCancel()">취소</a>
									<a><input type="hidden" name="reg_id" value ="<c:out value="${sessionScope.id}"/>"></a>
								</form>
							</div>		
						</div>
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
