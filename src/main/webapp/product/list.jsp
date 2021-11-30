<%@page import="java.util.ArrayList"%>
<%@page import="semi.vo.Product"%>
<%@page import="semi.vo.ProductItem"%>
<%@page import="java.util.List"%>
<%@page import="semi.dao.ProductDao"%>
<%@page import="semi.vo.Pagination"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>OUTER - 빈스데이</title>
    <style type="text/css">
		.container {
			min-width: 992px;
		}
    	
    	span {
    		color: #a5a5a5;
    		font-size: 0.8em;
    	}
    	.orderBy {
    		text-decoration: none;
    	}
    	.orderBy > span:hover {
    		color: #cccccc;
    	}
    </style>
</head>
<body>
<%@ include file="/common/navbar.jsp" %>
<div class="container">
	<%
		// 요청 파라미터에서 선택된 카테고리를 조회한다.
		String category = request.getParameter("category");
		String pageNo = request.getParameter("pageNo");
		String orderBy = request.getParameter("orderBy");
		
		
		
		// category가 비어있을 경우 초기값으로 TOP을 넣어준다.
		if (category == null) {
			category = "TOP";
		}
		// category가 SHIRT일 경우 SHIRT&BLOUSE로 바꿔준다.
		if ("SHIRT".equals(category)) {
			category = "SHIRT&BLOUSE";
		}
		// pageNo가 비어있을 경우 초기값으로 1을 넣어준다.
		if (pageNo == null) {
			pageNo = "1";
		}
		
		ProductDao productDao = ProductDao.getInstance();
		
		int totalRecords = productDao.getTotalRecords(category);
		// TODO 테스트용 println
		System.out.println("totalRecords: " + totalRecords);
		Pagination pagination = new Pagination(pageNo, totalRecords);
			
		List<Product> products = new ArrayList<Product>();
		if ("BEST".equals(category)) {
			// TODO DB에서 상품 판매량 상위 ?개를 가져온다.
					
		} else {
			// TODO 카테고리가 알맞은지 먼저 확인하고, 해당하는 상품 리스트를 가져온다.
			products = productDao.getProductListBycategory(pagination.getBegin(), pagination.getEnd(), category, orderBy);
		}
	%>
	<div class="row">
		<div class="col my-4 text-center">
			<h4><%=category %></h4>
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
				<!-- 이미지 미구현 -->
				<img src="http://localhost/semi-project/resources/images/product/1000/thumbnail/1000_1.jpg" class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				<div class="card-body">
					<p class="card-text"><%=product.getName() %></p>
					<hr>
					<p class="card-text"><%=product.getPrice() %>원, 생성일: <%=product.getCreatedDate() %>, 판매량: <%=product.getTotalSaleCount() %>, 리뷰평점: <%=product.getAverageReviewRate() %></p>
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