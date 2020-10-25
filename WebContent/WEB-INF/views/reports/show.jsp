<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">
        <c:choose>
            <c:when test="${report != null}">
                <h2>日報　詳細ページ</h2>

                <table>
                    <tbody>
                        <tr>
                            <th>氏名</th>
                            <td><c:out value="${report.employee.name}" /></td>
                        </tr>
                        <tr>
                            <th>日付</th>
                            <td><fmt:formatDate value="${report.report_date}" pattern="yyyy-MM-dd" /></td>
                        </tr>
                        <tr>
                            <th>内容</th>
                            <td>
                                <pre><c:out value="${report.content}" /></pre>
                            </td>
                        </tr>
                        <tr>
                            <th>登録日時</th>
                            <td>
                                <fmt:formatDate value="${report.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <th>更新日時</th>
                            <td>
                                <fmt:formatDate value="${report.updated_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br>

                <c:if test="${sessionScope.login_employee.id == report.employee.id}">
                    <p><img class="like" src="${pageContext.request.contextPath}/img/heart_white.jpg" width="30" height="30">
                        ${likes_count}</p>
                    <p><a href="<c:url value="/reports/edit?id=${report.id}" />">この日報を編集する</a></p>
                </c:if>

                <c:if test="${sessionScope.login_employee.id != report.employee.id}">
                    <c:choose>
                        <c:when test="${like == null}" > <!-- レコードが存在しないとき -->
                            <form method="POST" action="<c:url value='/likes/create?id=${report.id}' />">
                                <p><input type="image" class="like" src="${pageContext.request.contextPath}/img/heart_white.jpg" width="30" height="30" alt="いいね!">
                                    ${likes_count}</p>
                                <input type="hidden" name="_token" value="${_token}">

                            </form>
                        </c:when>
                        <c:when test="${like != null}" > <!-- レコードが存在するとき -->
                            <form method="POST" action="<c:url value='/likes/destroy?id=${report.id}'/>">
                                <p><input type="image" class="like" src="${pageContext.request.contextPath}/img/heart_red.jpg" width="30" height="30" alt="取り消し">
                                    ${likes_count}</p>
                                <input type="hidden" name="_token" value="${_token}">
                                <input type="hidden" name="like_id" value="${like.id}">
                            </form>
                        </c:when>
                    </c:choose>
                </c:if>

            </c:when>
            <c:otherwise>
                <h2>お探しのデータは見つかりませんでした。</h2>
            </c:otherwise>
        </c:choose>

        <p><a href="<c:url value="/reports/index" />">一覧に戻る</a></p>
    </c:param>
</c:import>