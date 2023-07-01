<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

		<dl>
			<dt>
				<strong>주문 상세내역</strong>
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
							<th scope="row">주문번호</th>
							<td><input type="text" class="inputTxt p100" id="order_no" name="order_no" value="${ordersearch.order_no}" readonly/></td>
							<th scope="row">주문날짜</th>
							<td><input type="text" class="inputTxt p100" id="order_date" name="order_date" value="${ordersearch.order_date}" readonly/></td>
						</tr>
						<tr>
							<th scope="row">주문기업명</th>
							<td><input type="text" class="inputTxt p100" id="clnt_name" name="clnt_name" value="${ordersearch.clnt_name}" readonly/></td>
							<th scope="row">회사전화</th>
							<td><input type="text" class="inputTxt p100" id="clnt_tel" name="clnt_tel" value="${ordersearch.clnt_tel}" readonly/></td>
						</tr>
						<tr>
							<th scope="row">회사이메일</th>
							<td><input type="text" class="inputTxt p100" id="clnt_email" name="clnt_email" value="${ordersearch.clnt_email}" readonly/></td>
							<th scope="row">영업담당자</th>
							<td><input type="text" class="inputTxt p100" id="name" name="name" value="${ordersearch.name}" readonly/></td>
						</tr>
						
						<tr>
							<th scope="row">우편번호</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="clnt_zip" name="clnt_zip" value="${ordersearch.clnt_zip}" readonly/></td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="clnt_add" name="clnt_add" value="${ordersearch.clnt_add}" readonly/></td>
						</tr>
						<tr>
							<th scope="row">상세주소</th>
							<td colspan="3"><input type="text" class="inputTxt p100"
								id="clnt_add_dt" name="clnt_add_dt" value="${ordersearch.clnt_add_dt}" readonly/></td>
						</tr>
						<tr>
							<th scope="row">요청사항</th>
							<td colspan="3">
								<textarea id="order_req" name="order_req" readonly>${ordersearch.order_req}</textarea></td>
						</tr>
					</tbody>
				</table>

                <div style="overflow-y:scroll; margin-top:15px;"> <!-- 주문 상세내역 무한 스크롤 -->
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
						<tbody id="listorder">
							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${orderdetaillist}" var="list">
									<tr>
										<td>${list.product_no}</td>
										<td>${list.product_name}</td>
										<td><fmt:formatNumber value="${list.product_price}" pattern="#,##0"/></td>
										<td>${list.order_dt_amt}</td>
										<td><fmt:formatNumber value="${list.order_dt_price}" pattern="#,##0"/></td>
									</tr>
								</c:forEach>
							</c:if>	
						</tbody>
					</table>
					<div style="display:flex; justify-content:center; align-content:center; margin-top:15px;">
						<span style="font-weight:bold; margin-right:10px;">총주문금액</span>
						<fmt:formatNumber value="${ordersearch.order_tot_price}" pattern="#,##0"/>
					</div>
                </div>

				<!-- e : 여기에 내용입력 -->

				<!-- [닫기] 버튼  -->
				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
							
		<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>