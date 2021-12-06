<%@page import="java.util.ArrayList"%>
<%@page import="semi.dao.ProductDao"%>
<%@page import="semi.dto.InquiryDto"%>
<%@page import="java.util.List"%>
<%@page import="semi.dao.InquiryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<%
String inquiryCategory = request.getParameter("inquiryCategory");

if (inquiryCategory == null) {
	inquiryCategory = "전체보기";
}
%>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>Q&amp;A - 빈스데이</title>
</head>
<style>
#button-list button {
	width: 230px;
	height: 55px;
}
#product-image {
	width: 46px;
	height: 46px;
}
#inquiry-table { width:100%; } 
#inquiry-table td {
    height: 65px;
    padding-top: 0px;
    padding-bottom: 0px;
    vertical-align: middle;
}
</style>
<body>
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
	<div class="row pt-3">
		<div class="col">
			<div id="button-list" class="d-flex justify-content-center">
				<div class="me-3">
					<a href="list.jsp?inquiryCategory=전체보기">
						<button type="button" class="btn btn-secondary btn-lg">
							<span class="fs-6">Q&amp;A전체보기</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategory=상품문의">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">상품문의</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategory=배송문의">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">배송문의</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategory=교환/반품/취소문의">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">교환/반품/취소문의</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategory=기타문의">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">기타문의</span>
						</button>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="d-flex justify-content-center mt-5 mb-4">
				<table class="table text-center" id="inquiry-table">
					<colgroup>
						<col width="5%">
						<col width="10%">
						<col width="16%">
						<col width="52%">
						<col width="8%">
						<col width="10%">
					</colgroup>		
					<thead class="table-light">
						<tr>
							<th>번호</th>
							<th>상품정보</th>
							<th>카테고리</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
<%
ProductDao productDao = ProductDao.getInstance();
InquiryDao inquiryDao = InquiryDao.getInstance();
List<InquiryDto> inquiryDtoList = new ArrayList<>();
if (inquiryCategory.equals("전체보기")) {
	inquiryDtoList = inquiryDao.getAllInquiryDtoList();
} else {
	inquiryDtoList = inquiryDao.getInquiryDtoListByCategory(inquiryCategory);
}
int inquiryRowNum = 0;
for (InquiryDto inquiryDto : inquiryDtoList) {
	if (inquiryDto.getInquiryDeleted().equals("N")) {
		inquiryRowNum += 1;
	} else {
		continue;
	}
	if ((inquiryDto.getReplyNo() != 0) && (inquiryDto.getReplyDeleted().equals("N"))) {
		inquiryRowNum += 1;
	}
}
for (InquiryDto inquiryDto : inquiryDtoList) {
	if (inquiryDto.getInquiryDeleted().equals("N")) {
		List<String> thumbnailImageList = productDao.getProductThumbnailImageList(inquiryDto.getProductNo());
%>
						<tr>
							<td><%=inquiryRowNum %></td>
							<td>
<%
		if (!thumbnailImageList.isEmpty()) {
%>
								<a href="product/detail.jsp?no=<%=inquiryDto.getProductNo() %>">
								<img id="product-image" src="../resources/images/product/<%=inquiryDto.getProductNo()%>/thumbnail/<%=thumbnailImageList.get(0) %>" alt="productImage">
								</a>
<%
		}
%>

							</td>
							<td><%=inquiryDto.getCategoryName() %></td>
							<td class="text-start"><a href="passwordcheckform.jsp?inquiryNo=<%=inquiryDto.getInquiryNo()%>"><%=inquiryDto.getTitle() %></a></td>
							<td><%=inquiryDto.getUserName().substring(0,1) %>****</td>
							<td><%=inquiryDto.getInquiryCreatedDate() %></td>
						</tr>
<%
		inquiryRowNum -= 1;
	} else {
		continue;
	}
	if ((inquiryDto.getReplyNo() != 0) && (inquiryDto.getReplyDeleted().equals("N"))) {
%>
						<tr>
							<td><%=inquiryRowNum %></td>
							<td></td>
							<td><%=inquiryDto.getCategoryName() %></td>
							<td class="text-start">└ <%=inquiryDto.getTitle() %></td>
							<td></td>
							<td><%=inquiryDto.getReplyCreatedDate() %></td>
						</tr>
<%
		inquiryRowNum -= 1;
	}
}
%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="d-flex justify-content-end">
				<a href="registerform.jsp">
					<button type="button" class="btn btn-secondary btn-lg">
						<span class="fs-6">글쓰기</span>
					</button>
				</a>
			</div>
		</div>
	</div>
			
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>