<%@page import="utils.TimeUtil"%>
<%@page import="java.util.Date"%>
<%@page import="semi.criteria.ProductCriteria"%>
<%@page import="semi.vo.Product"%>
<%@page import="java.util.List"%>
<%@page import="semi.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<title>빈스데이</title>
	<style>
		.container {
			min-width: 992px;
		}
		
		.no-drag {
			-ms-user-select: none; -moz-user-select: -moz-none; -webkit-user-select: none; -khtml-user-select: none; user-select:none;
		}
		
		a:link {color: black; text-decoration: none;}
 		a:visited {color: black; text-decoration: none;}
 		a:hover {color: black; text-decoration: none;}
 		a:active {color: black; text-decoration: none;}
 		a:hover:first-child {color: black; text-decoration: none;}
		
		#best-item {
			background-color: #f6f4f3;
		}
		.image {
			position: relative;
		}
		.image img {
			transition: .5s;
		}
		.image:hover img {
			opacity: 0.3;
		}
		.text-over-image {
			position: absolute;
			top:50%;
     		left:50%;
     		transform: translate(-50%, -50%);
     		text-align: center;
     		visibility: hidden;
		}
		.image:hover .text-over-image {
			visibility: visible;
		}
	</style>
</head>
<body>
<%@ include file="common/navbar.jsp" %>
<%
	ProductDao productDao = ProductDao.getInstance();
	ProductCriteria topProductCriteria = new ProductCriteria();
	ProductCriteria dressProductCriteria = new ProductCriteria();
	ProductCriteria pantsProductCriteria = new ProductCriteria();
	ProductCriteria newProductCriteria = new ProductCriteria();
	
	topProductCriteria.setBegin(1);
	topProductCriteria.setEnd(8);
	topProductCriteria.setCategory("TOP");
	topProductCriteria.setOrderBy("인기상품");
	
	dressProductCriteria.setBegin(1);
	dressProductCriteria.setEnd(8);
	dressProductCriteria.setCategory("DRESS");
	dressProductCriteria.setOrderBy("인기상품");
	
	pantsProductCriteria.setBegin(1);
	pantsProductCriteria.setEnd(8);
	pantsProductCriteria.setCategory("PANTS");
	pantsProductCriteria.setOrderBy("인기상품");
	
	newProductCriteria.setBegin(1);
	newProductCriteria.setEnd(8);
	newProductCriteria.setCategory("전체상품");
	newProductCriteria.setOrderBy("신상품");
	
	List<Product> topProducts = productDao.getProductListBycategory(topProductCriteria);
	List<Product> dressProducts = productDao.getProductListBycategory(dressProductCriteria);
	List<Product> pantsProducts = productDao.getProductListBycategory(pantsProductCriteria);
	List<Product> newProducts = productDao.getAllProductList(newProductCriteria);
%>
<div class="container-fluid">
	<div id="homeBannerCarousel" class="carousel slide" data-bs-ride="carousel">
  		<div class="carousel-indicators">
    		<button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    		<button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
    		<button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
  		</div>
  		<div class="carousel-inner">
    		<div class="carousel-item active">
      			<img src="resources/images/home/carousel/1.jpeg" class="d-block w-100" alt="...">
    		</div>
    		<div class="carousel-item">
      			<img src="resources/images/home/carousel/2.jpeg" class="d-block w-100" alt="...">
    		</div>
    		<div class="carousel-item">
      			<img src="resources/images/home/carousel/3.jpeg" class="d-block w-100" alt="...">
    		</div>
  		</div>
  		<button class="carousel-control-prev" type="button" data-bs-target="#homeBannerCarousel" data-bs-slide="prev">
   			<span class="carousel-control-prev-icon" aria-hidden="true"></span>
   			<span class="visually-hidden">Previous</span>
 		</button>
  		<button class="carousel-control-next" type="button" data-bs-target="#homeBannerCarousel" data-bs-slide="next">
  		  	<span class="carousel-control-next-icon" aria-hidden="true"></span>
   		 	<span class="visually-hidden">Next</span>
 		</button>
	</div>
</div>
<div class="container">    
	<div class="row mt-3">
		<div class="col">
			<div class="card-group">
				<div class="card border-light h-100">
					<a href="/semi-project/product/list.jsp?category='전체상품'&orderBy='인기상품'">
						<img src="resources/images/home/banner/1.jpg" class="card-img-top">
					</a>
					<div class="card-body text-center">
						<a href="/semi-project/product/list.jsp?category=전체상품&orderBy=인기상품">
							<span class="card-text"><strong>BEST ITEMS</strong></span><br>
							<span class="text-muted"><small>사랑받고 있는 인기상품*.*</small></span>
						</a>
					</div>
				</div>
				<div class="card border-light h-100">
					<a href="/semi-project/product/list.jsp?category=TOP">
						<img src="resources/images/home/banner/2.jpg" class="card-img-top">
					</a>
					<div class="card-body text-center">
						<a href="/semi-project/product/list.jsp?category=TOP">
							<span class="card-text"><strong>TOP</strong></span><br>
							<span class="text-muted"><small>빈스데이만의 특별한 상의</small></span>
						</a>
					</div>
				</div>
				<div class="card border-light h-100">
					<a href="/semi-project/product/list.jsp?category=DRESS">
						<img src="resources/images/home/banner/3.jpg" class="card-img-top">
					</a>
					<div class="card-body text-center">
						<a href="/semi-project/product/list.jsp?category=DRESS">
							<span class="card-text"><strong>DRESS</strong></span><br>
							<span class="text-muted"><small>특별한 날, 더욱 특별하게!</small></span>
						</a>
					</div>
				</div>
				<div class="card border-light h-100">
					<img src="resources/images/home/banner/4.jpg" class="card-img-top">
					<div class="card-body text-center">
						<a href="">
							<span class="card-text"><strong>REVIEW</strong></span><br>
							<span class="text-muted"><small>리뷰 작성하고 쿠폰 받아가자</small></span>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="container-fluid" id="best-item">
	<div class="row">
		<div class="col text-center mt-5">
			<h6><strong>WEEKLY BEST ITEMS</strong></h6>
		</div>
	</div>
	<div class="row">
		<div class="col text-center">
			<h6 class="text-muted"><small>이번주 가장 사랑받은 베스트 아이템</small></h6>
		</div>
	</div>
	<div class="row">
		<div class="col text-center mb-5">
    		<button type="button" class="btn btn-light mx-2" data-bs-target="#weeklyBestItemsCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1">
    			<span><small class="text-muted">TOP</small></span>
    		</button>
    		<button type="button" class="btn btn-light mx-2" data-bs-target="#weeklyBestItemsCarousel" data-bs-slide-to="1" aria-label="Slide 2">
    			<span><small class="text-muted">DRESS</small></span>
    		</button>
    		<button type="button" class="btn btn-light mx-2" data-bs-target="#weeklyBestItemsCarousel" data-bs-slide-to="2" aria-label="Slide 3">
    			<span><small class="text-muted">PANTS</small></span>
    		</button>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col">
				<div id="weeklyBestItemsCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="false">
			  		<div class="carousel-inner">
			    		<div class="carousel-item active">
			      			<div class="row row-cols-4 g-2 mb-2">
								<% 
									int i = 1;
									for (Product product : topProducts) {
								%>
								<div class="col">
									<div id="best-item-<%=i %>" class="image" onmouseenter="changeInnerImage(this, 2)" onmouseleave="changeInnerImage(this, 1)">
										<!-- 리뷰 수 미구현 -->
										<a href="/semi-project/product/detail.jsp?no=<%=product.getNo() %>">
											<img src="/semi-project/resources/images/product/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>/thumbnail/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>_1.jpg" class="img-fluid">
										</a>
										<p class="text-over-image no-drag">
											<a href="/semi-project/product/detail.jsp?no=<%=product.getNo() %>">
												<strong><%=product.getName() %><br><br>가격: <%=product.getPrice() %>원<br><br>리뷰 수: 4</strong>
											</a>
										</p>
									</div>
								</div>
								<%
									i++;
									}
								%>
							</div>
			    		</div>
			    		<div class="carousel-item">
			      			<div class="row row-cols-4 g-2 mb-2">
								<% 
									for (Product product : dressProducts) {
								%>
								<div class="col">
									<div id="best-item-<%=i %>" class="image" onmouseenter="changeInnerImage(this, 2)" onmouseleave="changeInnerImage(this, 1)">
										<!-- 리뷰 수 미구현 -->
										<a href="/semi-project/product/detail.jsp?no=<%=product.getNo() %>">
											<img src="/semi-project/resources/images/product/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>/thumbnail/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>_1.jpg" class="img-fluid">
										</a>
										<p class="text-over-image no-drag">
											<a href="/semi-project/product/detail.jsp?no=<%=product.getNo() %>">
												<strong><%=product.getName() %><br><br>가격: <%=product.getPrice() %>원<br><br>리뷰 수: 4</strong>
											</a>
										</p>
									</div>
								</div>
								<%
									i++;
									}
								%>
							</div>
			    		</div>
			    		<div class="carousel-item">
			      			<div class="row row-cols-4 g-2 mb-2">
								<% 
									for (Product product : pantsProducts) {
								%>
								<div class="col">
									<div id="best-item-<%=i %>" class="image" onmouseenter="changeInnerImage(this, 2)" onmouseleave="changeInnerImage(this, 1)">
										<!-- 리뷰 수 미구현 -->
										<a href="/semi-project/product/detail.jsp?no=<%=product.getNo() %>">
											<img src="/semi-project/resources/images/product/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>/thumbnail/<%=productDao.getProductThumbnailImage(product.getNo()).isEmpty() ? 1000 : product.getNo() %>_1.jpg" class="img-fluid">
										</a>
										<p class="text-over-image no-drag">
											<a href="/semi-project/product/detail.jsp?no=<%=product.getNo() %>">
												<strong><%=product.getName() %><br><br>가격: <%=product.getPrice() %>원<br><br>리뷰 수: 4</strong>
											</a>
										</p>
									</div>
								</div>
								<%
									i++;
									}
								%>
							</div>
			    		</div>
			  		</div>
				</div>
			</div>
		</div>
	</div>
	<div class="p-5">
	</div>
</div>
<div class="container">
	<div class="row">
		<div class="col text-center mt-5">
			<h6><strong>NEW ARRIVALS</strong></h6>
		</div>
	</div>
	<div class="row">
		<div class="col text-center mb-5">
			<h6 class="text-danger"><small>24시간 신상품 5% SALE!</small></h6>
		</div>
	</div>
	<div class="row row-cols-4 g-4 mb-2">
		<%
			for (Product product : newProducts) {
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
					<p class="card-text"><%=product.getName() %></p>
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
				</div>
			</div>
		</div>
		<%
			}
		%>
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
	
	// 태그 내부에 있는 이미지의 경로에서 확장자를 제외한 마지막 문자를 imgNumber로 변경한다.
	function changeInnerImage(el, imgNumber) {
		var InnerImage = document.querySelector("#" + el.id + " img");
		changeImage(InnerImage, imgNumber);
	}
</script>
</body>
</html>