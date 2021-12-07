<%@page import="semi.vo.ProductStyle"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="semi.vo.ProductDetailImage"%>
<%@page import="semi.vo.ProductThumbnailImage"%>
<%@page import="semi.vo.ProductItem"%>
<%@page import="java.util.List"%>
<%@page import="semi.vo.Product"%>
<%@page import="semi.admin.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>상품 정보</title>
</head>
<body>
<%
	// include 시킨 navbar의 nav-item 중에서 페이지에 해당하는 nav-item를 active 시키기위해서 "menu"라는 이름으로 페이지이름을 속성으로 저장한다.
	// pageContext에 menu라는 이름으로 설정한 속성값은 navbar.jsp에서 조회해서 navbar의 메뉴들 중 하나를 active 시키기 위해서 읽어간다.
	pageContext.setAttribute("menu", "product");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String tempPageNo = request.getParameter("pageNo");
	int pageNo = 1;
	if (tempPageNo != null) {
		pageNo = Integer.parseInt(tempPageNo);
	}
	
	final String PATH = "/semi-project/resources/images/product/" + productNo + "/";
	
	AdminService service = AdminService.getInstance();
	
	Product product = service.getProductByNo(productNo);
	List<ProductItem> items = service.getItemsByProductNo(productNo);
	List<ProductThumbnailImage> thumbnailImages = service.getThumbnailImagesByProductNo(productNo);
	List<ProductDetailImage> detailImages = service.getDetailImagesByProductNo(productNo);
	List<ProductStyle> styles = service.getStylesByNo(productNo);
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>상품 정보</h1>
			</div>
			<div class="col text-end">
				<a href="list.jsp?pageNo=<%=pageNo %>" class="btn btn-secondary">목록</a>
				<a href="modifyform.jsp?productNo=<%=productNo %>&pageNo=<%=pageNo %>" class="btn btn-warning">수정</a>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<tbody>
						<tr class="d-flex">
							<th class="col-2">상품번호</th>
							<td class="col-4"><%=product.getNo() %></td>
							<th class="col-2">상품이름</th>
							<td class="col-4"><%=product.getName() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">카테고리</th>
							<td class="col-4"><%=product.getProductCategory().getName() %></td>
							<th class="col-2">가격</th>
							<td class="col-4"><%=product.getPrice() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">등록날짜</th>
							<td class="col-4"><%=product.toSimpleDate(product.getCreatedDate()) %></td>
							<th class="col-2">할인가격</th>
							<td class="col-4"><%=product.getDiscountPrice() == 0 ? "-" : product.getDiscountPrice() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">수정날짜</th>
							<td class="col-4"><%=product.toSimpleDate(product.getUpdatedDate()) == null ? "-" : product.toSimpleDate(product.getUpdatedDate()) %></td>
							<th class="col-2">할인기간</th>
							<td class="col-4"><%=product.toSimpleDate(product.getDiscountFrom()) == null ? "-" : product.toSimpleDate(product.getDiscountFrom()) %> ~ <%=product.toSimpleDate(product.getDiscountTo()) == null ? "-" : product.toSimpleDate(product.getDiscountTo()) %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">총판매량</th>
							<td class="col-4"><%=product.getTotalSaleCount() %></td>
							<th class="col-2">리뷰평점</th>
							<td class="col-4"><%=product.getAverageReviewRate() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">총재고량</th>
							<td class="col-4"><%=product.getTotalStock() %></td>
							<th class="col-2">판매여부</th>
							<td class="col-4"><%=product.getOnSale().equals("Y") ? "판매중" : "판매중단" %></td>
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
							<th class="col-2">품목번호</th>
							<th class="col-4">색상</th>
							<th class="col-2">사이즈</th>
							<th class="col-2">재고량</th>
							<th class="col-2">판매량</th>
						</tr>
					</thead>
					<tbody>
<%
	if (items.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="text-center" colspan="5">품목이 존재하지 않습니다.</td>
						</tr>
<%
	} else {
		for (ProductItem item : items) {
%>
						<tr class="d-flex">
							<td class="col-2"><%=item.getNo() %></td>
							<td class="col-4"><%=item.getColor() %></td>
							<td class="col-2"><%=item.getSize() %></td>
							<td class="col-2"><%=item.getStock() %></td>
							<td class="col-2"><%=item.getSaleCount() %></td>
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
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-12">상세정보</th>
						</tr>
					</thead>
					<tbody>
<%
	if (product.getDetail() == null) {
%>
						<tr class="d-flex">
							<td class="text-center col-12">-</td>
						</tr>
<%		
	} else {
%>
						<tr class="d-flex">
							<td class="col-12"><%=product.getDetail() %></td>
						</tr>
<%
	}
%>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table" style="table-layout: fixed; width: 100%">
					<thead>
						<tr class="d-flex">
							<th class="col-2">섬네일이미지</th>
							<th class="col-10">이미지경로</th>
						</tr>
					</thead>
					<tbody>
<%
	if (thumbnailImages.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="text-center col-12" colspan="2">-</td>
						</tr>
<%
	} else {
		for (ProductThumbnailImage image : thumbnailImages) {
%>
						<tr class="d-flex">
							<td class="col-2"><a href="<%=PATH %><%=image.getUrl()%>"><img src="<%=PATH %><%=image.getUrl()%>" class="img-thumbnail" style="width: 100px;"></a></td>
							<td class="col-10" style="word-wrap: break-word"><%=PATH %><%=image.getUrl() %></td>
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
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-2">상세이미지</th>
							<th class="col-10">이미지경로</th>
						</tr>
					</thead>
					<tbody>
<%
	if (detailImages.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="text-center col-12" colspan="2">-</td>
						</tr>
<%
	} else {
		for (ProductDetailImage image : detailImages) {
%>
						<tr class="d-flex">
							<td class="col-2"><a href="<%=PATH %><%=image.getUrl()%>"><img src="<%=PATH %><%=image.getUrl()%>" class="img-thumbnail" style="width: 100px;"></a></td>
							<td class="col-10"><%=PATH %><%=image.getUrl() %></td>
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
			
				<table class="table">
					<thead>
						<tr class="d-flex">
							<th class="col-2">코디상품번호</th>
							<th class="col-4">상품이름</th>
							<th class="col-2">카테고리</th>
							<th class="col-2">총재고량</th>
							<th class="col-2">총판매량</th>							
						</tr>
					</thead>
					<tbody>
<%
	if (styles.isEmpty()) {
%>
						<tr class="d-flex">
							<td class="text-center col-12" colspan="2">-</td>
						</tr>
<%
	} else {
		for (ProductStyle style : styles) {
%>
						<tr class="d-flex">
							<td class="col-2"><%=style.getProduct().getNo() %></td>
							<td class="col-4"><a href="detail.jsp?productNo=<%=style.getProduct().getNo() %>"><%=style.getProduct().getName() %></a></td>
							<td class="col-2"><%=style.getProduct().getProductCategory().getName() %></td>
							<td class="col-2"><%=style.getProduct().getTotalStock() %></td>
							<td class="col-2"><%=style.getProduct().getTotalSaleCount() %></td>
						</tr>
<%
		}
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