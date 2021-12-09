<%@page import="java.util.List"%>
<%@page import="semi.vo.Product"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="semi.dao.ProductDao"%>
<%@page import="semi.dao.InquiryDao"%>
<%@page import="semi.dto.InquiryDto"%>
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
<%@ include file="../common/navbar.jsp"%>
<div class="container mb-5 pb-5">    
	<%
	int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	InquiryDao inquiryDao = InquiryDao.getInstance();
	InquiryDto inquiryDto = inquiryDao.getInquiryDtoByInquiryNo(inquiryNo);
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductDetail(inquiryDto.getProductNo());
	DecimalFormat formatter = new DecimalFormat("###,###");
	List<String> productImageList = productDao.getProductThumbnailImageList(product.getNo());
	%>
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
						</div>
<%
}else {
%>
						<div class="d-flex justify-content-start">
							<div><%=formatter.format(product.getPrice())%>원
							</div>
						</div> 
<%
}
%>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<table class="table">
			<colgroup>
				<col width="15%">
				<col width="*">
			</colgroup>
				<tr>
					<td>제목</td>
					<td><%=inquiryDto.getTitle() %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><%=inquiryDto.getUserName().substring(0,1) %>****</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col d-flex justify-content-end">
			<p style="margin: 0px"><strong>작성일</strong><%=inquiryDto.getCreatedDate() %></p>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col">
			<%=inquiryDto.getContent() %>		
		</div>
	</div>
	<form action="delete.jsp" id="password-form">
		<input type="hidden" name="inquiryNo" value="<%=inquiryNo %>">
		<div class="row mt-5 mb-2">
			<div class="col">
				<table class="table">
				<colgroup>
					<col width="15%">
					<col width="*">
				</colgroup>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="password"><span>삭제하려면 비밀번호를 입력하세요.</span></td>
					</tr>
				</table>
	
			</div>
		</div>
		<div class="row">
			<div class="col d-flex justify-content-between">
				<div>
					<a href="list.jsp">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">목록</span>
						</button>
					</a>
				</div>
				<div>
					<div class="me-3">
						<button type="button" class="btn btn-secondary btn-lg" onclick="remove()">
							<span class="fs-6">삭제</span>
						</button>
						<button type="button" class="btn btn-outline-secondary btn-lg" onclick="modify()">
							<span class="fs-6">수정</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="row mt-3 mb-5 pb-5">
		<div class="col">
			<p>답변</p>
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="70%">
					<col width="20%">
				</colgroup>
				<tr>
<%
	List<InquiryDto> replys = inquiryDao.getReplyByInquiryNo(inquiryNo);
	for (InquiryDto reply : replys) {
%>
					<td>관리자</td>
					<td><%=reply.getContent() %></td>
					<td><%=reply.getCreatedDate() %></td>
<%
	}
%>
				</tr>
			</table>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function remove() {
		var passwordForm = document.getElementById("password-form");
		passwordForm.setAttribute("action", "delete.jsp");
		passwordForm.submit();
	}
	function modify() {
		var passwordForm = document.getElementById("password-form");
		passwordForm.setAttribute("action", "modifyform.jsp");
		passwordForm.submit();
	}
</script>
</body>
</html>