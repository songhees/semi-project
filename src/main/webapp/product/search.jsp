<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="semi.vo.Product"%>
<%@page import="semi.vo.Pagination"%>
<%@page import="semi.criteria.ProductCriteria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="semi.dao.ProductItemDao"%>
<%@page import="semi.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<title>빈스데이</title>
	<style type="text/css">
		.container {
			min-width: 960px;
		}
	</style>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
	<%
		//요청 파라미터의 값들을 조회한다.
		String pageNo = StringUtils.defaultString(request.getParameter("pageNo"), "1");
		String category = StringUtils.defaultString(request.getParameter("category"), "");
		String orderBy = StringUtils.defaultString(request.getParameter("orderBy"), "");
		
		// category가 비어있을 경우 초기값으로 TOP을 넣어준다.
		if (category == null) {
			category = "TOTAL";
		}
		// category가 SHIRT일 경우 SHIRT&BLOUSE로 바꿔준다.
		if ("SHIRT".equals(category)) {
			category = "SHIRT&BLOUSE";
		}
		
		ProductDao productDao = ProductDao.getInstance();
		ProductItemDao productItemDao = ProductItemDao.getInstance();
		List<Product> products = new ArrayList<Product>();
		ProductCriteria productCriteria = new ProductCriteria();
			
		productCriteria.setCategory(category);
		productCriteria.setOrderBy(orderBy);
		
		int totalRecords = productDao.getProductTotalRecords(productCriteria);
		// TODO 테스트용 프린트
		System.out.println("totalRecords: " + totalRecords);
		Pagination pagination = new Pagination(pageNo, totalRecords, 8, 5);
		int begin = pagination.getBegin();
		int end = pagination.getEnd();
		
		productCriteria.setBegin(begin);
		productCriteria.setEnd(end);
		
		if ("전체상품".equals(category)) {
			products = productDao.getAllProductList(productCriteria);
		} else {
		// TODO 카테고리가 알맞은지 먼저 확인하고, 해당하는 상품 리스트를 가져온다.
			products = productDao.getProductListBycategory(productCriteria);
		}
	%>
<div class="container">    
	<div class="row">
		<div class="col m-5 text-center">
			<h5><strong>SEARCH</strong></h5>
		</div>
	</div>
	<div class="row justify-content-center border p-3">
		<div class="col-6 mt-5">
			<form id="form-search" method="get" action="search.jsp">
				<input type="hidden" id="page-field" name="pageNo" value="1">
				<div class="row mb-2">
					<label class="col-2 col-form-label" style="font-size: 0.75em;">
						<strong>상품분류</strong>
					</label>
					<div class="col-10">
						<select class="form-select" name="category" style="font-size: 0.75em;">
  							<option value="" selected>상품분류 선택</option>
							<option value="NEW">NEW</option>
							<option value="OUTER">OUTER</option>
							<option value="TOP">TOP</option>
							<option value="SHIRT">SHIRT&amp;BLOUSE</option>
							<option value="DRESS">DRESS</option>
							<option value="SKIRT">SKIRT</option>
							<option value="PANTS">PANTS</option>
							<option value="전체상품">전체상품</option>
						</select>
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-2 col-form-label" style="font-size: 0.75em;">
						<strong>상품명</strong>
					</label>
					<div class="col-10">
						<input type="text" name="nameKeyword" class="form-control" style="font-size: 0.75em;">
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-2 col-form-label" style="font-size: 0.75em;">
						<strong>판매가격대</strong>
					</label>
					<div class="col-10">
						<input type="number" name="priceRangeFrom" class="form-control" style="font-size: 0.75em; width: 47%; display: inline;">
						<label style="font-size: 0.75em; width: 6%; display: inline;">~</label>
						<input type="number" name="priceRangeTo" class="form-control" style="font-size: 0.75em;  width: 47%; display: inline;">
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-2 col-form-label" style="font-size: 0.75em;">
						<strong>검색정렬기준</strong>
					</label>
					<div class="col-10">
						<select class="form-select" name="orderBy" style="font-size: 0.75em;">
  							<option value="" selected>::: 기준선택 :::</option>
							<option value="신상품">신상품</option>
							<option value="낮은가격">낮은가격</option>
							<option value="높은가격">높은가격</option>
							<option value="인기상품">인기상품</option>
							<option value="사용후기">사용후기</option>
						</select>
					</div>
				</div>
				<div class="row mb-2 mt-4">
					<div class="d-grid">
						<button class="btn btn-secondary" type="button" onclick="searchProducts(1)">검색</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="col d-flex justify-content-start">
			<p style="font-size: 0.8em;">TOTAL <strong><%=totalRecords %></strong> PRODUCT</p>
		</div>
		<div class="col d-flex justify-content-end">
			<a class="orderBy" href="list.jsp?category=<%=category %>&orderBy=신상품">
				<span><%="신상품".equals(orderBy) ? "<strong>" : "" %>신상품<%="신상품".equals(orderBy) ? "</strong>" : "" %></span>
			</a>
			<span class="px-3">|</span>
			<a class="orderBy" href="list.jsp?category=<%=category %>&orderBy=낮은가격">
				<span><%="낮은가격".equals(orderBy) ? "<strong>" : "" %>낮은가격<%="낮은가격".equals(orderBy) ? "</strong>" : "" %></span>
			</a>
			<span class="px-3">|</span>
			<a class="orderBy" href="list.jsp?category=<%=category %>&orderBy=높은가격">
				<span><%="높은가격".equals(orderBy) ? "<strong>" : "" %>높은가격<%="높은가격".equals(orderBy) ? "</strong>" : "" %></span>
			</a>
			<span class="px-3">|</span>
			<a class="orderBy" href="list.jsp?category=<%=category %>&orderBy=인기상품">
				<span><%="인기상품".equals(orderBy) ? "<strong>" : "" %>인기상품<%="인기상품".equals(orderBy) ? "</strong>" : "" %></span>
			</a>
			<span class="px-3">|</span>
			<a class="orderBy" href="list.jsp?category=<%=category %>&orderBy=상품후기">
				<span><%="상품후기".equals(orderBy) ? "<strong>" : "" %>상품후기<%="상품후기".equals(orderBy) ? "</strong>" : "" %></span>
			</a>
		</div>
	</div>
	<div class="row row-cols-4 g-4 my-4">
		<%
			for (Product product : products) {
		%>
		<div class="col">
			<div class="card border-light h-100">
				<a href="/semi-project/product/detail.jsp?no=<%=product.getNo() %>">
					<img src="/semi-project/resources/images/product/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>/thumbnail/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>_1.jpg" 
				 	 class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				</a>
				<div class="card-body">
					<p class="card-text my-1">
						<%
							for (String color : product.getColors()) {
						%>
						<%=color %>
						<%
							}
						%>
					</p>
					<p class="card-text">제품명: <%=product.getName() %></p>
					<hr>
					<%
						// 제품의 할인기간이 끝나지 않았으면 할인가격과 남은 할인기간을 표시한다.
						String remainTime = product.getRemainTimeInOneDay();
						if (remainTime == null) {
					%>
					<p class="card-text mb-1"><%=product.getPrice() %>원</p>
					<%
						} else {
							
					%>
					<p class="card-text mb-1">
						<del><%=product.getPrice() %>원</del>, <%=product.getPrice() - product.getDiscountAmount() %>원<span class="text-danger">(<%=product.getDiscountAmount() %>원 할인)</span>
					</p>
					<p class="card-text my-1">할인기간 <%=remainTime %></p>
					<%
						}
					%>
					<p class="card-text my-1">생성일: <%=product.getCreatedDate() %>, 판매량: <%=product.getTotalSaleCount() %>, 리뷰평점: <%=product.getAverageReviewRate() %></p>
				</div>
			</div>
		</div>
		<%
			}
		%>
	</div>
	<div class="row mb-3">
		<div class="col-6 offset-3">
			<nav>
				<ul class="pagination justify-content-center">
					<!-- 
						Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=1&category=<%=category %>&orderBy=<%=orderBy %>" >&#60;&#60;</a></li>
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>&category=<%=category %>&orderBy=<%=orderBy %>" >&#60;</a></li>
					<%
						// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
						for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
					%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%>&category=<%=category %>&orderBy=<%=orderBy %>"><%=num %></a></li>
					<%
						}
					%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>&category=<%=category %>&orderBy=<%=orderBy %>" >&#62;</a></li>
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getTotalPages()%>&category=<%=category %>&orderBy=<%=orderBy %>" >&#62;&#62;</a></li>
				</ul>
			</nav>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	function searchProducts(pageNo) {
		document.getElementById("page-field").value = pageNo;
		var form = document.getElementById("form-search");
		form.submit();
	}
	
	// 이미지의 경로에서 확장자를 제외한 마지막 문자를 imgNumber로 변경한다.
	function changeImage(el, imgNumber) {
		var oldSrc = el.src;
		var strArray = oldSrc.split(".");
		var newSrc = strArray[0].slice(0, -1) + imgNumber + "." + strArray[1];
		el.src = newSrc;
	}
</script>
</body>
</html>