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
		
		fn_orderlist();
		
		// 검색창 콤보 박스  (조회 대상 테이블  tb_clnt)
		selectComCombo("cli","searchclicombo","all","","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "", "" 
		
		/*  모달 내부 콤보박스 모음   */
		selectComCombo("cli","clicombo","all","","");  // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , "", "" 
		// 제품분류
		productCombo("l","ltypecombo","all","","","","");  // combo type( l : 대분류   m : 중분류   s : 소분류) combo_name, type(기본값  all : 전체   sel : 선택) ,  대분류 코드, 중분류코드, 소분류 코드, ""
		// 제조사
		$('#ltypecombo').change(function() {
			productCombo("m","mtypecombo","all",$("#ltypecombo").val(),"","","");   // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , 선택된 상위 계정코드, "" 
			$("#ptypecombo option").remove();
		});
		// 제품명
		$('#mtypecombo').change(function() {   
			productCombo("p","ptypecombo","all",$("#ltypecombo").val(),$("#mtypecombo").val(),"");   // combo type(combo box 종류),  combo_name, type(기본값  all : 전체   sel : 선택) , 선택된 상위 계정코드, "" 
		});
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
	        case 'btnAdd' : 
	        	fn_add();
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
		    start : $("#searchstart").val()
		  , end : $("#searchend").val()
		  ,	clicombo : $("#searchclicombo").val()
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
		
		// 주문서 신규작성 모달 팝업
	    gfModalPop("#layer1");				
	}
	
	
	// 초기화
	function popupinit() {
        $("#ltypecombo").val("");
        $("#mtypecombo").val("");
        $("#ptypecombo").val("");
        $("#order_dt_amt").val("");
        $("#clicombo").val("");
        $("#order_date").val("");
        $("#order_req").val("");
	}
	
	
	//fn_add()에서 활용할 전역변수
	var totalOrderPrice = 0;
	
	//fn_add(), fn_save()에서 활용할 전역변수
	var orderItems = "";
	
	function fn_add() {
		// tb_product 테이블 조회해서 제품명(product_name),
		// 제품가격(product_price) 받아와야 하므로, 
		// [추가] 버튼 누르는 즉시 순간적으로 컨트롤러에 param 보내기
		var param = {
			ptypecombo	: $("#ptypecombo").val()
		};
		
		var order_tot_price = $("#order_tot_price").val();
		
		var addcallback = function(returndata) {
	        var parsedData = JSON.parse(returndata);
	        var orderadd = parsedData.orderadd;
	        var product_no = orderadd.product_no;
	        var product_name = orderadd.product_name;
	        var product_price = orderadd.product_price;
	        var order_dt_amt = $("#order_dt_amt").val();
	        var order_dt_price = product_price * order_dt_amt;
	        totalOrderPrice += order_dt_price;

	        var html = "<tr>";
	        html += "<td>" + product_no + "</td>";
	        html += "<td>" + product_name + "</td>";
	        html += "<td>" + product_price + "</td>";
	        html += "<td>" + order_dt_amt + "</td>";
	        html += "<td>" + order_dt_price + "</td>";
	        html += "</tr>";
	        $("#bucket").append(html);
	        $("#order_tot_price").text(totalOrderPrice);
	        
		    // 주문 상세 정보를 자식 테이블에 저장하기 위해 item 에 담아놓기
		     var item = $("#order_no").val() + "," + product_no + "," + $("#clicombo").val() + "," + product_price + "," + order_dt_amt + "," + order_dt_price + "/";
	         console.log("item : " + item);
		     
		     orderItems += item
	    };
	    callAjax("/busOdm/orderadd.do", "post", "text", false, param, addcallback);
        console.log(orderItems);
	}
	
	
	function fn_save() {
		
		// 비어있는 값으로 저장되지 않도록 유효성 검사
	    if ( ! fn_Validate() ) {
	        return;
	    }
		
		// tb_order(부모테이블) 에 데이터 먼저 넣고,
		// tb_order_dt(자식테이블) 에 데이터 넣는 순서
		
		var order_tot_price = totalOrderPrice;

		var param = {
	        clnt_no : $("#clicombo").val(),
	        order_tot_price : totalOrderPrice,
	        order_date : $("#order_date").val(),
	        order_req : $("#order_req").val(),
	        orderItems : orderItems
	    };

		var savecallback = function(reval) {
			console.log(JSON.stringify(reval));
			if(reval.returncval > 0) {
				alert("반영 되었습니다.");
				gfCloseModal();
				fn_orderlist();
			} else {
			  alert("오류가 발생 되었습니다.");				
			}
		};

		callAjax("/busOdm/ordersave.do", "post", "json", false, param, savecallback);
	    
	}
	
	
	function fn_Validate() {
		var chk = checkNotEmpty(
				[
						[ "ltypecombo", "제품분류를 선택해 주세요." ]
					,	[ "mtypecombo", "제조사를 선택해 주세요." ]
					,	[ "ptypecombo", "제품명을 선택해 주세요." ]
					,	[ "order_dt_amt", "주문수량을 입력해 주세요." ]
					,	[ "clicombo", "주문기업명을 선택해 주세요." ]
					,	[ "order_date", "주문날짜를 입력해 주세요." ]
				]
		);
		if (!chk) {
			return;
		}
		
		if (orderItems === "") {
			alert("[추가] 버튼을 클릭하여 주문할 제품 목록을 확정해 주세요.");
			return;
		}
		
		return true;
	}
	
	
	function fn_selectone(no) {
		
		var param = {
	        order_no : no
		}
		
		var selectoncallback = function(returndata) {			
	        console.log( returndata );
	        $("#layer2").empty().append(returndata);

	        // 주문 한건조회 모달 팝업
	        gfModalPop("#layer2");
	    }
	    callAjax("/busOdm/orderselectone.do", "post", "text", false, param, selectoncallback);		
	}
	

	

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="order_no"  name="order_no"  />
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
						<div style="display:flex; justify-content:center; align-content:center; line-height:2; border:solid 3px #c0c0c0; border-radius: 10px; padding:40px 40px; margin:20px auto;">
							<label for="searchKey" style="font-size:15px; font-weight:bold; margin-right:10px;">주문기업명</label>
							<select id="searchclicombo" name="searchclicombo" style="width:150px; margin-right:50px;"></select>
							 							
							<label for="start" style="font-size:15px; font-weight:bold; margin-right:10px;">주문날짜</label>
							<input type="date" id="searchstart" name="searchstart" style="height:30px; width:100px; margin-right:5px;">
							<span style="margin-right:5px; line-height:3;"> ~ </span>
							<input type="date" id="searchend" name="searchend" style="height:30px; width:100px; margin-right:50px;">
							
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

	<!-- 주문서 신규등록 모달 영역 시작 -->
	<div id="layer1" class="layerPop layerType2" style="width:800px;">
		<dl>
			<dt>
				<strong>주문서 작성</strong>
			</dt>
			<dd class="content">

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
							<th scope="row">제품분류 <span class="font_red">*</span></th>
							<td><select id="ltypecombo" name="ltypecombo"></select></td>
							<th scope="row">제조사 <span class="font_red">*</span></th>
							<td><select id="mtypecombo" name="mtypecombo"></select></td>
						</tr>
						<tr>
							<th scope="row">제품명 <span class="font_red">*</span></th>
							<td><select id="ptypecombo" name="ptypecombo"></select></td>
							<th scope="row">주문수량 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="order_dt_amt" id="order_dt_amt" /></td>
						</tr>
					</tbody>
				</table>

				
				<!-- 제품 추가 버튼 -->
				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnAdd" name="btn"><span>추가</span></a> 
				</div>
				
				<!-- 추가된 제품 목록 그리드 시작 -->
				<div style="overflow-y:scroll; margin-top:25px;"> <!-- 무한 스크롤 -->
                	<table class="col">
						<caption>caption</caption>
						<colgroup>
							<col width="10%">
							<col width="40%">
							<col width="15%">
							<col width="10%">
							<col width="25%">
						</colgroup>
	
						<thead>
							<tr>
								<th scope="col">제품번호</th>
								<th scope="col">제품명</th>
								<th scope="col">판매가</th>
								<th scope="col">주문수량</th>
								<th scope="col">주문금액</th>
							</tr>
						</thead>
						
						<!-- bucket 출력 시작 -->
						<tbody id="bucket">
						</tbody>
						<!-- bucket 출력 끝 -->
						
					</table>
					<hr style="margin-top:30px;"> 
					<div style="display:flex; justify-content:center; align-content:center; margin-top:15px;">
						<span style="line-height:2.5; font-weight:bold; margin-right:5px;">= 총주문금액</span>
						<span id="order_tot_price" name="order_tot_price" style="line-height:2.5;"></span>
					</div>
                </div>
                <!-- 추가된 제품 목록 그리드 끝 -->
				
				<!-- 주문기업명, 요청사항 선택 시작 -->
				<table class="row" style="margin-top:25px;">
					<caption>caption</caption>
					<colgroup>
						<col width="25%">
						<col width="25%">
						<col width="25%">
						<col width="25%">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">주문기업명 <span class="font_red">*</span></th>
							<td><select id="clicombo" name="clicombo"></select></td>
							<th scope="row">주문날짜 <span class="font_red">*</span></th>
							<td><input type="date" id="order_date" name="order_date" style="font-size:13px; height:30px; width:170px;"></td>
						</tr>
						<tr>
							<th scope="row">요청사항 </th>
							<td colspan="3">
							    <textarea id="order_req" name="order_req"> </textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 주문기업명, 요청사항 선택 끝 -->
				

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
	<!-- 주문서 신규등록 모달 영역 끝 -->


	<!-- 상세내역 모달 영역 시작 -->
	<div id="layer2" class="layerPop layerType2" style="width:800px;">
	</div>
	<!-- 상세내역 모달 영역 끝 -->
	
	
</form>
</body>
</html>
	