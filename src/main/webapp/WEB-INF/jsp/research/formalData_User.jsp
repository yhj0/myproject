<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>개인맞춤형 생활화학제품 사용 플랫폼</title>
  <link rel="stylesheet" href="css/fonts.css">
  <link rel="stylesheet" href="css/common.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/jquery-ui.min.css">  
  <script src="js/jquery-2.2.3.min.js"></script>  
  <script src="js/jquery-ui.min.js"></script>   
  <script src="js/common.js"></script>
  <!-- 시각화 네이버차트 -->
  
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/nhnent/tui.chart/2.4.0/dist/chart.min.css" />
<script src="https://cdn.rawgit.com/nhnent/tui.code-snippet/1.2.1/code-snippet.js"></script>
<script src="https://cdn.rawgit.com/nhnent/tui.component.effects/1.1.0/effects.min.js"></script>
<script src="https://cdn.rawgit.com/DmitryBaranovskiy/raphael/v2.2.6/raphael.min.js"></script>
<script src="https://cdn.rawgit.com/nhnent/tui.chart/2.4.0/dist/chart.min.js"></script>
<script src="https://cdn.rawgit.com/nhnent/tui.chart/2.4.0/samples/js/sample.js"></script>
    
<script type="text/javascript">
//id값 전송 함수
function fn_id_sumbit(){
	var f = document.form_id;
	f.submit();
}
//탑 검색
function fn_search(){
	document.searchform.submit();	
}

$(document).ready(function() {
	
	//시작일 달력
	$(function() {
	  $("#s-date").datepicker({
	  	  showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
	  	  buttonImage: "./images/ico_calen.png", // 버튼 이미지
	  	  buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
	  	  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
	  	  changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
	  	  minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
	  	  nextText: '다음 달', // next 아이콘의 툴팁.
	  	  prevText: '이전 달', // prev 아이콘의 툴팁.
	  	  numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
	  	  stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
	  	  yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	  	  showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
	  	  currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
	  	  closeText: '닫기',  // 닫기 버튼 패널
	  	  dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
	  	  showAnim: "slide", //애니메이션을 적용한다.
	  	  showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
	  	  dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
	  	  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
	  	 });	
	});
	
	//종료일 달력
	$(function() {
	  $("#e-date").datepicker({
	  	  showOn: "both", // 버튼과 텍스트 필드 모두 캘린더를 보여준다.
	  	  buttonImage: "./images/ico_calen.png", // 버튼 이미지
	  	  buttonImageOnly: true, // 버튼에 있는 이미지만 표시한다.
	  	  changeMonth: true, // 월을 바꿀수 있는 셀렉트 박스를 표시한다.
	  	  changeYear: true, // 년을 바꿀 수 있는 셀렉트 박스를 표시한다.
	  	  minDate: '-100y', // 현재날짜로부터 100년이전까지 년을 표시한다.
	  	  nextText: '다음 달', // next 아이콘의 툴팁.
	  	  prevText: '이전 달', // prev 아이콘의 툴팁.
	  	  numberOfMonths: [1,1], // 한번에 얼마나 많은 월을 표시할것인가. [2,3] 일 경우, 2(행) x 3(열) = 6개의 월을 표시한다.
	  	  stepMonths: 3, // next, prev 버튼을 클릭했을때 얼마나 많은 월을 이동하여 표시하는가. 
	  	  yearRange: 'c-100:c+10', // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	  	  showButtonPanel: true, // 캘린더 하단에 버튼 패널을 표시한다. 
	  	  currentText: '오늘 날짜' , // 오늘 날짜로 이동하는 버튼 패널
	  	  closeText: '닫기',  // 닫기 버튼 패널
	  	  dateFormat: "yy-mm-dd", // 텍스트 필드에 입력되는 날짜 형식.
	  	  showAnim: "slide", //애니메이션을 적용한다.
	  	  showMonthAfterYear: true , // 월, 년순의 셀렉트 박스를 년,월 순으로 바꿔준다. 
	  	  dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
	  	  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
	  	 });	
	});	
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
		         <form id="form_id2" name="form_id2"  action="myBoardList.do" method="post">
                 <input type="hidden" name="id" value="${sessionScope.id}">
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
          <h2><span>데이터 분석<br>시각화</span></h2>
          <ul class="lnb-menu">
            <li class="active has-sub"><a href="${path}/board/formalData_User.do">정형 데이터 분석</a>
              <ul class="sub">
                <li class="active"><a href="${path}/board/formalData_User.do">사용자 커뮤니티</a></li>
                <li><a href="${path}/board/formalData_Pattern.do">이용패턴 별 사용자 분류</a></li>
                <li><a href="${path}/board/formalData_Product.do">종별 제품별 사용 통계</a></li>
              </ul>
            </li>
            <li class="has-sub"><a href="${path}/board/informalData_User.do">비정형 데이터 분석</a>
              <ul class="sub">
                <li><a href="${path}/board/informalData_User.do">이용 트렌드 분석</a></li>
                <li><a href="${path}/board/informalData_Review.do">리뷰 데이터 감성 분석</a></li>
              </ul>
            </li>
          </ul>
        </div>
        <!-- //lnb -->
        <div class="contents">
          <div class="sub-title">
            <h3>사용자 커뮤니티</h3>
            <div class="path"><span class="loc">HOME</span><span class="loc">데이터 분석 시각화</span><span class="loc">정형 데이터 분석</span><em class="loc">사용자 커뮤니티</em></div>
          </div>
          <!-- //sub-title -->

          <h4 class="hTy4 alone">분석조건</h4>
          <div class="sel-tb-bx">
            <table class="sel-tb">
              <colgroup>
                <col style="width:150px">
                <col style="width:auto">
                <col style="width:200px">
              </colgroup>
              <tbody>
              <tr>
                <th>대상 생활화학 제품</th>
                <td>
                  <span class="sel-cell">
                    <label for="s-date">시작일</label>
                    <input type="text" id="s-date" name="s-date" class="ipt">
                  </span>
                  <span class="sel-cell">
                    <label for="e-date">종료일</label>
                    <input type="text" id="e-date" name="e-date" class="ipt">
                  </span>
                </td>
                <td><button type="button" class="btn medium">분석시작</button></td>
              </tr>              
              <tr>
                <th>분석 기간</th>
                <td colspan="2">
                  <span class="sel-cell cell3"><label for="u-gender">성별</label>
                    <select class="select" id="u-gender">
                      <option>남성</option>
                      <option>여성</option>
                    </select>
                  </span>
                  <span class="sel-cell cell3"><label for="u-age">연령</label>
                    <select class="select" id="u-age">
                      <option>20대</option>
                      <option>30대</option>
                      <option>40대</option>
                      <option>50대</option>
                      <option>60대이상</option>
                    </select>
                  </span>
                  <span class="sel-cell cell3"><label for="u-local">지역</label>
                    <select class="select" id="u-local">
                      <option>서울</option>
                      <option>경기</option>
                      <option>인천</option>
                      <option>강원</option>
                      <option>충남</option>
                      <option>대전</option>
                      <option>충북</option>  
                      <option>부산</option> 
                      <option>울산</option> 
                      <option>대구</option>      
                      <option>경북</option>  
                      <option>경남</option>  
                      <option>전남</option> 
                      <option>광주</option>
                      <option>전북</option> 
                      <option>제주</option>                                                                                                                                                                                                                                                                                                                
                    </select>
                  </span>
                </td>
              </tr>
            </tbody>
            </table>
          </div>
          <div id="chart-area">
          	시각화 영역
          </div>      
          <div id="chart-area2">
          	시각화 영역
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


<script>
var container = document.getElementById('chart-area');
var data = {
    series: [
        {
            name: 'Africa',
            data: [
                { x: 4200, y: 70.35, r: 32209101, label: 'Morocco' },
                { x: 4200, y: 70.71, r: 76117421, label: 'Egypt' },
                { x: 5900, y: 56.46, r: 1355246, label: 'Gabon' },
                { x: 6600, y: 72.74, r: 32129324, label: 'Algeria' },
                { x: 6700, y: 76.28, r: 5631585, label: 'Libya' },
                { x: 7100, y: 74.66, r: 9974722, label: 'Tunisia' },
                { x: 10500, y: 69.28, r: 1096585, label: 'Trinidad and Tobago' },
                { x: 12800, y: 72.09, r: 1220481, label: 'Mauritius' },
                { x: 18200, y: 78.68, r: 396851, label: 'Malta' }
            ]
        },
        {
            name: 'America',
            data: [
                { x: 4800, y: 74.64, r: 6191368, label: 'Paraguay' },
                { x: 4900, y: 70.92, r: 6587541, label: 'El Salvador' },
                { x: 5600, y: 69.22, r: 2754430, label: 'Peru' },
                { x: 5800, y: 74.06, r: 2501738, label: 'Venezuela' },
                { x: 6300, y: 67.63, r: 8833634, label: 'Dominican Republic' },
                { x: 6500, y: 67.43, r: 272945, label: 'Belize' },
                { x: 6600, y: 71.43, r: 4231077, label: 'Colombia' },
                { x: 6900, y: 72.14, r: 3000463, label: 'Panama' },
                { x: 8100, y: 71.41, r: 78410118, label: 'Brazil' },
                { x: 9600, y: 76.63, r: 3956507, label: 'Costa Rica' },
                { x: 9600, y: 74.94, r: 4495959, label: 'Mexico' },
                { x: 12400, y: 75.7, r: 6914475, label: 'Argentina' },
                { x: 14500, y: 75.92, r: 3399237, label: 'Uruguay' },
                { x: 16400, y: 71.64, r: 278289, label: 'Barbados' },
                { x: 17700, y: 65.63, r: 299697, label: 'Bahamas, The' },
                { x: 17700, y: 77.49, r: 3897960, label: 'Puerto Rico' },
                { x: 31500, y: 79.96, r: 32507874, label: 'Canada' },
                { x: 32100, y: 77.43, r: 89302754, label: 'United States' }
            ]
        },
        {
            name: 'Asia',
            data: [
                { x: 5600, y: 71.96, r: 92988000, label: 'China' },
                { x: 5700, y: 61.29, r: 4863169, label: 'Turkmenistan' },
                { x: 7700, y: 69.66, r: 19018924, label: 'Iran' },
                { x: 7800, y: 66.07, r: 1514370, label: 'Kazakhstan' },
                { x: 8100, y: 71.41, r: 14865523, label: 'Thailand' },
                { x: 9700, y: 71.95, r: 23522482, label: 'Malaysia' },
                { x: 12000, y: 75.23, r: 25795938, label: 'Saudi Arabia' },
                { x: 13100, y: 72.85, r: 2903165, label: 'Oman' },
                { x: 19200, y: 75.58, r: 48598170, label: 'Korea, South' },
                { x: 19200, y: 73.98, r: 677886, label: 'Bahrain' },
                { x: 20800, y: 79.17, r: 6199008, label: 'Israel' },
                { x: 21300, y: 76.84, r: 2257549, label: 'Kuwait' },
                { x: 23200, y: 73.4, r: 840290, label: 'Qatar' },
                { x: 25200, y: 74.99, r: 2523915, label: 'United Arab Emirates' },
                { x: 25300, y: 77.06, r: 22749838, label: 'Taiwan' },
                { x: 27800, y: 81.53, r: 4353893, label: 'Singapore' },
                { x: 29400, y: 81.04, r: 52733300, label: 'Japan' },
                { x: 34200, y: 81.39, r: 6855125, label: 'Hong Kong' }
            ]
        },
        {
            name: 'Europe',
            data: [
                { x: 7700, y: 71.12, r: 2235555, label: 'Romania' },
                { x: 8200, y: 71.75, r: 7517973, label: 'Bulgaria' },
                { x: 9800, y: 66.39, r: 54378233, label: 'Russia' },
                { x: 10700, y: 76.38, r: 1582395, label: 'Chile' },
                { x: 11200, y: 74.14, r: 4496869, label: 'Croatia' },
                { x: 11500, y: 70.86, r: 2306306, label: 'Latvia' },
                { x: 12000, y: 74.16, r: 38626349, label: 'Poland' },
                { x: 12500, y: 73.46, r: 3607899, label: 'Lithuania' },
                { x: 14300, y: 71.38, r: 1341664, label: 'Estonia' },
                { x: 14500, y: 74.19, r: 5423567, label: 'Slovakia' },
                { x: 14900, y: 72.25, r: 1003237, label: 'Hungary' },
                { x: 16800, y: 75.78, r: 1024617, label: 'Czech Republic' },
                { x: 17900, y: 77.35, r: 1052414, label: 'Portugal' },
                { x: 19600, y: 75.93, r: 2011473, label: 'Slovenia' },
                { x: 21300, y: 78.94, r: 10647529, label: 'Greece' },
                { x: 23300, y: 79.37, r: 40280780, label: 'Spain' },
                { x: 27700, y: 79.54, r: 58057477, label: 'Italy' },
                { x: 28400, y: 80.3, r: 898640, label: 'Sweden' },
                { x: 28700, y: 78.54, r: 22424609, label: 'Germany' },
                { x: 28700, y: 79.44, r: 30424213, label: 'France' },
                { x: 29000, y: 78.24, r: 5214512, label: 'Finland' },
                { x: 29500, y: 78.68, r: 16318199, label: 'Netherlands' },
                { x: 29600, y: 78.27, r: 60270708, label: 'United Kingdom' },
                { x: 30600, y: 78.44, r: 10348276, label: 'Belgium' },
                { x: 31300, y: 78.87, r: 8174762, label: 'Austria' },
                { x: 31900, y: 77.36, r: 3969558, label: 'Ireland' },
                { x: 31900, y: 80.18, r: 293966, label: 'Iceland' },
                { x: 32200, y: 77.44, r: 5413392, label: 'Denmark' },
                { x: 33800, y: 80.31, r: 7450867, label: 'Switzerland' }
            ]
        },
        {
            name: 'Oceania',
            data: [
                { x: 2200, y: 64.56, r: 5420280, label: 'Papua New Guinea' },
                { x: 2700, y: 61.32, r: 100798, label: 'Kiribati' },
                { x: 5900, y: 69.2, r: 880874, label: 'Fiji' },
                { x: 14500, y: 78.75, r: 108775, label: 'Virgin Islands' },
                { x: 23200, y: 78.49, r: 1993817, label: 'New Zealand' },
                { x: 30700, y: 80.26, r: 5991314, label: 'Australia' }
            ]
        }
    ]
};
var options = {
    chart: {
        width: 1160,
        height: 540,
        title: 'Life Expectancy per GDP',
        format: function (value, chartType, areaType, valueType) {
            if (valueType === 'r' || valueType === 'x') {
                value = tui.chart.renderUtil.formatToComma(value);
                if (valueType === 'x') {
                    value = '$' + value;
                }
            }
            return value;
        }
    },
    yAxis: {
        title: 'Life Expectancy (years)'
    },
    xAxis: {
        title: 'GDP'
    },
    tooltip: {
        template: function (category, items) {
            return '<div class="tui-chart-default-tooltip">' +
                '<div class="tui-chart-tooltip-head">' +
                    '<span class="tui-chart-legend-rect" style="' + items.cssText + '; width: 10px; height: 10px"></span>' +
                    '<span>' + items.legend + '</span>' +
                    '<span>' + items.label + '</span>' +
                '</div>' +
                '<table class="tui-chart-tooltip-body">' +
                '<tr>' +
                    '<td>GDP</td>' +
                    '<td class="tui-chart-tooltip-value">' + items.x + '</td>' +
                '</tr>' +
                '<tr>' +
                    '<td>Life Expectancy</td>' +
                    '<td class="tui-chart-tooltip-value">' + items.y + '</td>' +
                '</tr>' +
                '<tr>' +
                    '<td>Population</td>' +
                    '<td class="tui-chart-tooltip-value">' + items.r + '</td>' +
                '</tr>' +
                '</table>';
            '</div>';
        }
    }
};
var theme = {
	    series: {
	        colors: [
	            '#83b14e', '#458a3f', '#295ba0', '#2a4175', '#289399',
	            '#289399', '#617178', '#8a9a9a', '#516f7d', '#dddddd'
	        ]
	    }
	};

tui.chart.bubbleChart(container, data, options);

var container = document.getElementById('chart-area2');
var data = {
    categories: ['May', 'June', 'July', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    series: [
        {
            name: 'Budget',
            data: [4000, 5000, 3000, 5000, 7000, 6000, 4000, 1000]
        },
        {
            name: 'Income',
            data: [7000, 8000, 1000, 7000, 2000, 7000, 3000, 5000]
        },
        {
            name: 'Expenses',
            data: [-5000, -4000, -4000, -6000, -3000, -4000, -5000, -7000]
        },
        {
            name: 'Debt',
            data: [-3000, -6000, -3000, -3000, -1000, -2000, -4000, -3000]
        }
    ]
};
var options = {
    chart: {
        width: 1160,
        height: 540,
        title: 'Monthly Revenue',
        format: '1,000'
    },
    yAxis: {
        title: 'Amount'
    },
    xAxis: {
        title: 'Month'
    },
    series: {
        stackType: 'percent',
        barWidth: 60
    },
    tooltip: {
        grouped: true
    },
    legend: {
        align: 'bottom4000'
    }
};
var theme = {
    series: {
        colors: [
            '#83b14e', '#458a3f', '#295ba0', '#2a4175', '#289399',
            '#289399', '#617178', '#8a9a9a', '#516f7d', '#dddddd'
        ]
    }
};

// For apply theme

// tui.chart.registerTheme('myTheme', theme);
// options.theme = 'myTheme';

tui.chart.columnChart(container, data, options);


</script>
</body>
</html>