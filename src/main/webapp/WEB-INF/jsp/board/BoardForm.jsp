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
<!-- 다음에디터 링크 -->
<link rel=stylesheet type=text/css href="daumeditor/css/editor.css" charset=utf-8 />
<script type=text/javascript charset=utf-8 src="daumeditor/js/editor_loader.js"></script>


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
	
	Editor.save();
	
	document.form1.submit();	
} 

function validForm(editor) {
	// Place your validation logic here

	// sample : validate that content exists
	var validator = new Trex.Validator();
	var content = editor.getContent();
	if (!validator.exists(content)) {
		alert('내용을 입력하세요');
		return false;
	}

	return true;
}

/**
 * Editor.save()를 호출한 경우 validForm callback 이 수행된 이후
 * 실제 form submit을 위해 form 필드를 생성, 변경하기 위해 부르는 콜백함수로
 * 각자 상황에 맞게 적절히 응용하여 사용한다.
 * @function
 * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
 * @returns {Boolean} 정상적인 경우에 true
 */
function setForm(editor) {
    var i, input;
    var form = editor.getForm();
    var content = editor.getContent();

    // 본문 내용을 필드를 생성하여 값을 할당하는 부분
    var textarea = document.createElement('textarea');
    textarea.name = 'content';
    textarea.value = content;
    form.createField(textarea);

    /* 아래의 코드는 첨부된 데이터를 필드를 생성하여 값을 할당하는 부분으로 상황에 맞게 수정하여 사용한다.
     첨부된 데이터 중에 주어진 종류(image,file..)에 해당하는 것만 배열로 넘겨준다. */
    var images = editor.getAttachments('image');
    for (i = 0; i < images.length; i++) {
        // existStage는 현재 본문에 존재하는지 여부
        if (images[i].existStage) {
            // data는 팝업에서 execAttach 등을 통해 넘긴 데이터
            alert('attachment information - image[' + i + '] \r\n' + JSON.stringify(images[i].data));
            input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'attach_image';
            input.value = images[i].data.imageurl;  // 예에서는 이미지경로만 받아서 사용
            form.createField(input);
        }
    }

    /*
    var files = editor.getAttachments('file');
    for (i = 0; i < files.length; i++) {
        input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'attach_file';
        input.value = files[i].data.attachurl;
        form.createField(input);
    }
    */
    return true;
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
						<form name="form1" action="boardSave.do" method="post" enctype="multipart/form-data">
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
										<td><jsp:include page="/WEB-INF/jsp/daumeditor/editor_frame.jsp"></jsp:include></td>
										<!--  <td>&nbsp;<textarea name="brdmemo" rows="10" cols="90"><c:out value="${boardInfo.brdmemo}"/></textarea></td>  -->
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
