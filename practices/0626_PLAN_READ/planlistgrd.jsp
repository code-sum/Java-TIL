<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

							<c:if test="${totalcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalcnt > 0 }">
								<c:forEach items="${plansearchlist}" var="list">
									<tr>
										<td>${list.pln_date}</td>
										<td><a href="">${list.pln_no}</a></td>
										<td>${list.pln_no}</td>
										<td>${list.pln_no}</td>
										<td>${list.pln_no}</td>
										<td>${list.pln_amt}</td>
										<td>${list.per_amt}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>