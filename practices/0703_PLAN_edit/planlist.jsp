<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>영업계획</title>
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
		
		fn_planlist();
		
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
		
		/* 모달 내부 콤보박스 모음   */
		// 고객기업명
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
	            fn_planlist();
	            break;
	        case 'btnSave' :
	            fn_save();
	            break;
	        case 'btnDelete' :
	            $("#action").val("D");	
	            fn_save();
	            break;
	        case 'btnClose' :
	            gfCloseModal();
	            break;
	        }
	    });
	}
	
	
	function fn_planlist(pagenum) {
		
		pagenum = pagenum || 1;
		
		var param = {
			start : $("#searchstart").val()
		  , end : $("#searchend").val()
		  , searchclicombo : $("#searchclicombo").val()
		  , searchptypecombo : $("#searchptypecombo").val()
		  , pageSize : pageSize
		  , pageBlockSize : pageBlockSize
		  , pagenum : pagenum
		}
		
		var listcallback = function(returnvalue) {
			console.log(returnvalue);
			
			$("#listplan").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_planlist');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#planPagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
		}
		
		callAjax("/busSap/planlist.do", "post", "text", false, param, listcallback) ;
			
	}
	
	
	function fn_openpopup() {
		
		popupinit();
		
		// 모달 팝업
		gfModalPop("#layer1");
					
	}
	
	
	function popupinit(object) {
		
	    if(object == "" || object == null || object == undefined) {
	    	$("#pln_no").val("");
	        $("#clicombo").val("");
	        $("#ltypecombo").val("");
	        $("#mtypecombo").val("");
	        $("#ptypecombo").val("");
	        $("#pln_amt").val("");
	        $("#per_amt").val("");
	        $("#pln_memo").val("");

	        $("#btnDelete").hide();
	        $("#action").val("I");	
	        
	    } else {
	    	$("#pln_no").val(object.pln_no);
	        $("#clicombo").val(object.clnt_no);
	        
	   		// 제품분류~제조사~제품명  콤보박스 데이터들 불러오기
	        $("#ltypecombo").val(object.pro_cd);	  
			productCombo("m","mtypecombo","all",$("#ltypecombo").val(),"",object.splr_no);  
			productCombo("p","ptypecombo","all",$("#ltypecombo").val(),$("#mtypecombo").val(),object.product_no); 
			
	        $("#pln_amt").val(object.pln_amt);
	        $("#per_amt").val(object.per_amt);
	        $("#pln_memo").val(object.pln_memo);

	        $("#btnDelete").show();
	        $("#action").val("U");	
	    }
	}
	
	
	function fn_selectone(no) {
		
	    var param = {
	        pln_no : no
	    }

	    var selectoncallback = function(returndata) {			
	        console.log( JSON.stringify(returndata) );
	        popupinit(returndata.plansearch);

	        // 모달 팝업
	        gfModalPop("#layer1");
	    }
	    callAjax("/busSap/planselectone.do", "post", "json", false, param, selectoncallback) ;
	}
	
	
	function fn_save() {
		
		// 비어있는 값으로 저장되지 않도록 유효성 검사
	    if ( ! fn_Validate() ) {
	        return;
	    }

		// serialize() 사용으로, var param 선언X

	    var savecallback = function(reval) {
	        console.log( JSON.stringify(reval) );

	        if(reval.returncval > 0) {
	            alert("반영 되었습니다.");
	            gfCloseModal();

	            if($("#action").val() == "U") {
	                fn_planlist($("#pageno").val());
	            } else {
	                fn_planlist();
	            }
	        }  else {
	            alert("오류가 발생 되었습니다.");				
	        }
	    }

	    callAjax("/busSap/plansave.do", "post", "json", false, $("#myForm").serialize(), savecallback) ;

	}
	
	
	function fn_Validate() {
		var chk = checkNotEmpty(
				[
						[ "clicombo", "고객기업명을 선택해 주세요." ]
					,	[ "ltypecombo", "제품분류를 선택해 주세요." ]
					,	[ "mtypecombo", "제조사를 선택해 주세요." ]
					,	[ "ptypecombo", "제품명을 선택해 주세요." ]
					,	[ "pln_amt", "목표수량를 입력해 주세요." ]
					,	[ "per_amt", "0 이상의 실적수량를 입력해 주세요." ]
				]
		);
		if (!chk) {
			return;
		}
		return true;
	}
	

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action"  name="action"  />
	<input type="hidden" id="pln_no"  name="pln_no"  />
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
								class="btn_nav bold">영업</span> <span class="btn_nav bold">영업계획
								</span> <a href="../busSap/salePlan.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>영업계획</span> <span class="fr">
							 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						<!-- 검색창 영역 시작 -->
						<div style="display:flex; justify-content:center; align-content:center; border:solid 3px #c0c0c0; border-radius: 10px; padding:40px 40px; margin:20px auto;">
							<div style="display:flex; flex-direction:column; line-height:2; padding-right:50px;">
								<div style="display:flex; justify-content:center; align-content:center;">
									<label for="searchclicombo" style="font-size:15px; font-weight:bold; margin-right:10px;">고객기업명</label>
									<select id="searchclicombo" name="searchclicombo" style="width:150px; margin-right:50px;"></select>
									 							
									<label for="start" style="font-size:15px; font-weight:bold; margin-right:10px;">등록일</label>
									<input type="date" id="searchstart" name="searchstart" style="height:30px; width:100px; margin-right:5px;">
									<span style="margin-right:5px; line-height:3;"> ~ </span>
									<input type="date" id="searchend" name="searchend" style="height:30px; width:100px; margin-right:50px;">
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
									<col width="15%">
									<col width="10%">
									<col width="15%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">등록일</th>
										<th scope="col">고객기업명</th>
										<th scope="col">제품분류</th>
										<th scope="col">제조사</th>
										<th scope="col">제품명</th>
										<th scope="col">목표수량</th>
										<th scope="col">실적수량</th>
									</tr>
								</thead>
								<tbody id="listplan"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="planPagination"> </div>
						
                     
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>영업계획 관리</strong>
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
							<th scope="row">고객기업명 <span class="font_red">*</span></th>
							<td><select id="clicombo" name="clicombo"></select></td>
							<th scope="row">제품분류 <span class="font_red">*</span></th>
							<td><select id="ltypecombo" name="ltypecombo"></select></td>
						</tr>
						<tr>
							<th scope="row">제조사 <span class="font_red">*</span></th>
							<td><select id="mtypecombo" name="mtypecombo"></select></td>
							<th scope="row">제품명 <span class="font_red">*</span></th>
							<td><select id="ptypecombo" name="ptypecombo"></select></td>
						</tr>
						<tr>
							<th scope="row">목표수량 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="pln_amt" id="pln_amt" /></td>
							<th scope="row">실적수량 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="per_amt" id="per_amt" /></td>
						</tr>
						<tr>
							<th scope="row">메모</th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="pln_memo" id="pln_memo" /></td>
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

	<!--// 모달팝업 -->
</form>
</body>
</html>
	