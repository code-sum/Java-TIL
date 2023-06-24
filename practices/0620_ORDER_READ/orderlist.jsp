<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>주문관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
                              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;     
	var pageBlockSize = 5;    
		
	
	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fn_orderlist();
		
		// combo box 종류  cli : 거래처    조회 대상 테이블  tb_clnt   
		selectComCombo("cli","clicombo","all","","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "", "" 
				
	});
	
	
	/** 버튼 이벤트 등록 */
	
	function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
        e.preventDefault();

        var btnId = $(this).attr('id');

        switch (btnId) {
	        case 'btnSearch' :
	            fn_orderlist();
	            break;
	        case 'btnSave' :
	            fn_save();
	            break;	
	        case 'btnClose' :
	            gfCloseModal();
	            break;
	        }
	    });
	}
	
	
	function fn_orderlist(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
			searchKey : $("#searchKey").val()
		  ,	sname : $("#sname").val()
		  , pageSize : pageSize
		  , pageBlockSize : pageBlockSize
		  , pagenum : pagenum
		}
		
		var listcallback = function(returnvalue) {
			console.log(returnvalue);
			
			$("#listorder").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_orderlist');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#orderPagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
		}
		
		callAjax("/busOdm/orderlist.do", "post", "text", false, param, listcallback) ;
			
	}
	
	
	function fn_openpopup() {
		
		popupinit();
		
		// 주문 상세내역 조회 모달 팝업
		gfModalPop("#layer2");
						
	}
	
	// 주문 상세내역 조회 모달 팝업
	function popupinit(object) {
		
		// 모달(layer2) 팝업 됐을 때만, <input type="hidden" id="order_no" name="order_no" /> 에서 type 을 "hidden" 에서 "text" 로 
		// $('input[name=order_no]').prop('type', "text");
		
		$("#order_no").val(object.order_no);  // 주문번호	
        $("#order_date").val(object.order_date);  // 주문날짜
        $("#clnt_name").val(object.clnt_name);  // 주문기업명
        $("#clnt_tel").val(object.clnt_tel);  // 회사전화
        $("#clnt_email").val(object.clnt_email);  // 회사이메일
        $("#clnt_zip").val(object.clnt_zip);  // 우편번호
        $("#clnt_add").val(object.clnt_add);  // 주소
        $("#clnt_add_dt").val(object.clnt_add_dt);  // 상세주소
        $("#name").val(object.name);  // 영업담당자

	}
	
	function fn_selectone(no) {
		
		var param = {
	        order_no : no
		}
		
		var selectoncallback = function(returndata) {			
	        
	        // JSON은 로그 찍어보면 이상한 상태로 던져지고 있으니까 stringfy 작업 필수
	        console.log( returndata );
	        // 한건 조회한 데이터를 Controller 통해서 받아옴(.ordersearch)
	        
	        $("#layer2").empty().append(returndata);

	        // 모달 팝업
	        gfModalPop("#layer2");

	    }

	    callAjax("/busOdm/orderselectone.do", "post", "text", false, param, selectoncallback);		
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">영업</span> 
							<span class="btn_nav bold">주문관리</span> 
							<a href="../busOdm/orderManagement.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>주문관리</span> <span class="fr">
							 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						<!-- 검색창 영역 시작 -->
						<div style="display:flex; justify-content:center; align-content:center; line-height:2; border:1px solid DeepSkyBlue; padding:40px 40px; margin-bottom: 8px;">
							<label for="searchKey" style="font-size:15px; font-weight:bold; margin-right:10px;">주문기업명</label>
							<select id="clicombo" name="accdcombo" style="width:150px; margin-right:50px;"></select>
							 							
							<label for="start" style="font-size:15px; font-weight:bold; margin-right:10px;">주문날짜</label>
							<input type="date" id="start" name="start" min="2023-01-01" style="height:30px; width:100px; margin-right:5px;">
							<span style="margin-right:5px; line-height:3;"> ~ </span>
							<input type="date" id="end" name="end" min="2023-01-01" style="height:30px; width:100px; margin-right:50px;">
							
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
						</div>
						<!-- 검색창 영역 끝 -->
						
						<div class="noticeList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="5%">
									<col width="15%">
									<col width="20%">
									<col width="35%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">주문날짜</th>
										<th scope="col">주문기업명</th>
										<th scope="col">총주문금액</th>
										<th scope="col">영업담당자</th>
										<th scope="col">상세내역</th>
									</tr>
								</thead>
								<tbody id="listorder"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="orderPagination"> </div>
						
                     
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 신규등록 모달 영역 시작 -->
	<div id="layer1" class="layerPop layerType2" style="width: 650px;">
		<dl>
			<dt>
				<strong>주문서 작성</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="25%">
						<col width="25%">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">기업명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_name" id="splr_name" /></td>
							<th scope="row">회사 전화 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_tel" id="splr_tel" /></td>
						</tr>
						<tr>
							<th scope="row">담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_mng" id="splr_mng" /></td>
							<th scope="row">담당자 연락처 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="splr_hp" id="splr_hp" /></td>
						</tr>
						<tr>
							<th scope="row">우편번호 <span class="font_red">*</span></th>
							<td colspan="3">
								<div style="display:flex; flex-direction:row;">
									<input type="text" class="inputTxt p100" name="splr_zip" id="splr_zip" />
									<input type="button" value="우편번호 찾기"
									       onclick="execDaumPostcode()" style="margin-left:5px; width:130px; height:30px;" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">주소 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_add" id="splr_add" /></td>
						</tr>
						<tr>
							<th scope="row">상세주소 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_add_dt" id="splr_add_dt" /></td>
						</tr>
						<tr>
							<th scope="row">회사 이메일 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_email" id="splr_email" /></td>
						</tr>
						<tr>
							<th scope="row">업종 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_indst" id="splr_indst" /></td>
						</tr>
						<tr>
							<th scope="row">사업자등록번호 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="splr_indst_no" id="splr_indst_no" /></td>
						</tr>
						<tr>
							<th scope="row">계좌번호 <span class="font_red">*</span></th>
							<td colspan="3">
								<div style="display:flex; flex-direction:row;">
									<select id="bkcombo" name="bkcombo" style="margin-right:5px;"></select>
									<input type="text" class="inputTxt p100" name="splr_acc" id="splr_acc" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">메모 </th>
							<td colspan="3">
							    <textarea id="splr_memo" name="splr_memo"> </textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!-- 상세내역 모달 영역 시작 -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">

	</div>
	<!-- 상세내역 모달 영역 끝 -->
	
</form>
</body>
</html>
	