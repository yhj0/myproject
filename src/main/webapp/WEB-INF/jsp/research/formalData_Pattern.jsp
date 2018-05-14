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
  <script src="js/jquery-2.2.3.min.js"></script>  
  <script src="js/common.js"></script>
<!-- 시각화관련 --> 
<script src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script src="https://www.amcharts.com/lib/3/serial.js"></script>
<script src="https://www.amcharts.com/lib/3/plugins/export/export.min.js"></script>
<link rel="stylesheet" href="https://www.amcharts.com/lib/3/plugins/export/export.css" type="text/css" media="all" />
<script src="https://www.amcharts.com/lib/3/themes/light.js"></script>  
<script src="https://www.amcharts.com/lib/3/xy.js"></script>

  
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
</script>   
<!-- 시각화 관련 -->
<script>
var chart = AmCharts.makeChart("chartdiv", {
		"type": "serial",
	    "theme": "light",
		"categoryField": "product",
		"rotate": true,
		"startDuration": 1,
		"categoryAxis": {
			"gridPosition": "start",
			"position": "left"
		},
		"trendLines": [],
		"graphs": [
			{
				"balloonText": "이용량:[[value]]",
				"fillAlphas": 0.8,
				"id": "AmGraph-2",
				"lineAlpha": 0.2,
				"title": "Usage",
				"type": "column",
				"valueField": "Usage",
			}
		],
		"guides": [
		   {
		   }        
		           ],
		"valueAxes": [
			{
				"id": "ValueAxis-1",
				"position": "top",
				"axisAlpha": 0
			}
		],
		"allLabels": [],
		"balloon": {},
		"titles": [
		   		{
					"text": "일일 평균 이용량에 따른 이용제품 순위",
					"size": 15
				}		           
		           ],
		"dataProvider": [
		    {
		    	"product": '세탁비누/무궁화',
		    	"Usage": 0.990224
		    },			                 
		                 
		    {
		    	"product": 'Downy(다우니)/P&G(피앤지)',
		    	"Usage": 0.876332
		    },		                 
			{
				"product": '한입 베이킹소다/LG생활건강',
				"Usage": 0.824104
			},
			{
				"product": '울터치/피죤',
				"Usage": 0.539142
			},
			{
				"product": '비트 O2크린/씨제이라이온',
				"Usage": 0.371758
			},
			{
				"product": 'Act`z(액츠)/피죤',
				"Usage": 0.200565
			},
			{
				"product": '비트/씨제이라이온',
				"Usage": 0.066952
			}
		],
	    "export": {
	    	"enabled": true
	     }
});

var chart = AmCharts.makeChart("chartdiv2", {
	"type": "serial",
    "theme": "light",
	"categoryField": "product",
	"rotate": true,
	"startDuration": 1,
	"categoryAxis": {
		"gridPosition": "start",
		"position": "left"
	},
	"trendLines": [],
	"graphs": [
		{
			"balloonText": "노출량:[[value]]",
			"fillAlphas": 0.8,
			"id": "AmGraph-1",
			"lineAlpha": 0.2,
			"title": "exposure",
			"type": "column",
			"valueField": "exposure"
		},
	],
	"guides": [
	   {   
	   }        
	           ],
	"valueAxes": [
		{
			"id": "ValueAxis-1",
			"position": "top",
			"axisAlpha": 0
		}
	],
	"allLabels": [],
	"balloon": {},
	"titles": [
	   		{
				"text": "일일 평균 노출량에 따른 이용제품 순위",
				"size": 15
			}		           
	           ],
	"dataProvider": [
	    {
	    	"product": '세탁비누/무궁화',
	    	"exposure": 0.060143,
	    },			                 
	                 
	    {
	    	"product": 'Downy(다우니)/P&G(피앤지)',
	    	"exposure": 0.033778,
	    },		                 
		{
			"product": '한입 베이킹소다/LG생활건강',
			"exposure": 0.031606,
		},
		{
			"product": '울터치/피죤',
			"exposure": 0.032566,
		},
		{
			"product": 'Act`z(액츠)/피죤',
			"exposure": 0.02521,
		},		
		{
			"product": '비트 O2크린/씨제이라이온',
			"exposure": 0.014207,
		},
		{
			"product": '비트/씨제이라이온',
			"exposure": 0.00584,
		}
	],
    "export": {
    	"enabled": true
     }
});

var chart = AmCharts.makeChart( "chartdiv3", {
	  "type": "xy",
	  "theme": "light",
	  "balloon":{
	   "fixedPosition":true,
	  },
	  "titles": [
			   		{
						"text": "일일 평균 이용량과 일일 평균 노출량 따른 버블차트",
						"size": 15
					}		           
			 	 ],	  
	  "dataProvider": [ {
		"x": 7,		  
	    "y": 0.200565,
	    "value":0.02521,     
	    "product": 'Act`z(액츠)/피죤',
	    
	  }, {
		"x": 5,  
	    "y": 0.066952,
	    "value":0.00584,
	    "product": '비트/씨제이라이온',
	  }, {
		"x": 5,  
	    "y": 0.876332,
	    "value":0.033778,
	    "product": 'Downy(다우니)/P&G(피앤지)',
	  }, {
		"x": 5,  
	    "y": 0.990224,
	    "value":0.060143,
	    "product": '세탁비누/무궁화',
	  }, {
		"x": 4,  
	    "y": 0.539142,
	    "value":0.032566,
	    "product": '울터치/피죤',
	  }, {
		"x": 4,  
	    "y": 0.371758,
	    "value": 0.014207,
	    "product": '비트 O2크린/씨제이라이온',
	  }, {
		"x": 5,
	    "y": 0.824104,
	    "value": 0.031606,
	    "product": '한입 베이킹소다/LG생활건강',
	  } ],
	  "valueAxes": [ {
	    "position": "bottom",
	    "axisAlpha": 0,
	    "title": "이용빈도",
	  }, {
	    "minMaxMultiplier": 1.05,
	    "axisAlpha": 0,
	    "position": "left",
	    "title": "이용량",
	  } ],
	  "startDuration": 1.5,
	  "graphs": [ {
	    "balloonText": "제품:<b>[[product]]</b>",
	    "bullet": "circle",
	    "bulletBorderAlpha": 0.2,
	    "bulletAlpha": 0.8,
	    "lineAlpha": 0,
	    "fillAlphas": 0,
	    "valueField": "value",
	    "xField": "x",
	    "yField": "y",
	    "maxBulletSize": 100,
	    "labelText": "[[product]]",
	  }, ],
	  "marginLeft": 46,
	  "marginBottom": 35,
	  "export": {
	    "enabled": true
	  }
	} );

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
                <li><a href="${path}/board/formalData_User.do">사용자 커뮤니티</a></li>
                <li class="active"><a href="${path}/board/formalData_Pattern.do">이용패턴 별 사용자 분류</a></li>
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
            <h3>이용패턴 별 사용자 분류</h3>
            <div class="path"><span class="loc">HOME</span><span class="loc">데이터 분석 시각화</span><span class="loc">정형 데이터 분석</span><em class="loc">이용패턴 별 사용자 분류</em></div>
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
                <th>분석 기간</th>
                <td colspan="2">
                  <span class="sel-cell">
                    <label for="s-date">시작일</label>
                    <input type="text" id="s-date" class="ipt"><button type="button"><img src="./images/ico_calen.png" alt="달력"></button>
                  </span>
                  <span class="sel-cell">
                    <label for="e-date">종료일</label>
                    <input type="text" id="e-date" class="ipt"><button type="button"><img src="./images/ico_calen.png" alt="달력"></button>
                  </span>
                </td>
                 <td><button type="button" class="btn medium">분석시작</button></td>
              </tr>
              <!-- 
              <tr>
                <th>대상 생활화학 제품</th>
                <td>
                  <span class="sel-cell"><label for="prod1">제품군</label>
                    <select class="select" id="prod1">
                      <option>세정제</option>
                    </select>
                  </span>
                  <span class="sel-cell"><label for="prod2">제품명</label>
                    <select class="select" id="prod2">
                      <option>매직팍 락스세제</option>
                    </select>
                  </span>
                </td>
              </tr>
             --> 
            </tbody>
            </table>
          </div>
          <div class="result" id="chartdiv">
            시각화 영역
          </div>
          <div class="result" id="chartdiv2">
            시각화 영역
          </div>
          <div class="result" id="chartdiv3">
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
</body>
</html>
