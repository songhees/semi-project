<%@page import="semi.vo.User"%>
<%@page import="java.util.List"%>
<%@page import="semi.vo.Pagination"%>
<%@page import="semi.admin.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "user");
	pageContext.setAttribute("dropdownMenu", "user-list");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	String pageNo = request.getParameter("pageNo");

	AdminService service = AdminService.getInstance();
	
	int totalRecords = 0;
	Pagination pagination = null;
	List<User> users = List.of();
	totalRecords = service.getTotalUserRecords();
	pagination = new Pagination(pageNo, totalRecords, 5, 5);
	users = service.getUserList(pagination.getBegin(), pagination.getEnd());	
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>고객 목록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-1">고객번호</th>
							<th class="col-1">아이디</th>
							<th class="col-3">전화번호</th>
							<th class="col-3">이메일</th>
							<th class="col-1">등급</th>
							<th class="col-1">포인트</th>
							<th class="col-2">가입날짜</th>
						</tr>
					</thead>
					<tbody>
<% 
	if (users.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="text-center" colspan="7">고객정보가 존재하지 않습니다.</td>
						</tr>
<%
	} else {
		for (User user : users) {
%>
						<tr class="d-flex">
							<td class="col-1"><%=user.getNo() %></td>
							<td class="col-1"><a href="detail.jsp?userNo=<%=user.getNo() %>&pageNo=<%=pagination.getPageNo() %>"><%=user.getId() %></a></td>
							<td class="col-3"><%=user.getTel() %></td>
							<td class="col-3"><%=user.getEmail() %></td>
							<td class="col-1"><%=user.getGradeCode() %></td>
							<td class="col-1"><%=user.getPoint() %></td>
							<td class="col-2"><%=user.getCreatedDate() %></td>
						</tr>
<%
						
		}
	}
%>		
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<nav>
					<ul class="pagination justify-content-center">
						<!-- 
							Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
							Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 	-->
					 	<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
						<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
	}
%>
					 	<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>" >다음</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>