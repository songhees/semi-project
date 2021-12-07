<%@page import="semi.vo.Product"%>
<%@page import="semi.vo.ProductCategory"%>
<%@page import="java.util.List"%>
<%@page import="semi.admin.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>상품 등록</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "product");
	pageContext.setAttribute("dropdownMenu", "form");
	
	AdminService service = AdminService.getInstance();
	
	List<ProductCategory> categories = service.getAllCategories();
	List<Product> products = service.getAllProductsOrderByCategory();
%>
<%@ include file="/admin/common/navbar.jsp" %>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>상품 등록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<form class="border bg-light p-3" method="post" action="register.jsp" enctype="multipart/form-data">
					<div class="row g-2 mb-2">
						<div class="col-4">
							<label for="categoryNo" class="form-label">카테고리</label> 
							<select id="categoryNo" class="form-select" name="categoryNo">
								<option value="" selected disabled>카테고리를 선택하세요</option>
<%
	for (ProductCategory category : categories) {
%>
								<option value="<%=category.getNo() %>"><%=category.getName() %></option>
<%
	}
%>
							</select>
						</div>
						<div class="col-8">
							<label for="name" class="form-label">상품이름</label> 
							<input type="text" class="form-control" id="name" name="name">
						</div>
						<div class="col-4">
							<label for="price" class="form-label">가격</label>
							<input type="number" class="form-control" id="price" name="price">
						</div>
						<div class="col-4">
							<label for="discountPrice" class="form-label">할인가격</label>
							<input type="number" class="form-control" id="discountPrice" name="discountPrice">
						</div>
						<div class="col-2">
							<label for="discountFrom" class="form-label">할인시작일</label>
							<input type="datetime-local" class="form-control" id="discountFrom" name="discountFrom">
						</div>
						<div class="col-2">
							<label for="discountTo" class="form-label">할인종료일</label>
							<input type="datetime-local" class="form-control" id="discountTo" name="discountTo">
						</div>	
						<!-- 
							품목정보
						 -->
						<div class="col-4">
							<label for="color" class="form-label">색상</label> 
							<input type="text" class="form-control" id="color" name="color">
						</div>
						<div class="col-4">
							<label for="size" class="form-label">사이즈</label> 
							<input type="text" class="form-control" id="size" name="size">
						</div>
						<div class="col-3">
							<label for="stock" class="form-label">재고량</label> 
							<input type="number" class="form-control" id="stock" name="stock">
						</div>
						<div class="col-1 d-grid align-items-end mx-auto">
							<button type="button" class="btn btn-primary" onclick="addItemField()">추가</button>
						</div>
					</div>
					<!--  
						폼 입력요소가 추가될 div 엘리먼트
					-->
					<div class="row g-2 mb-2" id="item-box">
					</div>
					<!-- 
						상세정보
					 -->
					<div class="row g-2 mb-2">
						<div class="col-12">
							<label for="detail" class="form-label">상세정보</label> 
							<textarea rows="10" class="form-control" id="detail" name="detail"></textarea>
						</div>
					</div>
					<!-- 
						섬네일이미지 파일
					 -->
					<div class="row g-2 mb-2">
						<div class="col-12">
							<label for="thumbnailImage" class="form-label">섬네일이미지 파일</label>
							<input type="file" class="form-control" id="thumbnailImage" name="thumbnailImage" multiple>
						</div>
					</div>	
					<!-- 
						상세이미지 파일
					 -->
					<div class="row g-2 mb-2">
						<div class="col-12">
							<label for="detailImage" class="form-label">상세이미지 파일</label>
							<input type="file" class="form-control" id="detailImage" name="detailImage" multiple>
						</div>
					</div>
					<!-- 
						코디상품	
					 -->
					<div class="row g-2 mb-2">
						<div class="col-11">
							<label for="style" class="form-label">코디상품</label> 
							<select id="style" class="form-select" name="style">
								<option value="" selected disabled>상품을 선택하세요</option>
<%
	for (Product product : products) {
%>
								<option value="<%=product.getNo() %>"><%=product.getProductCategory().getName() %> - <%=product.getName() %> [<%=product.getNo() %>]</option>
<%	
	}
%>
							</select>
						</div>
						<div class="col-1 d-grid align-items-end mx-auto">
							<button type="button" class="btn btn-primary" onclick="addStyleField()">추가</button>
						</div>
					</div>
					<!--  
						폼 입력요소가 추가될 div 엘리먼트
					-->
					<div class="row g-2 mb-2" id="style-box">
					</div>							
					<div class="row mt-3">
						<div class="col-12 text-end">
							<a href="list.jsp" class="btn btn-secondary">취소</a>
							<button type="submit" class="btn btn-primary">등록</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
	var itemTemplate = `
		<div class="col-4" id="color-index">
			<input type="text" class="form-control" id="color" name="color">
		</div>
		<div class="col-4" id="size-index">
			<input type="text" class="form-control" id="size" name="size">
		</div>
		<div class="col-3" id="stock-index">
			<input type="number" class="form-control" id="stock" name="stock">
		</div>
		<div class="col-1 d-grid align-items-end mx-auto" id="itemButton-index">
			<button type="button" class="btn btn-danger" onclick="removeItemField(index)">삭제</button>
		</div>
	`;
	
	var itemCount = 100;
	var itemBox = document.getElementById("item-box");
	
	function addItemField() {
		var content = itemTemplate.replace(/index/g, itemCount);
		
		itemBox.insertAdjacentHTML('beforeend', content);
		
		itemCount++;
	}
	
	function removeItemField(no) {
		document.getElementById("color-" + no).remove();
		document.getElementById("size-" + no).remove();
		document.getElementById("stock-" + no).remove();
		document.getElementById("itemButton-" + no).remove();
	}
	
	var styleTemplate = `
		<div class="col-11" id="style-index">
			<select id="style" class="form-select" name="style">
				<option value="" selected disabled>상품을 선택하세요</option>
<%
	for (Product product : products) {
%>
				<option value="<%=product.getNo() %>"><%=product.getProductCategory().getName() %> - <%=product.getName() %> [<%=product.getNo() %>]</option>
<%	
	}
%>
			</select>
		</div>
		<div class="col-1 d-grid align-items-end mx-auto" id="styleButton-index">
			<button type="button" class="btn btn-danger" onclick="removeStyleField(index)">삭제</button>
		</div>
	`;
	
	var styleCount = 100;
	var styleBox = document.getElementById("style-box");
	
	function addStyleField() {
		var content = styleTemplate.replace(/index/g, styleCount);
		
		styleBox.insertAdjacentHTML('beforeend', content);
		
		styleCount++;
	}
	
	function removeStyleField(no) {
		document.getElementById("style-" + no).remove();
		document.getElementById("styleButton-" + no).remove();
	}
	</script>
</body>
</html>