<%@page import="vo.ProductCategory"%>
<%@page import="java.util.List"%>
<%@page import="service.AdminService"%>
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
<%@ include file="../common/navbar.jsp" %>
<%
	AdminService service = AdminService.getInstance();
	List<ProductCategory> categories = service.getAllCategories();
%>
	<div class="container"> 
		<div class="row">
			<div class="col">
				<h1>카테고리 목록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr>
							<th>카테고리번호</th>
							<th>카테고리이름</th>
						</tr>
					</thead>
					<tbody>
<%
	for (ProductCategory category : categories) {
%>
						<tr>
							<td><%=category.getNo() %></td>
							<td><a href="list.jsp?categoryNo=<%=category.getNo() %>"><%=category.getName() %></a></td>
						</tr>
<%
	}
%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>