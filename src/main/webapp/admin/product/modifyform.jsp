<%@page import="java.text.SimpleDateFormat"%>
<%@page import="semi.vo.ProductStyle"%>
<%@page import="semi.vo.ProductDetailImage"%>
<%@page import="semi.vo.ProductThumbnailImage"%>
<%@page import="semi.vo.ProductItem"%>
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
    <title>상품 수정</title>
</head>
<body>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int pageNo = Integer.parseInt(request.getParameter("pageNo"));
	final String PATH = "/semi-project/resources/images/product/" + productNo + "/";

	AdminService service = AdminService.getInstance();
	Product product = service.getProductByNo(productNo);
	
	List<ProductCategory> categories = service.getAllCategories();
	List<ProductItem> items = service.getItemsByProductNo(productNo);
	List<ProductThumbnailImage> thumbnailImages = service.getThumbnailImagesByProductNo(productNo);
	List<ProductDetailImage> detailImages = service.getDetailImagesByProductNo(productNo);
	List<ProductStyle> styles = service.getStylesByNo(productNo);
	List<Product> products = service.getAllProductsOrderByCategory();
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
	String discountFrom = null;
	String discountTo = null;
	if (product.getDiscountPrice() != 0) {
		discountFrom = df.format(product.getDiscountFrom());
		discountTo = df.format(product.getDiscountTo());
	}
%>
<%@ include file="/admin/common/navbar.jsp" %>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>상품 수정</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<form class="border bg-light p-3" method="post" action="update.jsp?productNo=<%=productNo %>&pageNo=<%=pageNo %>" enctype="multipart/form-data">
					<div class="row g-2 mb-2">
						<div class="col-2">
							<label for="productNo" class="form-label">상품번호</label>
							<input type="number" class="form-control" id="productNo" name="productNo" value="<%=product.getNo() %>" readonly>
						</div>
						<div class="col-2">
							<label for="categoryNo" class="form-label">카테고리</label> 
							<select id="categoryNo" class="form-select" name="categoryNo">
								<option value="" disabled>카테고리를 선택하세요</option>
<%
	for (ProductCategory category : categories) {
%>
								<option value="<%=category.getNo() %>" <%=category.getNo() == product.getProductCategory().getNo() ? "selected" : "" %>><%=category.getName() %></option>
<%
	}
%>
							</select>
						</div>
						<div class="col-6">
							<label for="name" class="form-label">상품이름</label> 
							<input type="text" class="form-control" id="name" name="name" value="<%=product.getName() %>">
						</div>
						<div class="col-2">
							<div><label for="onSale" class="form-label mb-3">판매여부</label></div>	
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="onSale" id="onSale" value="Y" <%=product.getOnSale().equals("Y") ? "checked" : "" %>>
							  <label class="form-check-label" for="onSale">판매중</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="onSale" id="onSale" value="N" <%=product.getOnSale().equals("N") ? "checked" : "" %>>
							  <label class="form-check-label" for="onSale">판매중단</label>
							</div>
						</div>
						<div class="col-4">
							<label for="price" class="form-label">가격</label>
							<input type="number" class="form-control" id="price" name="price" value="<%=product.getPrice() %>">
						</div>
						<div class="col-4">
							<label for="discountPrice" class="form-label">할인가격</label>
							<input type="number" class="form-control" id="discountPrice" name="discountPrice" value="<%=product.getDiscountPrice() == 0 ? "" : product.getDiscountPrice()%>">
						</div>
						<div class="col-2">
							<label for="discountFrom" class="form-label">할인시작일</label>
							<input type="datetime-local" class="form-control" id="discountFrom" name="discountFrom" value="<%=discountFrom %>">
						</div>
						<div class="col-2">
							<label for="discountTo" class="form-label">할인종료일</label>
							<input type="datetime-local" class="form-control" id="discountTo" name="discountTo" value="<%=discountTo %>">
						</div>	
					</div>
					<!-- 
						품목정보
					 -->
					<div class="row g-2">	 
						<div class="col-2 mb-2">
							<label for="itemNo" class="form-label">품목번호</label>
						</div>
						<div class="col-2 mb-2">
							<label for="color" class="form-label">색상</label>
						</div>
						<div class="col-4 mb-2">
							<label for="size" class="form-label">사이즈</label>
						</div>
						<div class="col-3 mb-2">
							<label for="stock" class="form-label">재고량</label>
						</div>
						<div class="col-1 mb-2 d-grid align-items-end mx-auto">
						</div>	
					</div>
					<!--  
						폼 입력요소가 추가될 div 엘리먼트
					-->
					<div class="row g-2 mb-2" id="item-box">				
<%
	int index = 0;
	for (ProductItem item : items) {
%>
						<div class="col-2 mb-2 mt-0" id="itemNo-<%=index %>">
							<input type="number" class="form-control" id="itemNo" name="itemNo" value="<%=item.getNo() %>" readonly>
						</div>
						<div class="col-2 mb-2 mt-0" id="color-<%=index %>">
							<input type="text" class="form-control" id="color" name="color" value="<%=item.getColor() %>">
						</div>
						<div class="col-4 mb-2 mt-0" id="size-<%=index %>">
							<input type="text" class="form-control" id="size" name="size" value="<%=item.getSize() %>">
						</div>
						<div class="col-3 mb-2 mt-0" id="stock-<%=index %>">
							<input type="number" class="form-control" id="stock" name="stock" value="<%=item.getStock() %>">
						</div>
						<div class="col-1 mb-2 mt-0 d-grid align-items-end mx-auto" id="itemButton-<%=index %>">
							<button type="button" class="btn btn-danger" onclick="removeItemField(<%=index %>)">삭제</button>
						</div>
<%
		index++;
	}
%>
					</div>
					<div class="row g-2 mb-2">
						<div class="col-11">
						</div>
						<div class="col-1 mt-0 d-grid align-items-end mx-auto" id="itemButton-<%=index %>">
							<button type="button" class="btn btn-primary" onclick="addItemField()">추가</button>
						</div>
					</div>
					<!-- 
						상세정보
					 -->
					<div class="row g-2 mb-2">
						<div class="col-12">
							<label for="detail" class="form-label">상세정보</label> 
							<textarea rows="10" class="form-control" id="detail" name="detail"><%=product.getDetail() != null ? product.getDetail() : ""%></textarea>
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
<%
	if (!thumbnailImages.isEmpty()) {
		for (ProductThumbnailImage image : thumbnailImages) {
%>
					<div class="row g-2 mb-2">
						<table class="table" style="table-layout: fixed; width: 100%">
							<tbody>
								<tr class="d-flex">
									<td class="col-2"><a href="<%=PATH %><%=image.getUrl()%>"><img src="<%=PATH %><%=image.getUrl()%>" class="img-thumbnail" style="width: 100px;"></a></td>
									<td class="col-9" style="word-wrap: break-word"><%=PATH %><%=image.getUrl() %></td>
									<td class="col-1"><input class="form-check-input" type="checkbox" name="thumbnailImageSaved" value="<%=image.getUrl() %>" checked></td>
								</tr>
							</tbody>
						</table>
					</div>	
<%
		}
	}
%>
					<!-- 
						상세이미지 파일
					 -->
					<div class="row g-2 mb-2">
						<div class="col-12">
							<label for="detailImage" class="form-label">상세이미지 파일</label>
							<input type="file" class="form-control" id="detailImage" name="detailImage" multiple>
						</div>
					</div>
<%
	if (!detailImages.isEmpty()) {
		for (ProductDetailImage image : detailImages) {
%>
					<div class="row g-2 mb-2">
						<table class="table" style="table-layout: fixed; width: 100%">
							<tbody>
								<tr class="d-flex">
									<td class="col-2"><a href="<%=PATH %><%=image.getUrl()%>"><img src="<%=PATH %><%=image.getUrl()%>" class="img-thumbnail" style="width: 100px;"></a></td>
									<td class="col-9" style="word-wrap: break-word"><%=PATH %><%=image.getUrl() %></td>
									<td class="col-1"><input class="form-check-input" type="checkbox" name="detailImageSaved" value="<%=image.getUrl() %>" checked></td>
								</tr>
							</tbody>
						</table>
					</div>	
<%
		}
	}
%>
					<!-- 
						코디상품정보
					-->
					<div class="row g-2">	 
						<div class="col-11">
							<label for="styleProductNo" class="form-label">코디상품</label>
						</div>
						<div class="col-1 d-grid align-items-end mx-auto">
						</div>		
					</div>
					<!--  
						폼 입력요소가 추가될 div 엘리먼트
					-->
					<div class="row g-2 mb-2" id="style-box">
<%
	if (styles.isEmpty()) {
%>
						<div class="col-11">
							<select id="style" class="form-select" name="style">
								<option value="" selected disabled>상품을 선택하세요</option>
<%
		for (Product styleProduct : products) {
%>
								<option value="<%=styleProduct.getNo() %>"><%=styleProduct.getProductCategory().getName() %> - <%=styleProduct.getName() %> [<%=styleProduct.getNo() %>]</option>
<%	
		}
%>
							</select>
						</div>
						<div class="col-1 d-grid align-items-end mx-auto">
							<button type="button" class="btn btn-primary" onclick="addStyleField()">추가</button>
						</div>
<%
	} else {
		index = 0;
		for (ProductStyle style : styles) {
%>
						<div class="col-11" id="style-<%=index %>">
							<select id="style" class="form-select" name="style">
								<option value="" disabled>상품을 선택하세요</option>
<%
			for (Product prod : products) {
%>
								<option value="<%=prod.getNo() %>" <%=prod.getNo() == style.getProduct().getNo() ? "selected" : "" %>><%=prod.getProductCategory().getName() %> - <%=prod.getName() %> [<%=prod.getNo() %>]</option>
<%	
			}
%>
							</select>
						</div>
						<div class="col-1 d-grid align-items-end mx-auto" id="styleButton-<%=index %>">
							<button type="button" class="btn btn-danger" onclick="removeStyleField(<%=index %>)">삭제</button>
						</div>
<%
		}
	}
%>							
					</div>
<%
	if (!styles.isEmpty()) {
%>
					<div class="row g-2 mb-2">
						<div class="col-11">
						</div>
						<div class="col-1 d-grid align-items-end mx-auto">
							<button type="button" class="btn btn-primary" onclick="addStyleField()">추가</button>
						</div>
					</div>
<%
	}
%>
					<div class="row mt-3">
						<div class="col-12 text-end">
							<a href="detail.jsp?productNo=<%=productNo %>&pageNo=<%=pageNo %>" class="btn btn-secondary">취소</a>
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
		<div class="col-2 mb-2 mt-0" id="itemNo-index">
			<input type="number" class="form-control" id="itemNo" name="itemNo" value="" disabled>
		</div>
		<div class="col-2 mb-2 mt-0" id="color-index">
			<input type="text" class="form-control" id="color" name="color">
		</div>
		<div class="col-4 mb-2 mt-0" id="size-index">
			<input type="text" class="form-control" id="size" name="size">
		</div>
		<div class="col-3 mb-2 mt-0" id="stock-index">
			<input type="number" class="form-control" id="stock" name="stock">
		</div>
		<div class="col-1 mb-2 mt-0 d-grid align-items-end mx-auto" id="itemButton-index">
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
		document.getElementById("itemNo-" + no).remove();
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
	for (Product prod : products) {
%>
				<option value="<%=prod.getNo() %>"><%=prod.getProductCategory().getName() %> - <%=prod.getName() %> [<%=prod.getNo() %>]</option>
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