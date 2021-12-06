<%@page import="semi.vo.ProductCategory"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="semi.vo.Product"%>
<%@page import="semi.dao.ProductDao"%>
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
<style>
#inquiry-image {
	width: 80px;
	height: 80px;
}
</style>
<body>
<%
	String no = request.getParameter("no");
	ProductDao productDao = ProductDao.getInstance();
	DecimalFormat formatter = new DecimalFormat("###,###");
	int productNo = 0;
%>
<%@ include file="../common/navbar.jsp"%>
<div class="container">
	<div class="row mb-5">
		<div class="col">
			<div class="d-flex justify-content-end">
				<nav style="-bs-breadcrumb-divider: '&gt;';" aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="/semi-prodject/index.jsp" style="text-decoration: none; color: gray;">Home</a></li>
						<li class="breadcrumb-item">BOARD</li>
						<li class="breadcrumb-item active" aria-current="page">Q&amp;A</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
		<div class="row mt-5 pt-5 mb-3">
			<div class="col">
				<h4 align="center">
					<strong>Q&amp;A</strong>
				</h4>
				<h6 align="center">상품 Q&amp;A입니다.</h6>
			</div>
		</div>
		<div class="row">
			<div class="col">
				
				
			</div>
		</div>
<%
		if (no != null) {
			productNo = Integer.parseInt(no);
			Product product = productDao.getProductDetail(productNo);
			List<String> productImageList = productDao.getProductThumbnailImageList(product.getNo());
%>
		<div class="row border mb-5 ms-1 me-1">
			<div class="col m-1">
				<table>
					<tr>
						<td rowspan="2" width="100px">
							<img id="inquiry-image" src="../resources/images/product/<%=product.getNo() %>/thumbnail/<%=productImageList.get(0) %>">
						</td>
						<td><strong><%=product.getName() %></strong></td>
					</tr>
					<tr>
						<td>
<%
			if (product.getDiscountPrice() != 0) {
%>
							<div class="d-flex justify-content-start">
								<div class="text-decoration-line-through me-3"><%=formatter.format(product.getPrice())%>원</div>
								<div><%=formatter.format(product.getDiscountPrice()) %>원</div>
							</div>
<%
			} else {
%>
							<div class="d-flex justify-content-start">
								<div><%=formatter.format(product.getPrice())%>원</div>
							</div>
<%
			}

%>
						</td>
					</tr>		
				</table>
			</div>
		</div>
<%
		} else {
%>
		<div class="row border mb-5 ms-1 me-1">
			<div class="col m-1">
				<form class="row g-3">
					<div class="col-md-4">
						<label for="category" class="form-label">상품 카테고리</label> 
						<select	id="inputState" onchange="categoryProduct(this)" class="form-select">
							<option selected disabled="disabled">선택하세요</option>
<%
	List<ProductCategory> categoryList = productDao.getAllProductCategory();
	for (ProductCategory category : categoryList) {
%>
							<option value="<%=category.getNo() %>"><%=category.getName() %></option>
<%
	}
%>
						</select>
					</div>
				</form>
			</div>
		</div>

<%			
		}
%>
		<div class="row">
			<div class="col">
				<form class="row g-3">
					<div class="col-md-4">
						<label for="category" class="form-label">카테고리</label> <select
							id="inputState" class="form-select">
							<option selected>상품문의</option>
							<option></option>
						</select>
					</div>
					<div class="col-md-8"></div>
					<div class="col-md-6">
						<label for="inputEmail4" class="form-label">제목</label> <input
							type="email" class="form-control" id="inputEmail4">
					</div>
					
					
					<div class="col-md-6">
						<label for="inputPassword4" class="form-label">비밀번호</label> <input
							type="password" class="form-control" id="inputPassword4">
					</div>
					<div class="col-12">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="submit" class="btn btn-primary">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	function categoryProduct() {
		
	}
</script>
</body>
</html>