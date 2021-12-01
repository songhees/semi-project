<%@page import="vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="service.AdminService"%>
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
<%@ include file="../common/navbar.jsp" %>
<%
	String tempCategoryNo = request.getParameter("categoryNo");
	int categoryNo = 0;

	AdminService service = AdminService.getInstance();
	List<Product> products = List.of();
	if (tempCategoryNo == null) {
		products = service.getAllProducts();
	} else {
		categoryNo = Integer.parseInt(tempCategoryNo);
		products = service.getProductsByCategory(categoryNo);
	}
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>상품목록<%=tempCategoryNo == null ? "" : " - " + service.getCategoryByNo(categoryNo).getName()%></h1>
			</div>
		</div>
		
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr>
							<th><input class="form-check-input" type="checkbox" id="check-all"></th>
							<th>상품번호</th>
							<th>상품이름</th>
							<th>카테고리</th>
							<th>가격</th>
							<th>재고</th>
							<th>판매여부</th>
						</tr>
					</thead>
					<tbody>
<%
	// 판매여부 항목에 표시할 값을 계산한다.
	for (Product product : products) {
		String status = null;
		if (product.getOnSale().equals("Y")) {
			status = "판매중";
			if (product.getTotalStock() < 10) {
				status = "재고부족";
			}
		} else {
			status = "판매중단";
			if (product.getTotalStock() == 0) {
				status = "재고없음";
			}
		}
%>
						<tr>
							<td><input class="form-check-input" type="checkbox" id="check-<%=product.getNo() %>" value="<%=product.getNo() %>"></td>
							<td><%=product.getNo() %></td>
							<td><%=product.getName() %></td>
							<td><a href="list.jsp?categoryNo=<%=product.getCategory().getNo() %>"><%=product.getCategory().getName() %></a></td>
							<td><%=product.getPrice() %></td>		
							<td><%=product.getTotalStock() %></td>				
							<td><%=status %></td>						
						</tr>
<%
	}
%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>