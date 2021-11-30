<%@page import="semi.dto.OrderItemDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="semi.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
<style type="text/css">
	li.breadcrumb-item, .breadcrumb-item a, a.nav-link, a.hover {
		text-decoration: none;
		color: #757575;
		font-size: 14px;
	}
	
	.vintable tbody th, td {
		font-size: 12px;
	}
	
	.vintable tbody th {
 		border: 1px solid #ebebeb;
    	padding: 11px 0 10px 18px;
   		color: #757575;
    	font-weight: normal;
    	background-color: #fbfafa;
	}
	.vintable tbody td {
		padding: 11px 10px 10px;
	    border-top: 1px solid #ebebeb;
	    color: #757575;
	}	
	.vintable th:first-child{
	    border-left: none;
	}
 	
	.vintable, #vintable{
		border-bottom: 1px solid #ebebeb;
		line-height: 180%;
  		width: 100%;
  		margin: auto;
	}
	
	div h3 {
		font-weight: bold;
		font-size: 13px;
	}
	
	#vintable th, #vintable td {
    	padding: 11px;
	    color: #757575;
    	text-align: center;
	    font-size: 12px;
	}
	#vintable tbody td, #vintable > tfoot strong {
		color: black;
	}
	#vintable tr {
		border-top: 1px solid #e3e3e3;
	}
	#vintable thead, #vintable tfoot {
		border-top: 1px solid #e3e3e3;
		background-color: #fbfafa;
	}
	td img {
		width: 80px;
	}
	#guidance h4, li, p {
		color: #707070;
		font-size: 12px;
	}
</style>
</head>
<body>
<%@ include file="../common/navbar.jsp" %>
<%
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));

/* 로그인 없이 이 페이지에 접근하는 경우 */
/* 	if (loginUserInfo == null) {
		response.sendRedirect("loginform.jsp");		
		return;
	} */

	OrderDao orderDao = OrderDao.getinstance();

	/* login.jsp 완성시  loginUserInfo.getId() 넣기*/
	Map<String, Object> orderInfo = orderDao.getOrderInfo("osh", orderNo);
	List<OrderItemDto> orderItemDetail = orderDao.getOrderItemDetail(orderNo);
%>
<div class="container">    
	<!-- 브레드크럼 breadcrumb -->
	<div>
		<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		  <ol class="breadcrumb justify-content-end">
		    <li class="breadcrumb-item"><a href="#">HOME</a></li>
		    <li class="breadcrumb-item"><a href="#">MY PAGE</a></li>
		    <li class="breadcrumb-item active" aria-current="page">ORDER</li>
		  </ol>
		</nav>
	</div>
	<!-- header제목 -->
	<div class="text-center mt-5">
		<h5><strong>ORDER</strong></h5>
	</div>
	<!-- 주문 상세 정보 표 -->
	<!-- 주문정보 table -->
	<div class="my-5">
		<div>
			<h3>주문 정보</h3>
		</div>
		<div>
			<table class="vintable">
				<tbody>
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th>주문번호</th>
						<td><%=orderInfo.get("orderNo") %></td>
					</tr>
					<tr>
						<th>주문일자</th>
						<td></td>
					</tr>
					<tr>
						<th>주문자</th>
						<td>asdasd</td>
					</tr>
					<tr>
						<th>주문처리상태</th>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 결제정보 table -->
	<div class="my-5">
		<div>
			<h3>결제 정보</h3>
		</div>
		<div>
			<table class="vintable">
				<tbody>
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th>총 주문금액</th>
						<td></td>
					</tr>
					<tr>
						<th>총 결재금액</th>
<%
	int finalPrice = 0;
	if (400 < 50000) {
		finalPrice = 3000 + 400;
%>
						<td><%=finalPrice %></td>
<%
	} else {
%>
						<td></td>
<%		
	}
%>
					</tr>
					<tr>
						<th>결제수단</th>
						<td>asdasd</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 주문 상품 정보 -->
	<div>
		<div>
			<h3>주문 상품 정보</h3>
		</div>
		<div>
			<table id="vintable">
				<colgroup>
					<col width="10%">
					<col width="*">
					<col width="10%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th>이미지</th>
						<th>상품정보</th>
						<th>수량</th>
						<th>판매가</th>
						<th>기본배송</th>
						<th>주문처리상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><a href="../product/detail.jsp?no=?">img</a></td>
						<td>(빈스MADE) 에브리데이 양기모 후드집업 7color</td>
						<td>1</td>
						<td>48,500원</td>
						<td>기본배송</td>
						<td>주문완료</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6">
							<div class="d-flex justify-content-between">
								<div>
									[기본배송]
								</div>
								<div>
									상품구매금액 <strong>50,900</strong> + 배송비 0 = 합계 : 
									<strong class="px-3" style="font-size: 18px;">50,900원</strong>
								</div>
							</div>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	<!-- 배송지 정보 table -->
	<div class="my-5">
		<div>
			<h3>배송지정보</h3>
		</div>
		<div>
			<table class="vintable">
				<tbody>
					<colgroup>
						<col width="20%">
						<col width="*">
					</colgroup>
					<tr>
						<th>받으시는분</th>
						<td></td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td></td>
					</tr>
					<tr>
						<th>주소</th>
						<td>asdasd</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div>
		<a class="btn btn-dark opacity-75 m-1"></a>
	</div>
	<!-- 이용안내 메세지 -->
	<div id="guidance" class="my-5 border">
		<div class="m-3" style="background-color: #fbfafa;">
			<h3>이용안내</h3>
		</div>
		<div class="p-3 border-top">
			<h4>신용카드매출전표 발행 안내</h4>
			<ul style="list-style:none;">
				<li>신용카드 결제는 사용하는 PG사 명의로 발행됩니다.</li>
			</ul>
			<h4>세금계산서 발행 안내</h4>
			<ol>
				<li>부가가치세법 제 54조에 의거하여 세금계산서는 배송완료일로부터 다음달 10일까지만 요청하실 수 있습니다.</li>
				<li>세금계산서는 사업자만 신청하실 수 있습니다.</li>
				<li>배송이 완료된 주문에 한하여 세금계산서 발행신청이 가능합니다.</li>
				<li>[세금계산서 신청]버튼을 눌러 세금계산서 신청양식을 작성한 후 팩스로 사업자등록증사본을 보내셔야 세금계산서 발생이 가능합니다.	</li>
				<li>[세금계산서 인쇄]버튼을 누르면 발행된 세금계산서를 인쇄하실 수 있습니다.</li>
				<li>세금계산서는 실결제금액에 대해서만 발행됩니다.(적립금과 할인금액은 세금계산서 금액에서 제외됨)</li>
			</ol>
			<h4>부가가치세법 변경에 따른 신용카드매출전표 및 세금계산서 변경 안내</h4>
			<ol>
				<li>변경된 부가가치세법에 의거, 2004.7.1 이후 신용카드로 결제하신 주문에 대해서는 세금계산서 발행이 불가하며
					신용카드매출전표로 부가가치세 신고를 하셔야 합니다.(부가가치세법 시행령 57조)</li>
				<li>상기 부가가치세법 변경내용에 따라 신용카드 이외의 결제건에 대해서만 세금계산서 발행이 가능함을 양지하여 주시기 바랍니다.</li>
			</ol>
			<h4>현금영수증 이용안내</h4>
			<ol>
				<li>현금영수증은 1원 이상의 현금성거래(무통장입금, 실시간계좌이체, 에스크로, 예치금)에 대해 발행이 됩니다.</li>
				<li>현금영수증 발행 금액에는 배송비는 포함되고, 적립금사용액은 포함되지 않습니다.</li>
				<li>발행신청 기간제한 현금영수증은 입금확인일로 부터 48시간안에 발행을 해야 합니다.</li>
				<li>현금영수증 발행 취소의 경우는 시간 제한이 없습니다. (국세청의 정책에 따라 변경 될 수 있습니다.)</li>
				<li>현금영수증이나 세금계산서 중 하나만 발행 가능 합니다.</li>
			</ol>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>