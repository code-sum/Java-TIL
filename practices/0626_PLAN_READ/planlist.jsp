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

<!-- 우편번호 조회 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
                              
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;     
	var pageBlockSize = 5;    
	
	
	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fn_planlist();
		
		/* 콤보박스 모음   */
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
	        case 'btnClose' :
	            gfCloseModal();
	            break;
	        }
	    });
	}
	
	
	function fn_planlist(pagenum) {
		
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
	        $("#clnt_name").val("");
	        $("#clnt_tel").val("");
	        $("#clnt_mng").val("");
	        $("#clnt_hp").val("");
	        $("#clnt_zip").val("");
	        $("#clnt_add").val("");
	        $("#clnt_add_dt").val("");
	        $("#clnt_email").val("");
	        $("#clnt_indst").val("");
	        $("#clnt_indst_no").val("");
	        $("#bkcombo").val("");
	        $("#clnt_acc").val("");
	        $("#clnt_memo").val("");
	        $("#clnt_no").val("");

	        $("#btnDelete").hide();

	        // object 가 없는 상태로 팝업 뜰 땐, action 을 “I” 로 설정하여  INSERT
	        $("#action").val("I");	
	    } else {
	        $("#clnt_name").val(object.clnt_name);
	        $("#clnt_tel").val(object.clnt_tel);
	        $("#clnt_mng").val(object.clnt_mng);
	        $("#clnt_hp").val(object.clnt_hp);
	        $("#clnt_zip").val(object.clnt_zip);
	        $("#clnt_add").val(object.clnt_add);
	        $("#clnt_add_dt").val(object.clnt_add_dt);
	        $("#clnt_email").val(object.clnt_email);
	        $("#clnt_indst").val(object.clnt_indst);
	        $("#clnt_indst_no").val(object.clnt_indst_no);
	        $("#clnt_acc").val(object.clnt_acc);
	        $("#bkcombo").val(object.bk_cd);
	        $("#clnt_memo").val(object.clnt_memo);
	        $("#clnt_no").val(object.clnt_no);

	        $("#btnDelete").show();

	        // object 가 있는 상태로 팝업 뜰 땐, action 을 “U” 로 설정하여  UPDATE
	        $("#action").val("U");	
	    }
	}
	
	
	function fn_selectone(no) {
		
	    var param = {
	        clnt_no : no
	    }

	    var selectoncallback = function(returndata) {			
	        
	        console.log( JSON.stringify(returndata) );

	        popupinit(returndata.clntsearch);

	        // 모달 팝업
	        gfModalPop("#layer1");

	    }

	    callAjax("/busClm/clntselectone.do", "post", "json", false, param, selectoncallback) ;

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
	            alert("저장 되었습니다.");
	            gfCloseModal();

	            if($("#action").val() == "U") {
	                fn_clntlist($("#pageno").val());
	            } else {
	                fn_clntlist();
	            }
	        }  else {
	            alert("오류가 발생 되었습니다.");				
	        }
	    }

	    callAjax("/busClm/clntsave.do", "post", "json", false, $("#myForm").serialize(), savecallback) ;

	}
	
	
	function fn_Validate() {
		var chk = checkNotEmpty(
				[
						[ "clnt_name", "기업명을 입력해 주세요." ]
					,	[ "clnt_tel", "회사 전화를 입력해 주세요." ]
					,	[ "clnt_mng", "담당자를 입력해 주세요." ]
					,	[ "clnt_hp", "담당자 전화를 입력해 주세요." ]
					,	[ "clnt_zip", "우편번호를 입력해 주세요." ]
					,	[ "bk_cd", "은행이름을 선택해 주세요." ]
					,	[ "clnt_acc", "계좌번호를 입력해 주세요." ]
					,	[ "clnt_add", "주소를 입력해 주세요." ]
					,	[ "clnt_add_dt", "상세주소를 입력해 주세요." ]
					,	[ "clnt_indst", "업종을 입력해 주세요." ]
					,	[ "clnt_indst_no", "사업자등록번호를 입력해 주세요." ]
					,	[ "clnt_email", "이메일을 입력해 주세요." ]
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
						<div style="display:flex; justify-content:center; align-content:center; border:1px solid DeepSkyBlue; padding:40px 40px; margin-bottom: 8px;">
							<select id="searchKey" name="searchKey" style="width:150px; margin-right:5px;" >
						        <option value="" >검색조건</option>
								<option value="cl_name" >기업명</option>
								<option value="cl_indst_no" >사업자등록번호</option>
							</select> 
							<input type="text" style="width:300px; height:28px; margin-right:5px;" id="sname" name="sname">
							<a href="" class="btnType blue" id="btnSearch" name="btn"><span>검  색</span></a>
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
	<div id="layer1" class="layerPop layerType2" style="width: 650px;">
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
							<th scope="row">기업명 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="clnt_name" id="clnt_name" /></td>
							<th scope="row">회사 전화 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="clnt_tel" id="clnt_tel" /></td>
						</tr>
						<tr>
							<th scope="row">담당자 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="clnt_mng" id="clnt_mng" /></td>
							<th scope="row">담당자 연락처 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="clnt_hp" id="clnt_hp" /></td>
						</tr>
						<tr>
							<th scope="row">우편번호 <span class="font_red">*</span></th>
							<td colspan="3">
								<div style="display:flex; flex-direction:row;">
									<input type="text" class="inputTxt p100" name="clnt_zip" id="clnt_zip" />
									<input type="button" value="우편번호 찾기"
									       onclick="execDaumPostcode()" style="margin-left:5px; width:130px; height:30px;" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">주소 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="clnt_add" id="clnt_add" /></td>
						</tr>
						<tr>
							<th scope="row">상세주소 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="clnt_add_dt" id="clnt_add_dt" /></td>
						</tr>
						<tr>
							<th scope="row">회사 이메일 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="clnt_email" id="clnt_email" /></td>
						</tr>
						<tr>
							<th scope="row">업종 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="clnt_indst" id="clnt_indst" /></td>
						</tr>
						<tr>
							<th scope="row">사업자등록번호 <span class="font_red">*</span></th>
							<td colspan="3"><input type="text" class="inputTxt p100" name="clnt_indst_no" id="clnt_indst_no" /></td>
						</tr>
						<tr>
							<th scope="row">계좌번호 <span class="font_red">*</span></th>
							<td colspan="3">
								<div style="display:flex; flex-direction:row;">
									<select id="bkcombo" name="bkcombo" style="margin-right:5px;"></select>
									<input type="text" class="inputTxt p100" name="clnt_acc" id="clnt_acc" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">메모 </th>
							<td colspan="3">
							    <textarea id="clnt_memo" name="clnt_memo"> </textarea>
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

	<!--// 모달팝업 -->
</form>
</body>
</html>
	