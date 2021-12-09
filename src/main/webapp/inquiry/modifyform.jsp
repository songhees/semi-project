<%@page import="semi.dto.InquiryDto"%>
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
	int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	InquiryDao inquiryDao = InquiryDao.getInstance();
	InquiryDto inquiryDto = inquiryDao.getInquiryDtoByInquiryNo(inquiryNo);
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductDetail(inquiryDto.getProductNo());
	List<String> productImageList = productDao.getProductThumbnailImageList(product.getNo());
	DecimalFormat formatter = new DecimalFormat("###,###");
	%>
	<%@ include file="../common/navbar.jsp"%>
	<div class="container">
		<div class="row mb-5">
			<div class="col">
				<div class="d-flex justify-content-end">
					<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a
								href="/semi-project/index.jsp"
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
		<form class="row g-3" action="modify.jsp">
			<input name="inquiryNo" value="<%=inquiryNo %>" type="hidden">
			<div class="row border mb-5 ms-1 me-1">
				<div class="col m-2">
					<table>
						<tr>
<%
if (!productImageList.isEmpty()) {
%>
							<td rowspan="2" width="100px"><img id="inquiry-image"
								src="../resources/images/product/<%=product.getNo()%>/thumbnail/<%=productImageList.get(0)%>">
							</td>
<%
} else {
%>
							<td></td>
<%
}
%>
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
			<div class="row">
				<div class="col">
					<div class="row g-3">
						<div class="col-md-4">
							<label for="category" class="form-label">문의 카테고리</label> <select name="inquiryCategory"
								id="inputState" class="form-select">
								<option disabled="disabled">선택해주세요.</option>
								<%
								List<InquiryCategory> inquiryCategoryList = inquiryDao.getInquiryCategoryList();
								for (InquiryCategory inquiryCategory : inquiryCategoryList) {
									System.out.println(inquiryCategory.getName());
								%>
								<option value="<%=inquiryCategory.getNo()%>"<%=inquiryCategory.getNo()==inquiryDto.getInquiryNo() ? "selected" : "" %>><%=inquiryCategory.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
						<div class="col-md-8"></div>
						<div class="col-md-6">
							<label for="title" class="form-label">제목</label> <input
								type="text" class="form-control" id="title" name="title" value="<%=inquiryDto.getTitle() %>">
						</div>
						<div>
							<div class="form-floating">
								<textarea class="form-control" placeholder="문의글을 작성해주세요."
									name="content" id="Textarea" style="height: 400px"><%=inquiryDto.getContent() %></textarea>
								<label for="Textarea">문의글을 작성해주세요.</label>
							</div>
						</div>
						<div class="col-12 d-flex justify-content-end mb-5 pb-5">
							<button type="submit" class="btn btn-secondary btn-lg me-1">등록</button>
							<a href="detail.jsp?inquiryNo=<%=inquiryNo %>"><button type="button"
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
	</script>
</body>
</html>