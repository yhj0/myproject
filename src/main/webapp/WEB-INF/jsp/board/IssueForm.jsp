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
	
	if (form1.brdwriter.value=="") {
		alert("작성자를 입력해주세요.");
		form1.brdwriter.focus();
		return;
	}
	if (form1.brdtitle.value=="") {
		alert("글 제목을 입력해주세요.");
		form1.brdtitle.focus();
		return;
	}
	if (form1.brdmemo.value=="") {
		alert("글 내용을 입력해주세요.");
		form1.brdmemo.focus();
		return;
	}
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
				<td align="center" height="522">
						<form name="form1" action="issueSave.do" method="post" enctype="multipart/form-data">
							<table class="table-bordered">
								<tbody>
									<tr>
										<td align="right" width="300">작성자:&nbsp;</td> 
										<td>&nbsp;<input type="text" name="brdwriter" size="20" maxlength="20" readonly="readonly" style="background-color:transparent;border:0px" value="<c:out value="${sessionScope.name}"/>"></td> 
									</tr>
									<tr>
										<td align="right">제 목:&nbsp;</td> 
										<td>&nbsp;<input type="text" name="brdtitle" size="50" maxlength="200" value="<c:out value="${boardInfo.brdtitle}"/>"></td> 
									</tr>
									<tr>
										<td align="right">내 용:&nbsp;</td> 
										<td>&nbsp;<textarea name="brdmemo" rows="10" cols="90"><c:out value="${boardInfo.brdmemo}"/></textarea></td> 
									</tr>
									<tr>
										<td align="right">첨 부:&nbsp;</td> 
										<td>
											<c:forEach var="listview" items="${listview}" varStatus="status">
												<input type="checkbox" name="fileno" value="<c:out value="${listview.fileno}"/>">	
					            				<a href="fileDownload?filename=<c:out value="${listview.filename}"/>&downname=<c:out value="${listview.realname }"/>"> 							 
												<c:out value="${listview.filename}"/></a> <c:out value="${listview.size2String()}"/><br/>
											</c:forEach>					
											<input type="file" name="uploadfile" multiple="" />
										</td> 
									</tr>
								</tbody>
							</table>    
							<a><input type="hidden" name="reg_id" value ="<c:out value="${sessionScope.id}"/>"></a>
							<input type="hidden" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
							<a class="btn btn-default btn-sm" href="#" onclick="fn_formSubmit()">저장</a>
						</form>			
				</td>
			</tr>
			<tr>
				<td align="center"><jsp:include page="include/bottom.jsp" /></td>
			</tr>
		</table>
	</div>		
</body>
</html>
