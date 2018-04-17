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
////////////////////////////////////다음 에디터 관련 로직 //////////////////////////////
// 1.첫 로드시 다음에디터 부르기 
$(function(){
    $.ajax({
        url : "daumEditor.do",      
        success : function(data){
            $("#editor_frame").html(data);
        }
    });
    loadContent();

// 2.본문 내용 불러오기
    function loadContent() {
    Editor.modify({
    	"content": document.getElementById("brdmemo") /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
    	});
    }    
    
// 3.저장 버튼 클릭시 이벤트
    $("#save_button").click(function(){
        //다음에디터가 포함된 form submit
    	Editor.save(); 
    })
})
// 4.저장전 유효성 체크
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
// 5.컨트롤러로 가기전 포멧지정
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
							<table class="table table-bordered">
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
										<td><div id="editor_frame"></div>
        									<!-- 실제 값이 담겨져서 넘어갈 textarea 태그 -->
       										<textarea name="brdmemo" id="brdmemo" rows="10" cols="100" style="width:600px; height:412px;display: none;"><c:out value="${boardInfo.brdmemo}"/></textarea></td>
										<!--  <td>&nbsp;<textarea name="brdmemo" rows="10" cols="90"><c:out value="${boardInfo.brdmemo}"/></textarea></td>  -->
									</tr>
									<tr>
										<td align="right">파일첨부:&nbsp;</td> 
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
							<input type="hidden" name="reg_id" value ="<c:out value="${sessionScope.id}"/>">
							<input type="hidden" name="brdno" value="<c:out value="${boardInfo.brdno}"/>"> 
							<a class="btn btn-default btn-sm" href="#" id="save_button">저장</a>
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
