<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="6">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${ordersearchlist}" var="list">
									<tr>
										<td>${list.order_no}</td>
										<td>${list.order_date}</td>
										<td>${list.clnt_name}</td>
										<td><fmt:formatNumber value="${list.order_tot_price}" pattern="#,##0" /></td>
										<td>${list.name}</td>
										<td><a class="btnType3 color1" href="javascript:fn_selectone('${list.order_no}')">보기</a></td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>