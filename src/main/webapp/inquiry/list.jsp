<%@page import="semi.vo.Pagination"%>
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
String inquiryCategory = request.getParameter("inquiryCategoryNo");
int inquiryCategoryNo = 0;

if (inquiryCategory != null) {
	inquiryCategoryNo = Integer.parseInt(inquiryCategory);
} else {
	inquiryCategoryNo = 1000;
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
				<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="/semi-project/index.jsp" style="text-decoration: none; color: gray;">Home</a></li>
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
					<a href="list.jsp?inquiryCategoryNo=1000">
						<button type="button" class="btn btn-secondary btn-lg">
							<span class="fs-6">Q&amp;A전체보기</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategoryNo=1001">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">상품문의</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategoryNo=1002">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">배송문의</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategoryNo=1003">
						<button type="button" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">교환/반품/취소문의</span>
						</button>
					</a>
				</div>
				<div class="me-3">
					<a href="list.jsp?inquiryCategoryNo=1004">
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
String inquiryPageNo = request.getParameter("inquiryPageNo");
InquiryDao inquiryDao = InquiryDao.getInstance();
ProductDao productDao = ProductDao.getInstance();
List<InquiryDto> inquiryDtoList = new ArrayList<>();
Pagination inquiryPagination = null;

if (inquiryCategoryNo == 1000) {
	int inquiryTotalRecords = inquiryDao.getTotalRecords();
	inquiryPagination = new Pagination(inquiryPageNo, inquiryTotalRecords, 10, 10);
	inquiryDtoList = inquiryDao.getAllInquiryDtoList(inquiryPagination.getBegin(), inquiryPagination.getEnd());
} else {
	int inquiryTotalRecords = inquiryDao.getTotalRecordsByCategoryNo(inquiryCategoryNo);
	inquiryPagination = new Pagination(inquiryPageNo, inquiryTotalRecords, 10, 10);
	inquiryDtoList = inquiryDao.getInquiryDtoListByCategoryNo(inquiryCategoryNo, inquiryPagination.getBegin(), inquiryPagination.getEnd());
}

for (InquiryDto inquiryDto : inquiryDtoList) {

%>
							<tr>
								<td><%=inquiryDto.getRn() %></td>
<%
	if (inquiryDto.getCategoryName() == null) {
		InquiryDto adminInquiryDto = inquiryDao.getInquiryDtoByInquiryNo(inquiryDto.getInquiryNo());
%>
								<td></td>
								<td><%=adminInquiryDto.getCategoryName() %></td>
								<td class="text-start"><a style="text-decoration: none; color: black;" href="../inquiry/passwordcheckform.jsp?inquiryNo=<%=inquiryDto.getInquiryNo() %>">└ <%=adminInquiryDto.getTitle() %></a></td>
								<td></td>
<%
	} else {
		List<String> thumbnailImageList = productDao.getProductThumbnailImageList(inquiryDto.getProductNo());
		if (!thumbnailImageList.isEmpty()) {
%>
								<td><a href="../product/detail.jsp?no=<%=inquiryDto.getProductNo() %>">
								<img id="product-image" src="../resources/images/product/<%=inquiryDto.getProductNo()%>/thumbnail/<%=thumbnailImageList.get(0) %>" alt="productImage">
								</a></td>
<%
		} else {
%>			
								<td></td>
<%
		}
%>
								<td><%=inquiryDto.getCategoryName() %></td>
								<td class="text-start"><a style="text-decoration: none; color: black;" href="../inquiry/passwordcheckform.jsp?inquiryNo=<%=inquiryDto.getInquiryNo() %>"><%=inquiryDto.getTitle() %></a></td>
								<td><%=inquiryDto.getUserName().substring(0,1) %>****</td>
<%
	}
%>
								<td><%=inquiryDto.getCreatedDate() %></td>
							</tr>
<%
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
	<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!inquiryPagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?inquiryCategoryNo=<%=inquiryCategoryNo %>&inquiryPageNo=<%=inquiryPagination.getPrevPage()%>" >이전</a></li>
<%
// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
for (int inquiryNum = inquiryPagination.getBeginPage(); inquiryNum <= inquiryPagination.getEndPage(); inquiryNum++) {
%>					
				<li class="page-item <%=inquiryPagination.getPageNo() == inquiryNum ? "active" : "" %>"><a class="page-link" href="list.jsp?inquiryCategoryNo=<%=inquiryCategoryNo %>&inquiryPageNo=<%=inquiryNum%>"><%=inquiryNum %></a></li>
<%
}
%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!inquiryPagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?inquiryCategoryNo=<%=inquiryCategoryNo %>&inquiryPageNo=<%=inquiryPagination.getNextPage()%>" >다음</a></li>
				</ul>
			</nav>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>