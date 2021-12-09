<%@page import="semi.vo.Review2"%>
<%@page import="java.util.List"%>
<%@page import="semi.vo.Pagination"%>
<%@page import="semi.admin.service.AdminService"%>
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
	pageContext.setAttribute("menu", "review");
	pageContext.setAttribute("dropdownMenu", "review-list");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	String pageNo = request.getParameter("pageNo");
	
	AdminService service = AdminService.getInstance();
	
	int totalRecords = 0;        
	Pagination pagination = null; 
	List<Review2> reviews = List.of();
	totalRecords = service.getTotalReviewRecords();
	pagination = new Pagination(pageNo, totalRecords, 5, 5);
	reviews = service.getReviewList(pagination.getBegin(), pagination.getEnd());	
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>리뷰 목록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-1">리뷰번호</th>
							<th class="col-3">상품이름</th>
							<th class="col-2">점수</th>
							<th class="col-3">내용</th>
							<th class="col-1">작성자</th>
							<th class="col-2">등록날짜</th>
						</tr>
					</thead>
					<tbody>
<% 
	if (reviews.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="col-12 text-center" colspan="6">리뷰정보가 존재하지 않습니다.</td>
						</tr>
<%
	} else {
		for (Review2 review : reviews) {
			String rating = null;
			if (review.getRate() == 5) {
				rating = "★★★★★";
			} else if (review.getRate() == 4) {
				rating = "★★★★☆";
			} else if (review.getRate() == 3) {
				rating = "★★★☆☆";
			} else if (review.getRate() == 2) {
				rating = "★★☆☆☆";
			} else if (review.getRate() == 1) {
				rating = "★☆☆☆☆";
			}
			
			String content = null;
			if (review.getContent().length() > 30) {
				content = review.getContent().substring(0, 30);
				content += "...";
			} else {
				content = review.getContent();
			}
%>
						<tr class="d-flex">
							<td class="col-1"><%=review.getNo() %></td>
							<td class="col-3"><a href="../product/detail.jsp?productNo=<%=review.getProduct().getNo() %>"><%=review.getProduct().getName() %></a></td>
							<td class="col-2"><%=rating %></td>
							<td class="col-3"><a href="../review/detail.jsp?reviewNo=<%=review.getNo() %>&pageNo=<%=pagination.getPageNo() %>"><%=content %></a></td>
							<td class="col-1"><a href="../review/detail.jsp?userNo=<%=review.getUser().getNo() %>"><%=review.getUser().getName() %></a></td>
							<td class="col-2"><%=review.toSimpleDate(review.getCreatedDate()) %></td>
						</tr>
<%
		}
	}
%>
					</tbody>
				</table>	
			</div>
		</div>
		<div class="row">
			<div class="col">
				<nav>
					<ul class="pagination justify-content-center">
						<!-- 
							Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
							Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 	-->
					 	<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
	//Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
						<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%>"><%=num %></a></li>
<%
	}
%>
						<!-- 
							Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
							Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 	-->
					 	<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>" >다음</a></li>
					</ul>
				</nav>
			</div>
		</div>
		
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>