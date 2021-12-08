<%@page import="semi.dao.UserDao"%>
<%@page import="semi.vo.Review"%>
<%@page import="semi.dao.ReviewDao"%>
<%@page import="semi.vo.Pagination"%>
<%@page import="semi.dto.InquiryDto"%>
<%@page import="semi.dao.InquiryDao"%>
<%@page import="semi.vo.ProductItem"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="semi.vo.Product"%>
<%@page import="semi.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<%
int no = Integer.parseInt(request.getParameter("no"));
String reviewOrderBy = request.getParameter("reviewOrderBy");

if (reviewOrderBy == null) {
	reviewOrderBy = "최신순";
}

ProductDao productDao = ProductDao.getInstance();
Product product = productDao.getProductDetail(no);

List<String> thumbnails = productDao.getProductThumbnailImageList(no);
%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title><%=product.getName()%> - 빈스데이</title>
</head>
<style>
.thumbnail_list_img ul li {
	display: inline;
}

.btn_list li {
	display: inline;
}

.style_list ul li {
	display: inline;
}

.style_list_div {
	font-size: small;
}

#total-price {
	font-weight: bold;
	display: inline;
}
#review-add {
	display: inline;
}

.review-rate ul li {
	display: inline;
}
#reviewImage {
	width: 128px;
	height: 128px;
}
</style>
<body>

	<%@ include file="../common/navbar.jsp"%>
	<div class="container">
		<form method="post" id="form-order" action="order.jsp">
			<div class="row">
				<div class="col">
					<div class="d-flex justify-content-end">
						<nav style="-bs-breadcrumb-divider: '&gt;';"
							aria-label="breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a
									href="/semi-prodject/index.jsp"
									style="text-decoration: none; color: gray;">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page"><%=product.getProductCategory().getName()%></li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
			<div class="detailArea mb-5">
				<div class="row">
					<div class="col-md-6">
						<div class="detail_big_img">
							<img
								src="../resources/images/product/<%=product.getNo()%>/thumbnail/<%=thumbnails.get(0)%>"
								id="big-pic" alt="productImg" class="big_img img-fluid">
						</div>
						<div class="thumbnail_list_img">
							<ul class="thumb_img p-0 mt-3" style="list-style: none">
								<%
								for (String thumbnail : thumbnails) {
								%>
								<li><img class="small-pic"
									src="../resources/images/product/<%=product.getNo()%>/thumbnail/<%=thumbnail%>"
									style="width: 75px" alt="productImg"></li>
								<%
								}
								%>
							</ul>
						</div>
					</div>
					<div class="col-md-5">
						<h5><%=product.getName()%></h5>
						<hr class="mt-4 mb-3">
						<input type="hidden" name="no" value="<%=product.getNo()%>">
						<table class="table table-borderless">
							<tr>
								<%
								boolean onSale = false;
								long currentPrice = product.getPrice();

								DecimalFormat formatter = new DecimalFormat("###,###");

								SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
								Date date = new Date();
								String today = format.format(date);
								Date todate = format.parse(today);

									if (product.getDiscountFrom() != null || product.getDiscountTo() != null) {
										int compareTo = product.getDiscountTo().compareTo(todate);
										int compareFrom = todate.compareTo(product.getDiscountFrom());
									
										if (product.getDiscountPrice() != 0 && (compareTo >= 0 && compareFrom >= 0)) {
									onSale = true;
									currentPrice = product.getDiscountPrice();
								%>
								<td>소비자가</td>
								<td class="text-decoration-line-through"><%=formatter.format(product.getPrice())%>원</td>
							</tr>
							<tr>
								<td>판매가</td>
								<td><%=formatter.format(currentPrice)%>원</td>
								<%
								} else {
								%>
								<td>판매가</td>
								<td><%=formatter.format(currentPrice)%>원</td>
								<%
								}
									} else {
								%>
								<td>판매가</td>
								<td><%=formatter.format(currentPrice)%>원</td>
								<%
								}
								%>
							</tr>
							<tr>
								<%
								List<String> colorList = productDao.getProductColorList(no);
								if (colorList.get(0) != null) {
								%>
								<td>색상</td>
								<td>
									<%
									for (String color : colorList) {
									%>
									<div id="color-check"
										class="form-check form-check-inline p-0 m-0">
										<input type="radio" class="btn-check"
											id="color btn-check-outlined<%=color%>" name="color"
											value="<%=color%>"> <label
											class="btn btn-outline-secondary"
											for="color btn-check-outlined<%=color%>"><%=color%></label>
									</div> <%
 } 
 } else {
 %>
									<div id="color-check">
										<input type="hidden" name="color"
											value="<%=colorList.get(0)%>">
									</div> <%
 }
 %>
									<P style="display: none" id="error-message-color">[필수] 색상을
										선택해 주세요</P>
								</td>
							<tr>
								<td>사이즈</td>
								<td id="size-list">
									<%
									List<String> sizeList = productDao.getProductSizeList(no);
									for (String size : sizeList) {
									%>
									<div id="size-check"
										class="form-check form-check-inline p-0 m-0">
										<input type="radio" class="btn-check"
											id="size btn-check-outlined<%=size%>" name="size"
											value="<%=size%>"> <label
											class="btn btn-outline-secondary"
											for="size btn-check-outlined<%=size%>"><%=size%></label>
									</div> <%
 }
 %>
									<P style="display: none" id="error-message-size">[필수] 옵션을
										선택해 주세요</P>
								</td>
							</tr>
							<tr>
								<td>수량</td>
								<td><select name="amount" onchange="changeOrderPrice()"
									id="product-amount" class="form-select"
									aria-label="Default select example">
										<option value="1" selected>1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
								</select></td>
							</tr>
						</table>
						<hr class="mt-3">
						<div class="d-flex justify-content-between mt-4 mb-4">
							<div>
								<strong>총 상품금액</strong> :
							</div>
							<div>
								<p id="total-price"><%=formatter.format(currentPrice)%></p>
								<span>원</span>
							</div>
						</div>
						<div class="d-flex justify-content-end">
							<ul class="btn_list p-0" style="list-style: none">
								<li><button type="button" onclick="goBuy()"
										class="btn btn-secondary btn-lg">
										<span class="fs-6">BUY IT NOW</span>
									</button></li>
								<li><button type="button" onclick="goCart()"
										class="btn btn-outline-secondary btn-lg">
										<span class="fs-6">CART</span>
									</button></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="d-flex justify-content-center mt-5 mb-4"
						id="detailInfo">
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="#detailInfo">상품상세정보</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#guide">쇼핑가이드</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#productStyle">코디상품</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#review">구매후기</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#inquiry">상품문의</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="d-flex flex-column bd-highlight mb-3">
						<div class="p-5 bd-highlight d-flex justify-content-center">
							<h3>#COMMENT</h3>
						</div>
						<div class="p-2 bd-highlight d-flex justify-content-center">
							<p><%=product.getDetail()%></p>
						</div>
						<%
						for (String thumbnail : thumbnails) {
						%>
						<div class="p-2 bd-highlight d-flex justify-content-center">
							<img
								src="../resources/images/product/<%=product.getNo()%>/thumbnail/<%=thumbnail%>"
								alt="productimg" class="big_img img-fluid">
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="d-flex justify-content-center mt-5 mb-5 pt-4 pb-5"
						id="guide">
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#detailInfo">상품상세정보</a></li>
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="#guide">쇼핑가이드</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#productStyle">코디상품</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#review">구매후기</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#inquiry">상품문의</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="border" style="padding: 50px;">
						<h3>상품결제정보</h3>
						고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의
						주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다. &nbsp; <br>
						<br> 무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면
						됩니다. &nbsp;<br> 주문시 입력한&nbsp;입금자명과 실제입금자의 성명이 반드시 일치하여야 하며,
						2일 이내로 입금을 하셔야 하며&nbsp;입금되지 않은 주문은 자동취소 됩니다.
						<hr class="mt-4 mb-4">
						<h3>배송정보</h3>
						배송 업체 : 우체국택배 (1588-1300) <br>배송 기간 : 3~7일 (주말, 공휴일 포함) <br>배송
						비용 : 5만원 이상 구매시 무료배송 / 5만원 미만 배송비 3,000원 추가 <br>- 주문 폭주, 입고
						지연 등 거래처 사정에 따라 더 지연되거나 품절될 수 있는 점 양해부탁드립니다 <br>- 제주도, 도서,
						산간지역일 경우 추가 운임비가 발생할 수 있으며, 평균 배송일보다 1~2일 더 소요될 수 있습니다
						<hr class="mt-4 mb-4">
						<h3>교환 및 반품정보</h3>
						<strong><ins>교환 및 반품 주소</ins></strong><br>(우:06779) 서울특별시 서초구
						동산로19 (서울서초우체국) 소포실<strong><br></strong><br> <strong><ins>교환
								및 반품 의사</ins></strong><br>상품 수령일로부터 7일 이내 반드시 고객센터를 통해 교관 및 반품 의사를 밝혀주시고
						반품 신청해주세요<br>교환 및 반품 시 받아보신 상태 동일하게 (박스, 폴리백, 사은품 등) 박스에 잘
						넣어서 함께 보내주시면 됩니다<br> <br>
						<ins>
							<strong>교환 및 반품 배송비</strong>
						</ins>
						<br>﻿단순 변심에 의한 교환 또는 무료 배송 상품인 경우 : 왕복 6,000원 고객 부담<br>단순
						변심에 의한 반품인 경우 : 3,000원 고객 부담<br> <br>불량 및 오배송인 경우는
						빈스데이에서 배송비 부담하며 새 제품 또는 환불 진행해드립니다<br>우체국 택배가 아닌 타 택배사를 이용하는
						경우는 고객님 부담 선불 발송을 해주셔야 합니다<br>환불금에서 차감이나 동봉 해주시면 되는데 분실우려가
						있으므로 "환불금에서 차감"을 추천드립니다<br> <br> <strong><ins>교환
								및 반품이 불가능한 경우</ins></strong><br> 상품 수령 후 7일 이상 지난 경우<br>고객 부주의로 인한
						상품의 변형, 훼손되어 상품 가치가 상실된 경우<br>착용 흔적이 있는 경우 (택제거, 향수 냄새, 담배
						냄새, 화장품 흔적 등)<br>수선 또는 세탁한 상품<br> ﻿<br> <strong><ins>구매
								전 필독 사항</ins></strong><br>사이즈는 재는 위치에 따라 1~3cm의 오차가 발생할 수 있습니다<br>패턴이
						있을 경우 재단의 위치에 따라 모양이나 위치가 옷마다 조금식 다를 수 있습니다.<br>마감 부분에 실밥이나
						초크 자국이 남아있을 수 있습니다<br>데님 소재, 컬러 상품은 밝은 색상의 상품과 착용하거나 첫 세탁시 이염
						또는 물 빠짐이 발생할 수 있습니다<br>사진 색상의 경우 자연광과 조명 색상의 영향으로 실제 컬러와 다를 수
						있습니다<br> <br>* 위에 사유로는 상품 불량에 해당하지 않기 때문에 구매 전 상세정보, 디테일
						이미지를 꼭 확인해주시길 바랍니다<br>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="d-flex justify-content-center mt-5 mb-4 pt-5"
						id="productStyle">
						<ul class="nav nav-tabs">
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#detailInfo">상품상세정보</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#guide">쇼핑가이드</a></li>
							<li class="nav-item"><a class="nav-link active"
								aria-current="page" href="#productStyle">코디상품</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#review">구매후기</a></li>
							<li class="nav-item"><a class="nav-link"
								style="color: gray;" href="#inquiry">상품문의</a></li>
						</ul>
					</div>
				</div>
			</div>

			<div class="row mt-4">
				<div class="col">
					<div class="style_list mb-4 pb-4">
						<div class="mt-5 mb-5">
							<p align="center" style="font-size: small">
								<strong>WITH ITEM</strong><br />함께 코디된 상품입니다:)
							</p>
						</div>
						<div class="pb-5">
							<ul class="p-0 d-flex justify-content-center"
								style="list-style: none">
<%
List<Integer> styleProductNoList = productDao.getProductStyleNoList(no);
	for (Integer styleProductNo : styleProductNoList) {
		Product styleProduct = productDao.getProductDetail(styleProductNo);
		List<String> styleThumbnails = productDao.getProductThumbnailImageList(styleProductNo);
%>
								<li>
									<div class="style_list_div m-1" style="width: 186px;">
										<div style="height: 251px;">
											<a href="detail.jsp?no=<%=styleProduct.getNo()%>"> <img
												src="../resources/images/product/<%=styleProduct.getNo()%>/thumbnail/<%=styleThumbnails.get(0)%>"
												class="img-fluid" alt="productImg">
											</a>
											<div class="form-check">
												<input onclick="withProductSelect(this)"
													class="form-check-input" type="checkbox" name="no"
													value="<%=styleProduct.getNo()%>" id="withSelect">
												<label class="form-check-label" for="flexCheckDefault"><strong><%=styleProduct.getName()%>
												</strong></label>
											</div>
											<p align="right"><%=formatter.format(styleProduct.getPrice())%>원
											</p>
										</div>
<%
List<String> styleProductColorList = productDao.getProductColorList(styleProductNo);
		if (styleProductColorList.get(0) != null) {
%>
										<select id="withColor<%=styleProduct.getNo()%>"
										disabled="disabled" class="form-select mb-1"
										aria-label="Default select example" name="color">
											<option selected disabled="disabled" value="null">색상을 선택해주세요</option>
<%
for (String styleProductColor : styleProductColorList) {
%>			
											<option value="<%=styleProductColor%>"><%=styleProductColor%></option>
<%
}
%>
										</select>
<%
} else {
%>
											<input type="hidden" name="color" value="<%=styleProductColorList.get(0)%>">
<%
}
%>
										<select id="withSize<%=styleProduct.getNo()%>"
											disabled="disabled" class="form-select mb-1"
											aria-label="Default select example" name="size">
											<option selected disabled="disabled" value="null">사이즈를 선택해주세요</option>
<%
List<String> styleProductSizeList = productDao.getProductSizeList(styleProductNo);
		for (String styleProductSize : styleProductSizeList) {
%>
											<option value="<%=styleProductSize%>"><%=styleProductSize%></option>
<%
}
%>
										</select>
										<select id="withAmount<%=styleProduct.getNo()%>"
											disabled="disabled" class="form-select mb-1"
											aria-label="Default select example" name="amount">
											<option selected disabled="disabled" value="null">수량을 선택해주세요</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
										</select>
									</div>
								</li>
<%
}
%>
							</ul>
						</div>
						<div class="d-flex justify-content-center mt-5">
							<ul class="btn_list p-0" style="list-style: none">
								<li><button type="button" onclick="withGoBuy()" class="btn btn-secondary">
										<span class="fs-6">코디상품 함께 구매하기</span>
									</button></li>
								<li><button type="button" onclick="withGoCart()"class="btn btn-outline-secondary">
										<span class="fs-6">코디상품 장바구니 담기</span>
									</button></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</form>
		<div class="row">
			<div class="col">
				<div class="d-flex justify-content-center mt-5 mb-4" id="review">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#detailInfo">상품상세정보</a></li>
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#guide">쇼핑가이드</a></li>
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#productStyle">코디상품</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#review">구매후기</a></li>
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#inquiry">상품문의</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="row mt-5 pt-3 mb-5">
			<div class="col p-0">
				<div>
					<form method="post" action="reviewregister.jsp" id="form-review" enctype="multipart/form-data">
						<input type="hidden" name="from" value="detail">
						<!-- user_no session에서 가져오기 hidden으로 -->
						<input type="hidden" name="productNo" value="<%=product.getNo()%>">
						<p style="font-size: small; color: gray; margin-bottom: 0">
							<strong>REVIEW</strong> | 문의글 혹은 악의적인 비방글은 무통보 삭제된다는 점 유의해주세요^^
						</p>
						<div class="form-floating">
							<textarea onchange="textAreaChange()" class="form-control" placeholder="리뷰를 남겨주세요." name="reviewContent"
								id="review-area" style="height: 120px"></textarea>
							<label for="reviewTextArea">리뷰를 남겨주세요.</label>
						</div>
						<div class="row mt-1 p-0">
						    <div class="col-sm-1 m-0">
						       <label for="photo">사진 추가</label>
						    </div>
						    <div class="col-sm-3 p-0 pe-1">
						        <input type="file" class="form-control" id="photo" name="reviewImage">
						    </div>
						    <div class="col-sm-4 p-0">
						        <select name="reviewRate" class="form-select col-sm" aria-label="Default select example">
									<option value="5" selected>아주 좋아요</option>
									<option value="4">맘에 들어요</option>
									<option value="3">보통이에요</option>
									<option value="2">그냥 그래요</option>
									<option value="1">별로에요</option>
								</select>
						    </div>
						    <div class="col-sm-2 p-0 ps-4 end">
						     	<button onclick="reviewRegister(event)" class="btn btn-secondary" type="submit">
								<span class="fs-6">리뷰 등록하기</span></button>
					     	</div>
					    </div>
					</form>
				</div>
			</div>
		</div>
<%
String pageNo = request.getParameter("reviewPageNo");
	UserDao userDao = UserDao.getInstance();
	ReviewDao reviewDao = ReviewDao.getInstance();
	int totalRecords = reviewDao.getTotalRecordsByProductNo(no);
	Pagination pagination = new Pagination(pageNo, totalRecords, 5, 5);
	List<Review> reviewList = reviewDao.getReviewList(no, pagination.getBegin(), pagination.getEnd(), reviewOrderBy);
%>
		<div class="row">
			<div class="col">
				<div class="d-flex justify-content-start mt-5 mb-3 p-0">
					<div>
						<p>
							<span><strong>리뷰(<%=totalRecords%>)</strong></span>    
							<a style="color: gray; text-decoration: none" href="detail.jsp?no=<%=no%>&reviewOrderBy=최신순">
								<span><%="최신순".equals(reviewOrderBy) ? "<strong>" : ""%>최신순<%="최신순".equals(reviewOrderBy) ? "</strong>" : ""%></span>
							</a>
							<span> | </span>
							<a style="color: gray; text-decoration: none" href="detail.jsp?no=<%=no%>&reviewOrderBy=평점순">
								<span><%="평점순".equals(reviewOrderBy) ? "<strong>" : ""%>평점순<%="평점순".equals(reviewOrderBy) ? "</strong>" : ""%></span>
							</a>
						</p>
					</div>
				</div>
				<hr class="mb-0">
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
<%
if (reviewList.isEmpty()) {
%>
					<tr>
						<td class="text-center">게시글이 존재하지 않습니다.</td>
					</tr>
<%
} else {
		for (Review review : reviewList) {
			List<String> reviewImageNameList = reviewDao.getReviewImageNameListByReviewNo(review.getNo());
			User user = userDao.getUserByNo(review.getUserNo());
%>
					<tr>
						<td rowspan="3">
<%
			switch (review.getRate()) {
				case 5: 
%>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li>-아주 좋아요</li>
								</ul>
							</div>
							<%=review.getContent() %>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
<%
						if (!reviewImageNameList.isEmpty())	{						
							for (String reviewImageName : reviewImageNameList) {
%>
									<li><img id="reviewImage" alt="review_img" src="../resources/images/review/review_no/<%=review.getNo() %>/<%=reviewImageName %>"></li>
<%
							}
						}
%>
								</ul>
							</div>
<%
						break;
				case 4:
%>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li>-맘에 들어요</li>
								</ul>
							</div>
							<%=review.getContent() %>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
<%
						if (!reviewImageNameList.isEmpty())	{						
							for (String reviewImageName : reviewImageNameList) {
%>
									<li><img id="reviewImage" alt="review_img" src="../resources/images/review/review_no/<%=review.getNo() %>/<%=reviewImageName %>"></li>
<%
							}
						}
%>
								</ul>
							</div>
<%
						break;
				case 3:
%>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li>-보통이에요</li>
								</ul>
							</div>
							<%=review.getContent() %>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
<%
						if (!reviewImageNameList.isEmpty())	{						
							for (String reviewImageName : reviewImageNameList) {
%>
									<li><img id="reviewImage" alt="review_img" src="../resources/images/review/review_no/<%=review.getNo() %>/<%=reviewImageName %>"></li>
<%
							}
						}
%>
								</ul>
							</div>
<%
						break;
				case 2:
%>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li>-그냥 그래요</li>
								</ul>
							</div>
							<%=review.getContent() %>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
<%
						if (!reviewImageNameList.isEmpty())	{						
							for (String reviewImageName : reviewImageNameList) {
%>
									<li><img id="reviewImage" alt="review_img" src="../resources/images/review/review_no/<%=review.getNo() %>/<%=reviewImageName %>"></li>
<%
							}
						}
%>
								</ul>
							</div>
<%
						break;
				default:
%>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
									<li><img alt="star1" src="../resources/images/review/rate_star/star1.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li><img alt="star1" src="../resources/images/review/rate_star/star0.png"></li>
									<li>-별로에요</li>
								</ul>
							</div>
							<%=review.getContent() %>
							<div class="review-rate">
								<ul class="thumb_img p-0 mt-3" style="list-style: none">
<%
						if (!reviewImageNameList.isEmpty())	{						
							for (String reviewImageName : reviewImageNameList) {
%>
									<li><img id="reviewImage" alt="review_img" src="../resources/images/review/review_no/<%=review.getNo() %>/<%=reviewImageName %>"></li>
<%
							}
						}
%>
								</ul>
							</div>
<%
						break;
			}
%>
						</td>
						<td>
							<p class="mb-0">작성자</p>
							<span class="fw-bold"><%=user.getName().substring(0,1) %>****</span>
						</td>
					</tr>
					<tr>
						<td>
							<p class="mb-0">작성일</p>
							<span class="fw-bold"><%=review.getCreatedDate() %></span>
						</td>
					</tr>
					<tr>
						<td>
							<p class="mb-0">작성자 등급</p>
							<span class="fw-bold"><%=user.getGradeCode() %></span>
						</td>
					</tr>
<%
		}
	}
%>
				</table>
			</div>
		</div>
		<div class="row mb-3">
			<div class="col-6 offset-3">
				<nav>
					<ul class="pagination justify-content-center">
						<!-- 
							Pagination객체가 제공하는 isExistPrev()는 이전 블록이 존재하는 경우 true를 반환한다.
							Pagination객체가 제공하는 getPrevPage()는 이전 블록의 마지막 페이지값을 반환한다.
						 -->
						<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="detail.jsp?no=<%=product.getNo() %>&reviewPageNo=<%=pagination.getPrevPage()%>" >이전</a></li>
<%
	// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
	for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="detail.jsp?no=<%=product.getNo() %>"><%=num %></a></li>
<%
	}
%>					
						<!-- 
							Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
							Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
						 -->
						<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="detail.jsp?no=<%=product.getNo() %>&reviewPageNo=<%=pagination.getNextPage()%>" >다음</a></li>
					</ul>
				</nav>
			</div>
		</div>
			

		<div class="row mb-5 pb-3">
			<div class="col">
				<div class="d-flex justify-content-center mt-5 mb-4" id="inquiry">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#detailInfo">상품상세정보</a></li>
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#guide">쇼핑가이드</a></li>
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#productStyle">코디상품</a></li>
						<li class="nav-item"><a class="nav-link" style="color: gray;"
							href="#review">구매후기</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#inquiry">상품문의</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<h6 align="center">
					<strong>Q&amp;A</strong>
				</h6>
				<h6 align="center">상품에 대해 궁금한 점을 해결해 드립니다.</h6>
				<div class="d-flex justify-content-center mt-5 mb-4">
					<table class="table text-center">
						<colgroup>
							<col width="5%">
							<col width="20%">
							<col width="50%">
							<col width="10%">
							<col width="15%">
						</colgroup>		
						<thead class="table-light">
							<tr>
								<th>번호</th>
								<th>카테고리</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
<%
InquiryDao inquiryDao = InquiryDao.getInstance();
List<InquiryDto> inquiryDtoList = inquiryDao.getInquiryDtoByProductNo(no);
int inquiryRowNum = 0;
for (InquiryDto inquiryDto : inquiryDtoList) {
	if (inquiryDto.getInquiryDeleted().equals("N")) {
		inquiryRowNum += 1;
	} else {
		continue;
	}
	if ((inquiryDto.getReplyNo() != 0) && (inquiryDto.getReplyDeleted().equals("N"))) {
		inquiryRowNum += 1;
	}
}
for (InquiryDto inquiryDto : inquiryDtoList) {
	if (inquiryDto.getInquiryDeleted().equals("N")) {
%>
							<tr>
								<td><%=inquiryRowNum %></td>
								<td><%=inquiryDto.getCategoryName() %></td>
								<td class="text-start"><%=inquiryDto.getTitle() %></td>
								<td><%=inquiryDto.getUserName().substring(0,1) %>****</td>
								<td><%=inquiryDto.getInquiryCreatedDate() %></td>
							</tr>
<%
		inquiryRowNum -= 1;
	} else {
		continue;
	}
	if ((inquiryDto.getReplyNo() != 0) && (inquiryDto.getReplyDeleted().equals("N"))) {
%>
							<tr>
								<td><%=inquiryRowNum %></td>
								<td><%=inquiryDto.getCategoryName() %></td>
								<td class="text-start">└ <%=inquiryDto.getTitle() %></td>
								<td></td>
								<td><%=inquiryDto.getReplyCreatedDate() %></td>
							</tr>
<%
		inquiryRowNum -= 1;
	}
}
%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="d-flex justify-content-end">
			<ul class="btn_list p-0" style="list-style: none">
				<li><a href="../inquiryRegister.jsp?no=<%=product.getNo()%>"><button type="button" class="btn btn-secondary">
						<span class="fs-6">상품 문의하기</span>
					</button></a></li>
				<li><a href="../inquiry.jsp"><button type="button" class="btn btn-outline-secondary">
						<span class="fs-6">모두 보기</span>
					</button></a></li>
			</ul>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript">
	var bigPic = document.querySelector("#big-pic");            
	var smallPics = document.querySelectorAll(".small-pic");    //작은 사진(여러개)
	
	var no = [];
	var color = [];
	var size = [];
	var amount = [];
	
	for(var i = 0; i < smallPics.length; i++){
	    smallPics[i].addEventListener("click", changePic);  
	}
	function changePic(){   //사진 바꾸는 함수
		var smallPicAttribute = this.getAttribute("src");
	    bigPic.setAttribute("src", smallPicAttribute);
	}


	function checkForm() {
		var colorElements = document.querySelectorAll("#color-check input");
		var sizeElements = document.querySelectorAll("#size-check input");
		
		var colorErrorMessageElement = document.getElementById("error-message-color");
		var sizeErrorMessageElement = document.getElementById("error-message-size");
		
		colorErrorMessageElement.style.display = "";
		sizeErrorMessageElement.style.display = "";
		
		var isColor = false;
		var isSize = false;
		
		if (colorElements[0].value !== "null") {
			for (var i=0; i < colorElements.length; i++) {
				if (colorElements[i].checked == true) {
					isColor = true;
					break;
				}
			}
		} else {
			isColor = true;
		}
			
		if (isColor) {
			colorErrorMessageElement.style.display = "none";
		} 
		
		for (var i=0; i<sizeElements.length; i++) {
			if (sizeElements[i].checked == true) {
				isSize = true;
			}
		}
		if (isSize) {
			sizeErrorMessageElement.style.display = "none";
		}
		
		return isColor && isSize;
	}
	function goBuy() {
		if (checkForm()) {
			var orderForm = document.getElementById("form-order");
//			if (loginUserInfo != null) {
				orderForm.setAttribute("action", "orderForm.jsp");
				orderForm.submit();
//			} else {
//				orderForm.setAttribute("action", "../login.jsp");
//				orderForm.submit();
//			}
		}
	}
	function goCart() {
		if (checkForm()) {
			var orderForm = document.getElementById("form-order");
//			if (loginUserInfo != null) {
				orderForm.setAttribute("action", "cart.jsp");
				orderForm.submit();
//			} else {
//				orderForm.setAttribute("action", "../login.jsp");
//				orderForm.submit();
//			}
		}
	}

	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function changeOrderPrice() {
		var productAmount = document.getElementById("product-amount");
		var totalPrice = document.querySelector("#total-price");
		
		var productAmountText = productAmount.value;
		
		var productTotalPrice = numberWithCommas(productAmountText * <%=currentPrice %>
		)

			totalPrice.innerHTML = productTotalPrice;
	}

	var checkedWithProductNo = [];
	var index = 0;
	
	function withProductSelect(el) {
		var withProductSelectNo = el.getAttribute("value");
		var amountEl = document.getElementById("withAmount"
				+ withProductSelectNo);
		var colorEl = document.getElementById("withColor"
				+ withProductSelectNo);
		var sizeEl = document.getElementById("withSize"
				+ withProductSelectNo);
		
		var i = 0;
		
		for (var j=0; j < checkedWithProductNo.length; j++) {
			if (checkedWithProductNo[j] == withProductSelectNo) {
				i = j;
			} else {
				i = index;
			}
		}
		
		if (el.checked) {
			amountEl.disabled = false;
			colorEl.disabled = false;
			sizeEl.disabled = false;
			checkedWithProductNo[i] = withProductSelectNo;
			index += 1;
		} else {
			amountEl.disabled = true;
			colorEl.disabled = true;
			sizeEl.disabled = true;
			checkedWithProductNo[i] = null;
		}
		
	}
	
	function withCheckForm() {
		for (var i = 0; i < checkedWithProductNo.length; i++) {
			if (checkedWithProductNo[i]) {
				var amountEl = document.getElementById("withAmount" + checkedWithProductNo[i]);
				var colorEl = document.getElementById("withColor" + checkedWithProductNo[i]);
				var sizeEl = document.getElementById("withSize" + checkedWithProductNo[i]);
				
				if (amountEl.value === "null" || colorEl.value === "null" || sizeEl.value === "null") {
					alert("코디상품의 필수 옵션을 선택해주세요.");
					return false;
				} else {
					return true;
				}
			}
		}
	}
	
	function productWithProduct() {
		var colorElements = document.querySelectorAll("#color-check input");
		var sizeElements = document.querySelectorAll("#size-check input");
		
		var isColor = false;
		var isSize = false;
		
		if (colorElements[0].value !== "null") {
			for (var i=0; i < colorElements.length; i++) {
				if (colorElements[i].checked == true) {
					isColor = true;
					break;
				}
			}
		} else {
			isColor = true;
		}
		
		for (var i=0; i<sizeElements.length; i++) {
			if (sizeElements[i].checked == true) {
				isSize = true;
			}
		}
		
		if (isColor && isSize) {
			return true;
		} else {
			if (confirm("본상품의 옵션이 선택되지 않았습니다. 선택한 상품만 구매하시겠습니까?") == true){
				return true;
			 } else {  
			 	return false;
			 }
		}
	}

	function withGoBuy() {
		if (withCheckForm()) {
			if (productWithProduct()) {
				var orderForm = document.getElementById("form-order");
//				if (loginUserInfo != null) {
					orderForm.setAttribute("action", "orderForm.jsp");
					orderForm.submit();
//				} else {
//					orderForm.setAttribute("action", "../login.jsp");
//					orderForm.submit();
//				}
			}
		} 
	}
	function withGoCart() {
		if (withCheckForm()) {
			if (productWithProduct()) {
				var orderForm = document.getElementById("form-order");
//				if (loginUserInfo != null) {
					orderForm.setAttribute("action", "cart.jsp");
					orderForm.submit();
//				} else {
//					orderForm.setAttribute("action", "../login.jsp");
//					orderForm.submit();
//				}
			}
		} 
	}
	
	var reviewTextArea = "";
	
	function textAreaChange() {
		var reviewTextEl = document.getElementById("review-area");
		reviewTextArea = reviewTextEl.value;
		console.log(reviewTextArea);
	}
	
	function reviewRegister(event) {
		event.preventDefault();
		console.log(reviewTextArea);
		var reviewForm = document.getElementById("form-review");
		
		if (reviewTextArea === "") {
			alert("리뷰 메시지를 입력해주세요.");
		} else {
			reviewForm.submit();
		}
	}
	
	/* textarea(496line)에 onclick="reviewLoginCheck()" 추가
		function reviewLoginCheck(this) {
		if (confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?") == true){
			orderForm.setAttribute("action", "../login.jsp");
			orderForm.submit();
		 } else {  
		 	return false;
		 }
	} */
	</script>
</body>
</html>