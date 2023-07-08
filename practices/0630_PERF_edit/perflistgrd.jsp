<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="9">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${perfsearchlist}" var="list">
									<tr>
										<td>${list.pln_date}</td>
										<td>${list.loginID}</td>
										<td>${list.clnt_name}</td>
										<td>${list.pro_name}</td>
										<td>${list.splr_name}</td>
										<td>${list.product_name}</td>
										<td>${list.pln_amt}</td>
										<td>${list.per_amt}</td>
										<td>${list.pln_achv}%</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>