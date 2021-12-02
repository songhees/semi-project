<%@page import="semi.vo.Pagination"%>
<%@page import="semi.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="semi.service.AdminService"%>
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
	// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
	pageContext.setAttribute("menu", "product");
	pageContext.setAttribute("dropdownMenu", "list");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	// list.jsp로 요청되는 경우와 list.jsp?categoryNo=1001으로 요청되는 2가지 요청을 처리하는 JSP다.
	String tempCategoryNo = request.getParameter("categoryNo");
	// 요청파라미터에서 pageNo값을 조회한다.
	// 요청파라미터에 pageNo값이 존재하지 않으면 Pagination객체에서 1페이지로 설정한다.
	String pageNo = request.getParameter("pageNo");	
	
	// 관리자 모드 관련 기능을 제공하는 AdminService객체를 획득한다.
	AdminService service = AdminService.getInstance();
	
	int categoryNo = 0;
	int totalRecords = 0;         // 총 데이터 개수를 담을 변수 선언
	Pagination pagination = null; // 페이징 처리 필요한 값을 계산하는 Paginatition객체를 담을 Pagination타입 변수 선언
	List<Product> products = List.of();
	if (tempCategoryNo == null) { // list.jsp 요청인 경우
		totalRecords = service.getTotalRecords();	
		pagination = new Pagination(pageNo, totalRecords);
		// 현재 페이지번호에 해당하는 게시글 목록을 조회한다.
		products = service.getProductList(pagination.getBegin(), pagination.getEnd());	
	} else {					  // list.jsp?categoryNo=카테고리번호 요청인 경우
		categoryNo = Integer.parseInt(tempCategoryNo);
		totalRecords = service.getTotalRecordsByCategory(categoryNo);
		pagination = new Pagination(pageNo, totalRecords);
		// 현재 페이지번호와 카테고리번호에 해당하는 게시글 목록을 조회한다.
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
		// 판매여부 항목에 표시할 값을 계산한다.
		// String status = null;
		// if (product.getOnSale().equals("Y")) {
		// 	status = "판매중";
		//	if (product.getTotalStock() < 10) {
		//		status = "재고부족";
		//	}
		//} else {
		//	status = "판매중단";
		//	if (product.getTotalStock() == 0) {
		//		status = "재고없음";
		//	}
		//}
%>
						<tr class="d-flex">	
							<td class="col-1"><%=product.getNo() %></td>
							<td class="col-5"><a href="detail.jsp?productNo=<%=product.getNo() %>&pageNo=<%=pagination.getPageNo() %>"><%=product.getName() %></a> </td>
							<td class="col-2"><a href="list.jsp?categoryNo=<%=product.getCategory().getNo() %>"><%=product.getCategory().getName() %></a></td>
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