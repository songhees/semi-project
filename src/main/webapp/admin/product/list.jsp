<%@page import="semi.vo.Pagination"%>
<%@page import="semi.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="semi.admin.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>상품 목록</title>
</head>
<body>
<%
	pageContext.setAttribute("menu", "product");
	pageContext.setAttribute("dropdownMenu", "list");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	String tempCategoryNo = request.getParameter("categoryNo");
	String pageNo = request.getParameter("pageNo");		
	
	AdminService service = AdminService.getInstance();
	
	int categoryNo = 0;
	int totalRecords = 0;
	Pagination pagination = null;
	List<Product> products = List.of();
	if (tempCategoryNo == null) {
		totalRecords = service.getTotalRecords();	
		pagination = new Pagination(pageNo, totalRecords, 5, 5);
		products = service.getProductList(pagination.getBegin(), pagination.getEnd());	
	} else {
		categoryNo = Integer.parseInt(tempCategoryNo);
		totalRecords = service.getTotalRecordsByCategory(categoryNo);
		pagination = new Pagination(pageNo, totalRecords, 5, 5);
		products = service.getProductListByCategory(pagination.getBegin(), pagination.getEnd(), categoryNo);
	}	
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>상품 목록<%=categoryNo == 0 ? "" : " - " + service.getCategoryByNo(categoryNo).getName()%></h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-1">상품번호</th>
							<th class="col-5">상품이름</th>
							<th class="col-2">카테고리</th>
							<th class="col-1">가격</th>
							<th class="col-1">재고</th>
							<th class="col-2">판매여부</th>
						</tr>
					</thead>
					<tbody>
<% 
	if (products.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="text-center" colspan="6">상품이 존재하지 않습니다.</td>
						</tr>
<%
	} else {
		for (Product product : products) {
%>
						<tr class="d-flex">	
							<td class="col-1"><%=product.getNo() %></td>
							<td class="col-5"><a href="detail.jsp?productNo=<%=product.getNo() %>&pageNo=<%=pagination.getPageNo() %>"><%=product.getName() %></a> </td>
							<td class="col-2"><a href="list.jsp?categoryNo=<%=product.getProductCategory().getNo() %>"><%=product.getProductCategory().getName() %></a></td>
							<td class="col-1"><%=product.getPrice() %></td>		
							<td class="col-1"><%=product.getTotalStock() %></td>				
							<td class="col-2"><%=product.getOnSale().equals("Y") ? "판매중" : "판매중단" %></td>						
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
					 	<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%><%=tempCategoryNo == null ? "" : "&categoryNo=" + categoryNo %>" >이전</a></li>
<%
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>
						<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%><%=tempCategoryNo == null ? "" : "&categoryNo=" + categoryNo %>"><%=num %></a></li>
<%
	}
%>
					 	<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%><%=tempCategoryNo == null ? "" : "&categoryNo=" + categoryNo %>" >다음</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>