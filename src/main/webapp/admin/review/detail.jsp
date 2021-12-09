<%@page import="semi.vo.Review2"%>
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
	pageContext.setAttribute("menu", "inquiry");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String tempPageNo = request.getParameter("pageNo");
	int pageNo = 1;
	if (tempPageNo != null) {
		pageNo = Integer.parseInt(tempPageNo);
	}
	
	AdminService service = AdminService.getInstance();
	
	Review2 review = service.getReviewByNo(reviewNo);
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>리뷰 정보</h1>
			</div>
			<div class="col text-end">
				<a href="list.jsp?pageNo=<%=pageNo %>" class="btn btn-secondary">목록</a>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<tbody>
						<tr class="d-flex">
							<th class="col-2">리뷰번호</th>
							<td class="col-4"><%=review.getNo() %></td>
							<th class="col-2">등록날짜</th>
							<td class="col-4"><%=review.toSimpleDate(review.getCreatedDate()) %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">점수</th>
							<td class="col-4"><%=review.getRate() %></td>
							<th class="col-2">작성자</th>
							<td class="col-4"><a href="../user/detail.jsp?userNo=<%=review.getUser().getNo() %>"><%=review.getUser().getName() %></a></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">상품번호</th>
							<td class="col-4"><%=review.getProduct().getNo() %></td>
							<th class="col-2">상품이름</th>
							<td class="col-4"><a href="../product/detail.jsp?productNo=<%=review.getProduct().getNo() %>"><%=review.getProduct().getName() %></a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-12">내용</th>
						</tr>
					</thead>
					<tbody>
						<tr class="d-flex">
							<td class="col-12"><%=review.getContent() %></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>