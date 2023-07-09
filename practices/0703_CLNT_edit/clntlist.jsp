<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>고객기업 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<!-- 대광유통 Favicon -->
<link rel="icon" type="image/png" sizes="16x16" href="${CTX_PATH}/images/admin/comm/favicon-16x16.png">

<!-- 우편번호 조회 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
	
<!-- 카카오맵 API key -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cddfe15bacfcebf2e218ddc6e15fd2eb&libraries=services"></script>
           
                             
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;     
	var pageBlockSize = 5;    
	
	/** OnLoad event */ 
	$(function() {
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		fn_clntlist();
		
		// 은행코드 콤보    상세코드테이블의 은행코드, 은행코드명 으로 만듬   
		comcombo("bk_cd","bkcombo","all","");   // group_code, combo_name, type(기본값  all : 전체   sel : 선택)    , selvalue(선택 되어 나올 값)         
		
	});
	
	
	/** 버튼 이벤트 등록 */
	
	function fRegisterButtonClickEvent() {
    $('a[name=btn]').click(function(e) {
        e.preventDefault();

        var btnId = $(this).attr('id');

        switch (btnId) {
	        case 'btnSearch' :
	            fn_clntlist();
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
	
	
	function fn_clntlist(pagenum) {
		
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
			
			$("#listclnt").empty().append(returnvalue);
			
			var  totalcnt = $("#totalcnt").val();
			
			console.log("totalcnt : " + totalcnt);
			
			var paginationHtml = getPaginationHtml(pagenum, totalcnt, pageSize, pageBlockSize, 'fn_clntlist');
			console.log("paginationHtml : " + paginationHtml);
			 
			$("#clntPagination").empty().append( paginationHtml );
			
			$("#pageno").val(pagenum);
		}
		
		callAjax("/busClm/clntlist.do", "post", "text", false, param, listcallback) ;
			
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

	        $("#map").hide();
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

	        $("#map").show();
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
	        
	        
			/****  카카오맵  JS코드 시작     ****/
	        var mapContainer = document.getElementById('map'), // 지도 표시할 div 
		        mapOption = {
		            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		            level: 3 // 지도의 확대 레벨
		        };  
		    // 지도 생성
		    var map = new kakao.maps.Map(mapContainer, mapOption); 
		    // 주소-좌표 변환 객체 생성
		    var geocoder = new kakao.maps.services.Geocoder();
		    // 주소로 좌표 검색
		    geocoder.addressSearch($("#clnt_add").val(), function(result, status) {
	
		        // 정상적으로 검색이 완료됐으면 
		         if (status === kakao.maps.services.Status.OK) {
		            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		            // 결과값으로 받은 위치를 마커로 표시
		            var marker = new kakao.maps.Marker({
		                map: map,
		                position: coords
		            });
		            // 지도의 중심을 결과값으로 받은 위치로 이동
		            map.setCenter(coords);
		        } 
		    });
		    /****  카카오맵  JS코드 끝     ****/
			
		    
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
	            alert("반영 되었습니다.");
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
					,	[ "clnt_hp", "담당자 연락처를 입력해 주세요." ]
					,	[ "clnt_zip", "우편번호를 입력해 주세요." ]
					,	[ "clnt_add", "주소를 입력해 주세요." ]
					,	[ "clnt_add_dt", "상세주소를 입력해 주세요." ]
					,	[ "clnt_email", "이메일을 입력해 주세요." ]
					,	[ "clnt_indst", "업종을 입력해 주세요." ]
					,	[ "clnt_indst_no", "사업자등록번호를 입력해 주세요." ]
					,	[ "bk_cd", "은행이름을 선택해 주세요." ]
					,	[ "clnt_acc", "계좌번호를 입력해 주세요." ]
				]
		);
		if (!chk) {
			return;
		}
		return true;
	}
	
	// 우편번호 API
	function execDaumPostcode(q) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById("clnt_zip").value = data.zonecode;
				document.getElementById("clnt_add").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("clnt_add_dt").focus();
			}
		}).open({
			q : q
		});
	}
	

</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="action"  name="action"  />
	<input type="hidden" id="clnt_no"  name="clnt_no"  />
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
								class="btn_nav bold">영업</span> <span class="btn_nav bold">고객기업
								관리</span> <a href="../busClm/clntManagement.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>고객기업 관리</span> <span class="fr">
							 <a class="btnType blue" href="javascript:fn_openpopup();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						
						<!-- 검색창 영역 시작 -->
						<div style="display:flex; justify-content:center; align-content:center; border:solid 3px #c0c0c0; border-radius: 10px; padding:40px 40px; margin:20px auto;">
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
									<col width="5%">
									<col width="20%">
									<col width="15%">
									<col width="35%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">기업명</th>
										<th scope="col">사업자번호</th>
										<th scope="col">주소</th>
										<th scope="col">회사전화</th>
										<th scope="col">담당자</th>
									</tr>
								</thead>
								<tbody id="listclnt"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="clntPagination"> </div>
						
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
				<strong>고객기업 관리</strong>
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
                   	<div id="map" style="margin-bottom:5px; width:100%; height:200px;"></div>
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
	