<%@page import="semi.vo.InquiryReply"%>
<%@page import="semi.vo.Inquiry"%>
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
	pageContext.setAttribute("menu", "inquiry");
	pageContext.setAttribute("dropdownMenu", "inquiry-list");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	String pageNo = request.getParameter("pageNo");
	
	AdminService service = AdminService.getInstance();
	
	int totalRecords = 0;        
	Pagination pagination = null; 
	List<Inquiry> inquiries = List.of();
	totalRecords = service.getTotalInquiryRecords();
	pagination = new Pagination(pageNo, totalRecords,5 ,5);
	inquiries = service.getInquiryList(pagination.getBegin(), pagination.getEnd());	
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>문의 목록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-1">문의번호</th>
							<th class="col-1">카테고리</th>
							<th class="col-3">상품이름</th>
							<th class="col-4">문의제목</th>
							<th class="col-1">작성자</th>
							<th class="col-2">등록날짜</th>
						</tr>
					</thead>
					<tbody>
<% 
	if (inquiries.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="text-center" colspan="6">문의정보가 존재하지 않습니다.</td>
						</tr>
<%
	} else {
		for (Inquiry inquiry : inquiries) {
%>
						<tr class="d-flex">
							<td class="col-1"><%=inquiry.getNo() %></td>
							<td class="col-1"><%=inquiry.getCategory().getName() %></td>
							<td class="col-3"><a href="../product/detail.jsp?productNo=<%=inquiry.getProduct().getNo() %>"><%=inquiry.getProduct().getName() %></a></td>
							<td class="col-4"><a href="detail.jsp?inquiryNo=<%=inquiry.getNo() %>&pageNo=<%=pagination.getPageNo() %>"><%=inquiry.getTitle() %></a></td>
							<td class="col-1"><a href="../user/detail.jsp?userNo=<%=inquiry.getUser().getNo() %>"><%=inquiry.getUser().getId() %></a></td>
							<td class="col-2"><%=inquiry.toSimpleDate(inquiry.getCreatedDate()) %></td>
						</tr>
<%			
			InquiryReply reply = service.getReplyByInquiryNo(inquiry.getNo());
			if (reply != null) {
%>
						<tr class="d-flex">
							<td class="col-5"></td>
							<td class="col-4"><a href="detail.jsp?inquiryNo=<%=inquiry.getNo() %>&pageNo=<%=pagination.getPageNo() %>">Re: <%=inquiry.getTitle() %></a></td>
							<td class="col-1"><%=reply.getWriter().getName() %></td>
							<td class="col-2"><%=reply.toSimpleDate(reply.getCreatedDate()) %></td>
						</tr>
<% 
			}
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