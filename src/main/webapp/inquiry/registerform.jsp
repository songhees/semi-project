<%@page import="semi.dao.InquiryDao"%>
<%@page import="semi.vo.InquiryCategory"%>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
					<nav style="-bs-breadcrumb-divider: '&gt;';"
						aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="/semi-prodject/index.jsp"
								style="text-decoration: none; color: gray;">Home</a></li>
							<li class="breadcrumb-item">BOARD</li>
							<li class="breadcrumb-item active" aria-current="page">Q&amp;A</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
		<div class="row mt-5 pt-5 mb-3 pb-5">
			<div class="col">
				<h4 align="center">
					<strong>Q&amp;A</strong>
				</h4>
				<h6 align="center">상품 Q&amp;A입니다.</h6>
			</div>
		</div>
		<form class="row g-3" action="register.jsp">
			<%
			// productNo가 넘어왔는지 안왔는지
			if (no != null) {
				productNo = Integer.parseInt(no);
				Product product = productDao.getProductDetail(productNo);
				List<String> productImageList = productDao.getProductThumbnailImageList(product.getNo());
			%>
			<div class="row border mb-5 ms-1 me-1">
				<div class="col m-2">
					<input type="hidden" value="<%=product.getNo() %>" name="productNo">
					<table>
						<tr>
							<td rowspan="2" width="100px"><img id="inquiry-image"
								src="../resources/images/product/<%=product.getNo()%>/thumbnail/<%=productImageList.get(0)%>">
							</td>
							<td><strong><%=product.getName()%></strong></td>
						</tr>
						<tr>
							<td>
								<%
								if (product.getDiscountPrice() != 0) {
								%>
								<div class="d-flex justify-content-start">
									<div class="text-decoration-line-through me-3"><%=formatter.format(product.getPrice())%>원
									</div>
									<div><%=formatter.format(product.getDiscountPrice())%>원
									</div>
								</div> <%
 } else {
 %>
								<div class="d-flex justify-content-start">
									<div><%=formatter.format(product.getPrice())%>원
									</div>
								</div> <%
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
					<div class="col-md-4 mb-1">
						<label for="product-category" class="form-label">상품 카테고리</label> <select
							id="product-category" onchange="categoryProduct()"
							class="form-select">
							<option selected disabled="disabled">선택하세요</option>
							<%
							List<ProductCategory> categoryList = productDao.getAllProductCategory();
							for (ProductCategory category : categoryList) {
							%>
							<option value="<%=category.getNo()%>"><%=category.getName()%></option>
							<%
							}
							%>
						</select>
					</div>
					<%
					for (int i = 1001; i <= 1006; i++) {
					%>
					<div class="col-md-12" id="category-<%=i%>" style="display: none">
						<%
						List<Product> productList = productDao.getProductListByCategory(i);
						for (Product product : productList) {
							List<String> thumbnails = productDao.getProductThumbnailImageList(product.getNo());
						%>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="productNo"
								id="product-select" value="<%=product.getNo()%>"> <label
								class="form-check-label" for="product-select"> <%
 if (!thumbnails.isEmpty()) {
 %> <img id="inquiry-image"
								src="../resources/images/product/<%=product.getNo()%>/thumbnail/<%=thumbnails.get(0)%>"
								alt="productImg"> <%
 }
 %> <%=product.getName()%>
							</label>
						</div>
						<%
						}
						%>
					</div>
					<%
					}
					%>
				</div>
			</div>

			<%
			}
			%>
			<div class="row">
				<div class="col">
					<div class="row g-3">
						<div class="col-md-4">
							<label for="category" class="form-label">문의 카테고리</label> <select name="inquiryCategory"
								id="inputState" class="form-select">
								<option selected disabled="disabled">선택해주세요.</option>
								<%
								InquiryDao inquiryDao = InquiryDao.getInstance();
								List<InquiryCategory> inquiryCategoryList = inquiryDao.getInquiryCategoryList();
								for (InquiryCategory inquiryCategory : inquiryCategoryList) {
									System.out.println(inquiryCategory.getName());
								%>
								<option value="<%=inquiryCategory.getNo()%>"><%=inquiryCategory.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="col-md-8"></div>
						<div class="col-md-6">
							<label for="title" class="form-label">제목</label> <input
								type="text" class="form-control" id="title" name="title">
						</div>
						<div class="col-md-6">
							<label for="password" class="form-label">비밀번호</label> <input
								type="password" class="form-control" id="password" name="password">
						</div>
						<div>
							<div class="form-floating">
								<textarea class="form-control" placeholder="문의글을 작성해주세요."
									name="content" id="Textarea" style="height: 400px"></textarea>
								<label for="Textarea">문의글을 작성해주세요.</label>
							</div>
						</div>
						<div class="col-12 d-flex justify-content-end mb-5 pb-5">
							<button type="submit" class="btn btn-secondary btn-lg me-1">등록</button>
							<a href="list.jsp"><button type="button"
									class="btn btn-outline-secondary btn-lg">취소</button></a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function categoryProduct() {
			var categoryEl = document.getElementById("product-category");

			var category1001 = document.getElementById("category-1001");
			var category1002 = document.getElementById("category-1002");
			var category1003 = document.getElementById("category-1003");
			var category1004 = document.getElementById("category-1004");
			var category1005 = document.getElementById("category-1005");
			var category1006 = document.getElementById("category-1006");

			category1001.setAttribute("style", "display: none");
			category1002.setAttribute("style", "display: none");
			category1003.setAttribute("style", "display: none");
			category1004.setAttribute("style", "display: none");
			category1005.setAttribute("style", "display: none");
			category1006.setAttribute("style", "display: none");

			if (categoryEl.value === "1001") {
				category1001.setAttribute("style", "display: visible");
			} else if (categoryEl.value === "1002") {
				category1002.setAttribute("style", "display: visible");
			} else if (categoryEl.value === "1003") {
				category1003.setAttribute("style", "display: visible");
			} else if (categoryEl.value === "1004") {
				category1004.setAttribute("style", "display: visible");
			} else if (categoryEl.value === "1005") {
				category1005.setAttribute("style", "display: visible");
			} else if (categoryEl.value === "1006") {
				category1006.setAttribute("style", "display: visible");
			}
		}
	</script>
</body>
</html>