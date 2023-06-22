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
								<c:forEach items="${clntsearchlist}" var="list">
									<tr>
										<td>${list.clnt_no}</td>
										<td><a href="javascript:fn_selectone('${list.clnt_no}')">${list.clnt_name}</a></td>
										<td>${list.clnt_indst_no}</td>
										<td>${list.clnt_add} ${list.clnt_add_dt}</td>
										<td>${list.clnt_tel}</td>
										<td>${list.clnt_mng}</td>
									</tr>
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalcnt" name="totalcnt" value ="${totalcnt}"/>