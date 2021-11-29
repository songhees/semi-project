<%@page import="java.util.List"%>
<%@page import="semi.vo.Product"%>
<%@page import="semi.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>핸드메이드 벨티드 울 롱코트 3color - 빈스데이</title>  
</head>
<style>
	.detail_list_img ul li {
		display: inline;
	}
	.btn_list li {
		display: inline;
	}
</style>
<body>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	
	ProductDao productDao = ProductDao.getInstance();
	Product product = productDao.getProductDetail(no);
	
	List<String> thumbnails = productDao.getProductThumbnailImage(no);
	
%>
<%@ include file="../common/navbar.jsp" %>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="d-flex justify-content-end">
				<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="/semi-prodject/index.jsp" style="text-decoration: none; color: gray;">Home</a></li>
						<li class="breadcrumb-item active" aria-current="page"><%=product.getProductCategory().getName() %></li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	<div class="detailArea">
		<div class="row">
			<div class="col-md-6">
				<div class="detail_big_img">
					<img src="<%=thumbnails.get(0)%>" alt="productImg" class="big_img img-fluid">
				</div> 
				<div class="detail_list_img">
					<ul class="thumb_img p-0 mt-3" style="list-style: none">
<%
	for (String thumbnail : thumbnails) {
%>
						<li><img src="<%=thumbnail %>" style="width: 75px" class="img-fluid" alt="productImg"></li>
<%
	}
%>
					</ul>
				</div>
			</div>
			<div class="col-md-5">
				<h5><%=product.getName() %></h5>
				<hr class="mt-4 mb-3">
				<form>
					<table class="table table-borderless">
						<tr>
<%
	if (product.getDiscountPrice() == 0) {
%>
							<td>판매가</td>
							<td><%=product.getPrice() %>원</td>
<%
	} else {
%>
							<td>소비자가</td>
							<td class="text-decoration-line-through"><%=product.getPrice() %>원</td>
						</tr>
						<tr>
							<td>판매가</td>
							<td><%=product.getDiscountPrice() %>원</td>
<%
	}
%>
						</tr>
						<tr>
							<td>색상</td>
							<td>
								<div class="form-check form-check-inline p-0 m-0">
									<input type="radio" class="btn-check" id="btn-check-outlined1" name="color" value="red">
									<label class="btn btn-outline-secondary" for="btn-check-outlined1">red</label>
								</div>
								<div class="form-check form-check-inline p-0 m-0">
									<input type="radio" class="btn-check" id="btn-check-outlined2" name="color" value="blue">
									<label class="btn btn-outline-secondary" for="btn-check-outlined2">blue</label>
								</div>
								<div class="form-check form-check-inline p-0 m-0">
									<input type="radio" class="btn-check" id="btn-check-outlined3" name="color" value="green">
									<label class="btn btn-outline-secondary" for="btn-check-outlined3">green</label>
								</div>
								<P>[필수] 옵션을 선택해 주세요</P>
							</td>
						<tr>
							<td>사이즈</td>
							<td>
								<div class="form-check form-check-inline p-0 m-0">
									<input type="radio" class="btn-check" id="btn-check-outlined4" name="size" value="l">
									<label class="btn btn-outline-secondary" for="btn-check-outlined4">L</label>
								</div>
								<div class="form-check form-check-inline p-0 m-0">
									<input type="radio" class="btn-check" id="btn-check-outlined5" name="size" value="m">
									<label class="btn btn-outline-secondary" for="btn-check-outlined5">M</label>
								</div>
								<div class="form-check form-check-inline p-0 m-0">
									<input type="radio" class="btn-check" id="btn-check-outlined6" name="size" value="s">
									<label class="btn btn-outline-secondary" for="btn-check-outlined6">S</label>
								</div>
								<P>[필수] 옵션을 선택해 주세요</P>
							</td>
						</tr>
					</table>
				</form>
				<hr class="mt-3">
				<div class="d-flex justify-content-between mt-4 mb-4">
					<div>
						<strong>총 상품금액</strong>(수량) : 
					</div>
					<div>
						<strong>10000원</strong>(1개)
					</div>
				</div>
				<div>
					<ul class="btn_list p-0" style="list-style: none">
						<li><button type="button" class="btn btn-secondary btn-lg" type="submit"><span class="fs-6">BUY IT NOW</span></button></li>
						<li><button type="button" class="btn btn-outline-secondary btn-lg" type="submit"><span class="fs-6">CART</span></button></li>
						<li><button type="button" class="btn btn-outline-secondary btn-lg" type="submit"><span class="fs-6">WISH</span></button></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="d-flex justify-content-center mt-5 mb-4">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">상품상세정보</a></li>
					<li class="nav-item"><a class="nav-link" href="#">쇼핑가이드</a></li>
					<li class="nav-item"><a class="nav-link" href="#">코디상품</a></li>
					<li class="nav-item"><a class="nav-link" href="#">구매후기</a></li>
					<li class="nav-item"><a class="nav-link" href="#">상품문의</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col">
			<div class="d-flex flex-column bd-highlight mb-3">
				<div class="p-5 bd-highlight d-flex justify-content-center">
					<p>고급스럽고 세련된 로브 스타일의 오픈 형식인 울 블렌디드 핸드메이드 코트를 소개해드려요 *.*</p>
				</div>
				<div class="p-2 bd-highlight d-flex justify-content-center">
					<img src="../resources/images/product/1000/detail/1000_1.jpg" alt="productimg" class="big_img img-fluid">
				</div>
				<div class="p-2 bd-highlight d-flex justify-content-center">
					<img src="../resources/images/product/1000/detail/1000_2.jpg" alt="productimg" class="big_img img-fluid">
				</div>
				<div class="p-2 bd-highlight d-flex justify-content-center">
					<img src="../resources/images/product/1000/detail/1000_3.jpg" alt="productimg" class="big_img img-fluid">
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="d-flex justify-content-center mt-5 mb-4">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="#">상품상세정보</a></li>
					<li class="nav-item"><a class="nav-link  active" href="#">쇼핑가이드</a></li>
					<li class="nav-item"><a class="nav-link" href="#">코디상품</a></li>
					<li class="nav-item"><a class="nav-link" href="#">구매후기</a></li>
					<li class="nav-item"><a class="nav-link" href="#">상품문의</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="border" style="padding: 50px; ">
				<h3>상품결제정보</h3>
				고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다. 확인과정에서 도난 카드의 사용이나 타인 명의의
				주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다. &nbsp; <br>
				<br> 무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면
				됩니다. &nbsp;<br> 주문시 입력한&nbsp;입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 2일
				이내로 입금을 하셔야 하며&nbsp;입금되지 않은 주문은 자동취소 됩니다.
				<hr class="mt-4 mb-4">
				<h3>배송정보</h3>
				배송 업체 : 우체국택배 (1588-1300)
				<br>배송 기간 : 3~7일 (주말, 공휴일 포함)
				<br>배송 비용 : 5만원 이상 구매시 무료배송 / 5만원 미만 배송비 3,000원 추가
				<br>- 주문 폭주, 입고 지연 등 거래처 사정에 따라 더 지연되거나 품절될 수 있는 점 양해부탁드립니다
				<br>- 제주도, 도서, 산간지역일 경우 추가 운임비가 발생할 수 있으며, 평균 배송일보다 1~2일 더 소요될
				수 있습니다
				<hr class="mt-4 mb-4">
				<h3>교환 및 반품정보</h3>
				<strong><ins>교환 및 반품 주소</ins></strong><br>(우:06779) 서울특별시 서초구
				동산로19 (서울서초우체국) 소포실<strong><br></strong><br>
				<strong><ins>교환 및 반품 의사</ins></strong><br>상품 수령일로부터 7일 이내 반드시
				고객센터를 통해 교관 및 반품 의사를 밝혀주시고 반품 신청해주세요<br>교환 및 반품 시 받아보신 상태 동일하게
				(박스, 폴리백, 사은품 등) 박스에 잘 넣어서 함께 보내주시면 됩니다<br>
				<br>
				<ins><strong>교환 및 반품 배송비</strong></ins>
				<br>﻿단순 변심에 의한 교환 또는 무료 배송 상품인 경우 : 왕복 6,000원 고객 부담<br>단순
				변심에 의한 반품인 경우 : 3,000원 고객 부담<br>
				<br>불량 및 오배송인 경우는 빈스데이에서 배송비 부담하며 새 제품 또는 환불 진행해드립니다<br>우체국
				택배가 아닌 타 택배사를 이용하는 경우는 고객님 부담 선불 발송을 해주셔야 합니다<br>환불금에서 차감이나 동봉
				해주시면 되는데 분실우려가 있으므로 "환불금에서 차감"을 추천드립니다<br>
				<br> <strong><ins>교환 및 반품이 불가능한 경우</ins></strong><br> 상품
				수령 후 7일 이상 지난 경우<br>고객 부주의로 인한 상품의 변형, 훼손되어 상품 가치가 상실된 경우<br>착용
				흔적이 있는 경우 (택제거, 향수 냄새, 담배 냄새, 화장품 흔적 등)<br>수선 또는 세탁한 상품<br>
				﻿<br>
				<strong><ins>구매 전 필독 사항</ins></strong><br>사이즈는 재는 위치에 따라 1~3cm의
				오차가 발생할 수 있습니다<br>패턴이 있을 경우 재단의 위치에 따라 모양이나 위치가 옷마다 조금식 다를 수
				있습니다.<br>마감 부분에 실밥이나 초크 자국이 남아있을 수 있습니다<br>데님 소재, 컬러 상품은
				밝은 색상의 상품과 착용하거나 첫 세탁시 이염 또는 물 빠짐이 발생할 수 있습니다<br>사진 색상의 경우 자연광과
				조명 색상의 영향으로 실제 컬러와 다를 수 있습니다<br>
				<br>* 위에 사유로는 상품 불량에 해당하지 않기 때문에 구매 전 상세정보, 디테일 이미지를 꼭 확인해주시길
				바랍니다<br>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="d-flex justify-content-center mt-5 mb-4">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="#">상품상세정보</a></li>
					<li class="nav-item"><a class="nav-link" href="#">쇼핑가이드</a></li>
					<li class="nav-item"><a class="nav-link active" href="#">코디상품</a></li>
					<li class="nav-item"><a class="nav-link" href="#">구매후기</a></li>
					<li class="nav-item"><a class="nav-link" href="#">상품문의</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col">
			<div class="d-flex justify-content-center mt-5 mb-4">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="#">상품상세정보</a></li>
					<li class="nav-item"><a class="nav-link" href="#">쇼핑가이드</a></li>
					<li class="nav-item"><a class="nav-link" href="#">코디상품</a></li>
					<li class="nav-item"><a class="nav-link active" href="#">구매후기</a></li>
					<li class="nav-item"><a class="nav-link" href="#">상품문의</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col">
			<div class="d-flex justify-content-center mt-5 mb-4">
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link"
						aria-current="page" href="#">상품상세정보</a></li>
					<li class="nav-item"><a class="nav-link" href="#">쇼핑가이드</a></li>
					<li class="nav-item"><a class="nav-link" href="#">코디상품</a></li>
					<li class="nav-item"><a class="nav-link" href="#">구매후기</a></li>
					<li class="nav-item"><a class="nav-link active" href="#">상품문의</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<h6 align="center"><strong>Q&amp;A</strong></h6>
			<h6 align="center">상품에 대해 궁금한 점을 해결해 드립니다.</h6>
			<div class="d-flex justify-content-center mt-5 mb-4">
				<table class="table">
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
						<tr>
							<td>209</td>
							<td>교환/반품/취소문의</td>
							<td>아직 반품 물품 회수가 안됐어요</td>
							<td>한**</td>
							<td>2017-11-19</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>