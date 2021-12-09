<%@page import="semi.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	User loginUserInfo = (User)session.getAttribute("ADMIN_USER_INFO");
	
	if (loginUserInfo == null || !"Y".equals(loginUserInfo.getAdmin())) {
		session.invalidate();
		response.sendRedirect("/semi-project/loginform.jsp");
	}
	
	String menu = (String)pageContext.getAttribute("menu");
	String dropdownMenu = (String)pageContext.getAttribute("dropdownMenu");
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light mb-3">
	<div class="container">
		<a class="navbar-brand" href="/semi-project/admin/index.jsp">관리자모드</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link <%="home".equals(menu) ? "active" : "" %>" aria-current="page" href="/semi-project/admin/index.jsp">관리자홈</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle <%="product".equals(menu) ? "active" : "" %>" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">상품관리</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item <%="category".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/category.jsp">카테고리</a></li>
						<li><a class="dropdown-item <%="outer".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/list.jsp?categoryNo=1001">OUTER</a></li>
						<li><a class="dropdown-item <%="top".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/list.jsp?categoryNo=1002">TOP</a></li>
						<li><a class="dropdown-item <%="shirt-blouse".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/list.jsp?categoryNo=1003">SHIRT&amp;BLOUSE</a></li>
						<li><a class="dropdown-item <%="dress".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/list.jsp?categoryNo=1004">DRESS</a></li>
						<li><a class="dropdown-item <%="skirt".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/list.jsp?categoryNo=1005">SKIRT</a></li>
						<li><a class="dropdown-item <%="pants".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/list.jsp?categoryNo=1006">PANTS</a></li>
						<li><a class="dropdown-item <%="product-list".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/list.jsp">전체상품</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item <%="form".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/product/form.jsp">상품등록</a></li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">주문관리</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item" href="#">주문목록</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#">주문등록</a></li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle <%="user".equals(menu) ? "active" : "" %>" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">고객관리</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item <%="user-list".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/user/list.jsp">고객목록</a></li>
					</ul>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle <%="inquiry".equals(menu) ? "active" : "" %>" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">문의관리</a>
					<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
						<li><a class="dropdown-item <%="inquiry-list".equals(dropdownMenu) ? "active" : "" %>" href="/semi-project/admin/inquiry/list.jsp">문의목록</a></li>
					</ul>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#">리뷰관리</a>
				</li>
			</ul>
			<ul class="navbar-nav mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link" href="/semi-project/index.jsp">관리자모드 나가기</a>
				</li>
			</ul>
		</div>
	</div>
</nav>