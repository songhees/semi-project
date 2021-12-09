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
	pageContext.setAttribute("menu", "home");
%>
<%@ include file="/admin/common/navbar.jsp" %>
	<div class="container">   
		<div class="row">
			<div class="col">	
				<h1>관리자 홈</h1>
			</div> 		
		</div>
		<div class="row">
			<div class="col">	
				<h2><a href="/semi-project/admin/product/category.jsp">상품관리</a></h2>
			</div> 		
		</div>
		<div class="row">
			<div class="col">	
				<h2>주문관리</h2>
			</div> 		
		</div>
		<div class="row">
			<div class="col">	
				<h2><a href="/semi-project/admin/user/list.jsp">고객관리</a></h2>
			</div> 		
		</div>
		<div class="row">
			<div class="col">	
				<h2><a href="/semi-project/admin/inquiry/list.jsp">문의관리</a></h2>
			</div> 		
		</div>
		<div class="row">
			<div class="col">	
				<h2><a href="/semi-project/admin/review/list.jsp">리뷰관리</a></h2>
			</div> 		
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>