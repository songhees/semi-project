<%@page import="semi.vo.InquiryReply"%>
<%@page import="semi.vo.Inquiry"%>
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
	int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	String tempPageNo = request.getParameter("pageNo");
	int pageNo = 1;
	if (tempPageNo != null) {
		pageNo = Integer.parseInt(tempPageNo);
	}
	
	AdminService service = AdminService.getInstance();
	
	Inquiry inquiry = service.getInquiryByNo(inquiryNo);
	InquiryReply reply = service.getReplyByInquiryNo(inquiryNo);
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>문의 정보</h1>
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
							<th class="col-2">문의번호</th>
							<td class="col-4"><%=inquiry.getNo() %></td>
							<th class="col-2">등록날짜</th>
							<td class="col-4"><%=inquiry.toSimpleDate(inquiry.getCreatedDate()) %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">카테고리</th>
							<td class="col-4"><%=inquiry.getCategory().getName() %></td>
							<th class="col-2">작성자</th>
							<td class="col-4"><a href="../user/detail.jsp?userNo=<%=inquiry.getUser().getNo() %>"><%=inquiry.getUser().getId() %></a></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">제목</th>
							<td class="col-4"><%=inquiry.getTitle() %></td>
							<th class="col-2">상품이름</th>
							<td class="col-4"><a href="../product/detail.jsp?productNo=<%=inquiry.getProduct().getNo() %>"><%=inquiry.getProduct().getName() %></a></td>
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
							<td class="col-12"><%=inquiry.getContent() %></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col">

<%
	if (reply == null) {
%>
				<form class="border bg-light p-3" method="post" action="reply.jsp">
					<input type="hidden" name="inquiryNo" value="<%=inquiryNo %>">
					<input type="hidden" name="pageNo" value="<%=pageNo %>">
 					<div class="mb-3">
 						<input type="text" class="form-control" value="<%=loginUserInfo.getName() %>" disabled>
					</div>
					<div class="mb-3">
						<textarea class="form-control" name="content" rows="5"></textarea>
					</div>
					<div class="col-12 text-end">
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
				</form>
<%
	} else {
%>
				<form class="border bg-light p-3" method="post" action="update.jsp">
					<input type="hidden" name="inquiryNo" value="<%=inquiryNo %>">
					<input type="hidden" name="replyNo" value="<%=reply.getNo() %>">
					<input type="hidden" name="pageNo" value="<%=pageNo %>">
					<div class="row g-2 mb-2">
						<div class="col-10">
 							<input type="text" class="form-control col-6" value="<%=reply.getWriter().getName() %>" disabled>
 						</div>
 						<div class="col-2">
 							<input type="text" class="form-control col-6" value="<%=reply.toSimpleDate(reply.getCreatedDate()) %>" disabled>
						</div>
					</div>
					<div class="row g-2 mb-2">
						<div class="col-12"> 
							<textarea class="form-control" name="content" rows="5"><%=reply.getContent() %></textarea>
						</div>
					</div>
					<div class="row g-2 mb-2">
						<div class="col-12 text-end">
							<button type="submit" class="btn btn-warning">수정</button>
							<a href="delete.jsp?inquiryNo=<%=inquiryNo %>&replyNo=<%=reply.getNo() %>&pageNo=<%=pageNo %>" class="btn btn-danger">삭제</a>
						</div>
					</div>
				</form>
<%
	}
%>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>