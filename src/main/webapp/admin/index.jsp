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
	// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
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
				<h2>고객관리</h2>
			</div> 		
		</div>
		<div class="row">
			<div class="col">	
				<h2>문의관리</h2>
			</div> 		
		</div>
		<div class="row">
			<div class="col">	
				<h2>리뷰관리</h2>
			</div> 		
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>