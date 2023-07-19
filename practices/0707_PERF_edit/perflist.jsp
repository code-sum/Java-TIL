<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
    // 서버 측 로직을 통해 로그인한 사용자의 사번, 유저타입 가져오기
    String currentLoginID = (String) session.getAttribute("loginId");
    String currentuserType = (String) session.getAttribute("userType");
%>
<c:set var="currentLoginID" value="<%= currentLoginID %>" />
<c:set var="currentuserType" value="<%= currentuserType %>" />


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>영업실적조회</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<!-- 대광유통 Favicon -->
<link rel="icon" type="image/png" sizes="16x16" href="${CTX_PATH}/images/admin/comm/favicon-16x16.png">
                              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;     
	var pageBlockSize = 5;    
	
	
	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fn_perflist();
		
		/* 검색창 콤보 박스  모음  */
		// 고객기업명 (조회 대상 테이블  tb_clnt)
		selectComCombo("cli","searchclicombo","all","","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "", "" 
		// 제품분류
		productCombo("l","searchltypecombo","all","","","","");  // combo type( l : 대분류   m : 중분류   s : 소분류) combo_name, type(기본값  all : 전체   sel : 선택) ,  대분류 코드, 중분류코드, 소분류 코드, ""
		// 제조사
		$('#searchltypecombo').change(function() {
			productCombo("m","searchmtypecombo","all",$("#searchltypecombo").val(),"","","");   // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , 선택된 상위 계정코드, "" 
			$("#searchptypecombo option").remove();
		});
		// 제품명
		$('#searchmtypecombo').change(function() {   
			productCombo("p","searchptypecombo","all",$("#searchltypecombo").val(),$("#searchmtypecombo").val(),"");   // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , 선택된 상위 계정코드, "" 
		});
				
	});
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
        e.preventDefault();

        var btnId = $(this).attr('id');

        switch (btnId) {
	        case 'btnSearch' :
	            fn_perflist();
	            break;
	        }
	    });
	}
	
	
	function fn_perflist(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
			searchid : $("#searchid").val()
		  , searchclicombo : $("#searchclicombo").val()
		  , searchdate : $("#searchdate").val()
		  , searchptypecombo : $("#searchptypecombo").val()
		  , pageSize : pageSize
		  , pageBlockSize : pageBlockSize
		  , pagenum : pagenum
		}
		
		var listcallback = function(returnvalue) {
			console.log(returnvalue);
			
			$("#listperf").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_perflist');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#perfPagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
			
		}
		
		callAjax("/busSas/perflist.do", "post", "text", false, param, listcallback) ;
			
	}

	

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="pageno"  name="pageno"  />

	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">영업</span> <span class="btn_nav bold">영업실적조회
								</span> <a href="../busSas/saleSearch.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>영업실적조회</span> <span class="fr"></span>
						</p>
						
						<!-- 검색창 영역 시작 -->
						<div style="display:flex; justify-content:center; align-content:center; border:solid 3px #c0c0c0; border-radius: 10px; padding:40px 40px; margin:20px auto;">
							<div style="display:flex; flex-direction:column; line-height:2; padding-right:50px;">
								<div style="display:flex; justify-content:center; align-content:center;">
									<label for="searchid" style="font-size:15px; font-weight:bold; margin-right:10px;">담당자사번</label>
									<input type="text" id="searchid" name="searchid" style="height:25px; width:100px; margin-right:30px;" 
									    <c:if test="${currentuserType=='D'}">
									    	value="${currentLoginID}"
									        disabled="disabled"
									    </c:if>
									/>
									
									<label for="searchclicombo" style="font-size:15px; font-weight:bold; margin-right:10px;">고객기업명</label>
									<select id="searchclicombo" name="searchclicombo" style="width:150px; margin-right:30px;"></select>
									 							
									<label for="searchdate" style="font-size:15px; font-weight:bold; margin-right:10px;">등록일</label>
									<input type="date" id="searchdate" name="searchdate" style="height:30px; width:100px; margin-right:5px;">
								</div>
	
								<div style="display:flex; justify-content:center; align-content:center; margin-top:10px;">
									<label for="searchltypecombo" style="font-size:15px; font-weight:bold; margin-right:10px;">제품정보</label>
									<select id="searchltypecombo" name="searchltypecombo" style="margin-right:10px;"></select>
									<select id="searchmtypecombo" name="searchmtypecombo" style="margin-right:10px;"></select>
									<select id="searchptypecombo" name="searchptypecombo"></select>
								</div>
							</div>

							<div style="display:flex; align-content: center;align-items: center;">
								<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
							</div>

						</div>
						<!-- 검색창 영역 끝 -->
						
						<div class="noticeList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="12%">
									<col width="10%">
									<col width="10%">
									<col width="24%">
									<col width="8%">
									<col width="8%">
									<col width="8%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">등록일</th>
										<th scope="col">담당자사번</th>
										<th scope="col">고객기업명</th>
										<th scope="col">제품분류</th>
										<th scope="col">제조사</th>
										<th scope="col">제품명</th>
										<th scope="col">목표수량</th>
										<th scope="col">실적수량</th>
										<th scope="col">달성률(%)</th>
									</tr>
								</thead>
								<tbody id="listperf"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="perfPagination"> </div>
						
                     
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

</form>
</body>
</html>
	