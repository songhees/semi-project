<%@page import="java.util.Arrays"%>
<%@page import="semi.dao.ProductDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="semi.vo.Address"%>
<%@page import="semi.dao.AddressDao"%>
<%@page import="semi.vo.User"%>
<%@page import="semi.criteria.ProductItemCriteria"%>
<%@page import="java.util.ArrayList"%>
<%@page import="semi.vo.ProductItem"%>
<%@page import="java.util.List"%>
<%@page import="semi.dao.ProductItemDao"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
	<title>빈스데이</title>
	<style type="text/css">
		body {
			background-color: #e8e8e8;
		}
	</style>
</head>
<body>
<%
	String from = StringUtils.defaultString(request.getParameter("from"), "");
	String[] productItemNumbers;
	String[] productItemQuantities;
	String[] productNumbers;
	String[] productItemColors;
	String[] productItemSizes;
	
	User user = (User)session.getAttribute("LOGIN_USER_INFO");

	// 잘못된 접근일 경우
	if ((!"cart".equals(from) && !"detail".equals(from)) || user == null) {
%>
	<h2 class="text-center mt-5">잘못된 접근입니다.</h2>
<%
	} else {
		ProductItemDao productItemDao = ProductItemDao.getInstance();
		List<ProductItem> productItems = new ArrayList<>();
		
		// 장바구니 페이지에서 왔을 경우
		if ("cart".equals(from)) {
			productItemNumbers = request.getParameterValues("no");
			productItemQuantities = request.getParameterValues("amount");
			
			for (String productItemNoString : productItemNumbers) {
				int productItemNo = Integer.parseInt(productItemNoString);
				productItems.add(productItemDao.getProductItemByProductItemNo(productItemNo));
			}
		// 제품상세 페이지에서 왔을 경우
		} else {
			productNumbers = request.getParameterValues("no");
			productItemColors = request.getParameterValues("color");
			productItemSizes = request.getParameterValues("size");
			productItemQuantities = request.getParameterValues("amount");
			
			for (int i = 0; i < productNumbers.length; i++) {
				int productNo = Integer.parseInt(productNumbers[i]);
				String productItemColor = productItemColors[i];
				String productItemSize = productItemSizes[i];
				
				ProductItemCriteria productItemCriteria = new ProductItemCriteria();
				productItemCriteria.setProductNo(productNo);
				productItemCriteria.setColor(productItemColor);
				productItemCriteria.setSize(productItemSize);
				
				productItems.add(productItemDao.getProductItemByProductItemCriteria(productItemCriteria));
			}
		}
		
		// 주문수량이 상품의 재고보다 많은 것이 하나라도 있으면 false인 변수이다.
		boolean isStockAvailable = true;
		AddressDao addressDao = AddressDao.getInstance();
		ProductDao productDao = ProductDao.getInstance();
		
		List<Address> addresses = addressDao.getAllAddressByUserNo(user.getNo());
		boolean addressIsEmpty = addresses.isEmpty();
%>
<input id="numberOfProductItems" type="hidden" value="<%=productItems.size()%>">
<input type="hidden" name="from" value="orderForm">
<div class="container"> 
	<form id="order-form" method="post" action="order.jsp" onsubmit="checkSubmit(event)">
		<div class="row justify-content-center">
			<div class="col-10">
				<label class="col-12 col-form-label text-center p-3" style="font-size: 1.2rem; color: white; background-color: #404040"><strong>주문/결제</strong></label>
				<div class="accordion accordion-flush border p-0" id="accordionExample1">
		  			<div class="accordion-item">
		    			<h2 class="accordion-header" id="heading1">
		      				<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse1" aria-expanded="true" aria-controls="collapse1" style="font-size: 1.2rem; color: black; background-color: white;">
		      					<strong>배송지</strong>
		      				</button>
		    			</h2>
		    			<div id="collapse1" class="accordion-collapse collapse show" aria-labelledby="heading1" data-bs-parent="#accordionExample1">
		      				<div class="accordion-body px-3">
		      					<ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
									<li class="nav-item" role="presentation">
								    	<button class="nav-link active" id="addressList-tab" data-bs-toggle="tab" data-bs-target="#addressList"
								    	 type="button" role="tab" aria-controls="addressList" aria-selected="<%=addressIsEmpty ? "false" : "true"%>" style="color: black; <%=addressIsEmpty ? "display: none;" : ""%>">최근 배송지</button>
									</li>
								  	<li class="nav-item" role="presentation">
								    	<button class="nav-link" id="enterYourself-tab" data-bs-toggle="tab" data-bs-target="#enterYourself"
								    	 type="button" role="tab" aria-controls="enterYourself" aria-selected="<%=addressIsEmpty ? "true" : "false"%>" style="color: black;">직접입력</button>
								  	</li>
								</ul>
								<div class="tab-content" id="myTabContent">
									<div class="tab-pane fade <%=addressIsEmpty ? "" : "show active"%>" id="addressList" role="tabpanel" aria-labelledby="addressList-tab">
										<%
											if (!addressIsEmpty) {
												Address defaultAddress = null;
												Iterator<Address> addressIter = addresses.iterator();
												
												while (addressIter.hasNext()) {
													Address address = addressIter.next();
													String addressDefault = address.getAddressDefault();
													if ("Y".equals(addressDefault)) {
														defaultAddress = address;
														addressIter.remove();
													}
												}
												
												if (defaultAddress != null) {
										%>
										<hr>
										<div id="addressDefault" class="row justify-content-between">
											<input type="hidden" name="addressName" value="<%=defaultAddress.getAddressName()%>">
											<input type="hidden" name="postalCode" value="<%=defaultAddress.getPostalCode()%>">
				      						<input type="hidden" name="baseAddress" value="<%=defaultAddress.getBaseAddress()%>">
				      						<input type="hidden" name="addressDetail" value="<%=defaultAddress.getDetail()%>">
			      							<div class="col-10">
				      							<h6><strong>[기본] <%=user.getName()%></strong></h6>
				      							<h6 class="text-muted">
													[<%=defaultAddress.getPostalCode()%>] <%=defaultAddress.getBaseAddress()%><br>
													<%=defaultAddress.getDetail()%>
												</h6>
				      							<h6 class="text-muted">
													<%=user.getTel()%>
												</h6>
			      							</div>
			      							<div class="col-2 align-self-center">
				      							<div class="form-check">
			  										<input type="radio" name="flexRadio1" id="addressDefault-radio" checked>
												</div>
			      							</div>
			      						</div>
			      						<%
												}
												if (!addresses.isEmpty()) {
													int i = 0;
													for (Address address : addresses) {
			      						%>
										<hr>
										<div id="address<%=i%>" class="row justify-content-between">
				      						<input type="hidden" name="addressName" value="<%=address.getAddressName()%>">
				      						<input type="hidden" name="postalCode" value="<%=address.getPostalCode()%>">
				      						<input type="hidden" name="baseAddress" value="<%=address.getBaseAddress()%>">
				      						<input type="hidden" name="addressDetail" value="<%=address.getDetail()%>">
			      							<div class="col-10">
				      							<h6><strong><%=user.getName()%></strong></h6>
				      							<h6 class="text-muted">
													[<%=address.getPostalCode()%>] <%=address.getBaseAddress()%><br>
													<%=address.getDetail()%>
												</h6>
				      							<h6 class="text-muted">
													<%=user.getTel()%>
												</h6>
			      							</div>
			      							<div class="col-2 align-self-center">
				      							<div class="form-check">
			  										<input class="addresses-radio" type="radio" name="flexRadio1" id="addressRadio<%=i%>">
												</div>
			      							</div>
			      						</div>
			      						<%
														i++;
													}
												}
											}
				        				%>
			      						<div class="row py-3 mt-3 border" style="background-color: #f7f7f7">
				        					<div class="col">
				        						<select class="form-select" name="emailDomain">
						  							<option value="" selected>-- 메시지 선택 (선택사항) --</option>
													<option value="">배송 전에 미리 연락바랍니다.</option>
													<option value="">부재 시 경비실에 맡겨주세요.</option>
												</select>
				        					</div>
				        				</div>
									</div>
									<div class="tab-pane fade <%=addressIsEmpty ? "show active" : ""%>" id="enterYourself" role="tabpanel" aria-labelledby="enterYourself-tab">
				        				<div class="row mt-4 mb-2">
				        					<label class="col-2 col-form-label">받는사람</label>
				        					<div class="col-10">
												<input type="text" name="receivePerson" class="form-control" value="<%=user.getName()%>">
											</div>
				        				</div>
				        				<div class="row mb-2">
				        					<label class="col-2 col-form-label">주소</label>
				        					<div class="col-2">
												<input id="postalCode" type="text" name="postalCode" class="form-control" disabled readonly>
											</div>
				        					<div class="col-2">
				        						<input type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="주소검색">
											</div>
				        				</div>
				        				<div class="row justify-content-end mb-2">
				        					<div class="col-10">
												<input id="baseAddress" type="text" name="baseAddress" class="form-control">
											</div>
				        				</div>
				        				<div class="row justify-content-end mb-2">
				        					<div class="col-10">
												<input id="detailAddress" type="text" name="detailAddress" class="form-control">
											</div>
				        				</div>
				        				<div class="row mb-2">
				        					<label class="col-2 col-form-label">휴대전화</label>
				        					<div class="col-10">
				        						<%
				        							String tel = user.getTel();
				  									String[] telArray = tel.split("-");
				        						%>
				        						<select class="form-select" name="firstPhoneNumber" style="width: 28%; display: inline;">
						  							<option value="010" <%="010".equals(telArray[0]) ? "selected" : ""%>>010</option>
													<option value="011" <%="011".equals(telArray[0]) ? "selected" : ""%>>011</option>
													<option value="016" <%="016".equals(telArray[0]) ? "selected" : ""%>>016</option>
													<option value="017" <%="017".equals(telArray[0]) ? "selected" : ""%>>017</option>
													<option value="018" <%="018".equals(telArray[0]) ? "selected" : ""%>>018</option>
													<option value="019" <%="019".equals(telArray[0]) ? "selected" : ""%>>019</option>
												</select>
				        						<label style="width: 5%; display: inline;">-</label>
												<input type="number" name="middlePhoneNumber" class="form-control" style="width: 28%; display: inline;" value=<%=telArray[1]%>>
												<label style="width: 5%; display: inline;">-</label>
												<input type="number" name="lastPhoneNumber" class="form-control" style="width: 28%; display: inline;" value=<%=telArray[2]%>>
											</div>
				        				</div>
				        				<div class="row mb-1">
				        					<%
				        						String email = user.getEmail();
				        						String[] emailArray = email.split("@");
				        					%>
				        					<label class="col-2 col-form-label">이메일</label>
				        					<div class="col-10">
				        						<input type="text" name="emailLocalPart" class="form-control" style="width: 28%; display: inline;" value=<%=emailArray[0]%>>
												<label style="width: 5%; display: inline;">@</label>
				        						<select class="form-select" name="emailDomain" style="width: 28%; display: inline;">
						  							<option value="" selected>-이메일 선택-</option>
													<option value="naver.com" <%="naver.com".equals(emailArray[1]) ? "selected" : ""%>>naver.com</option>
													<option value="gmail.com" <%="gmail.com".equals(emailArray[1]) ? "selected" : ""%>>gmail.com</option>
												</select>
				        					</div>
				        				</div>
				        				<div class="row justify-content-end mb-3">
				        					<div class="col-10">
												<label class="text-muted" style="font-size: 0.75rem;">
													이메일로 주문 처리 과정을 보내드립니다.<br>
													수신 가능한 이메일 주소를 입력해 주세요.
												</label>
											</div>
				        				</div>
				        				<div class="row py-3 border" style="background-color: #f7f7f7">
				        					<div class="col">
				        						<select class="form-select" name="emailDomain">
						  							<option value="" selected>-- 메시지 선택 (선택사항) --</option>
													<option value="">배송 전에 미리 연락바랍니다.</option>
													<option value="">부재 시 경비실에 맡겨주세요.</option>
												</select>
				        					</div>
				        				</div>
				        				<div class="row mt-3 mb-2">
				        					<div class="col-12">
				        						<div class="form-check">
													<input class="form-check-input" type="checkbox" value="">
													<label class="form-check-label" for="flexCheckDefault">
														기본 배송지로 저장
													</label>
												</div>
				        					</div>
				        				</div>
									</div>
								</div>
		      				</div>
		    			</div>
		  			</div>
				</div>
				<div class="accordion accordion-flush border p-0 mt-2" id="accordionExample2">
		  			<div class="accordion-item">
		    			<h2 class="accordion-header" id="heading2">
		      				<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="true" aria-controls="collapse2" style="font-size: 1.2rem; color: black; background-color: white;">
		      					<strong>주문상품</strong>
		      				</button>
		    			</h2>
		    			<div id="collapse2" class="accordion-collapse collapse" aria-labelledby="heading2" data-bs-parent="#accordionExample2">
		      				<div class="accordion-body px-3">
		      					<%
		      						int i = 0;
		      						for (ProductItem productItem : productItems) {
		      							boolean isQuantityOverStock = Integer.parseInt(productItemQuantities[i]) > productItem.getStock();
		      							if (isQuantityOverStock) {
		      								isStockAvailable = false;
		      							}
		      					%>
		      					<div id="productItem<%=i%>" class="card p-0" style="border: none;">
			      					<input type="hidden" name="no" value="<%=productItem.getNo()%>">
			      					<input class="productItemQuantity" type="hidden" name="amount" value="<%=productItemQuantities[i]%>">
		      						<div class="row mb-3 justify-content-between">
		      							<div class="col-2">
		      								<a href="/semi-project/product/detail.jsp?no=<%=productItem.getProduct().getNo()%>">
											<img class="img-fluid rounded-start" src="/semi-project/resources/images/product/<%=productDao.getProductThumbnailImageList(productItem.getProduct().getNo()).isEmpty() ? 1000 : productItem.getProduct().getNo()%>/thumbnail/<%=productDao.getProductThumbnailImageList(productItem.getProduct().getNo()).isEmpty() ? 1000 : productItem.getProduct().getNo()%>_1.jpg">
										</a>
		      							</div>
		      							<div class="col-8 p-0">
		      								<div class="card-body">
		      									<h6 class="card-title"><%=productItem.getProduct().getName() %></h6>
		      									<p class="card-text text-muted" style="font-size: 0.85rem;">
													[옵션: <%=productItem.getColor()%>/<%=productItem.getSize()%>]<br>
													수량: <%=isQuantityOverStock ? "<s>" : "" %><%=productItemQuantities[i]%><%=isQuantityOverStock ? "</s>" : "" %>개<%=isQuantityOverStock ? "<mark><strong>(재고 초과)</strong></mark>" : "" %><br>
													상품구매금액: <span class="productItemPrice"><%=productItem.getProduct().getPrice()%></span>원<br>
													[<span class="freeDeliveryCharge"></span>] / 기본배송
												</p>
		      								</div>
		      							</div>
		      							<div class="col-2 align-self-center">
		      								<button class="btn btn-danger" type="button" onclick="deleteProductItem(<%=i%>)">삭제</button>
		      							</div>
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
		      	<div class="accordion accordion-flush border p-0 mt-2" id="accordionExample3">
		  			<div class="accordion-item">
		    			<h2 class="accordion-header" id="heading3">
		      				<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse3" aria-expanded="true" aria-controls="collapse3" style="font-size: 1.2rem; color: black; background-color: white;">
		      					<strong>할인/부가결제</strong>
		      				</button>
		    			</h2>
		    			<div id="collapse3" class="accordion-collapse collapse show" aria-labelledby="heading3" data-bs-parent="#accordionExample3">
		      				<div class="accordion-body pt-3">
		      					<div class="row mb-1 justify-content-between">
		        					<label class="col-2 col-form-label">적립금</label>
		        					<label class="col-2 col-form-label text-end text-muted" style="font-size: 0.85rem;">(사용 가능 <strong><span id="availablePoint"><%=user.getPoint()%></span>원</strong>)</label>
		        				</div>
		        				<div class="row mb-1">
		        					<div class="col-10">
		        						<input id="usingPoint" name="usingPoint" type="number" class="form-control" onchange="checkUsingPoint(this)">
		        					</div>
		        					<div class="col-2 d-grid">
		        						<button class="btn btn-secondary" type="button" onclick="useAllPoint()">전액 사용</button>
		        					</div>
		        				</div>
		        				<div class="accordion accordion-flush p-0 mt-2" id="accordionExample4">
		  							<div class="accordion-item">
		    							<h2 class="accordion-header" id="heading4">
		      								<button class="accordion-button btn-light text-muted" type="button" data-bs-toggle="collapse" data-bs-target="#collapse4" aria-expanded="true" aria-controls="collapse4" style="font-size: 0.85rem; color: black; background-color: white;">
					      						최소 적립금 0원 이상일 때 사용 가능합니다.
					      					</button>
					    				</h2>
					    				<div id="collapse4" class="accordion-collapse collapse" aria-labelledby="heading4" data-bs-parent="#accordionExample4">
					      					<div class="accordion-body px-3">
						      					<p class="card-text text-muted" style="font-size: 0.85rem;">
													포인트는 결제금액 이하로만 사용 가능합니다.<br>
													적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.
												</p>
					      					</div>
					      				</div>
					      			</div>
					      		</div>
					      		<div class="row py-1 justify-content-between" style="font-size: 1.2rem; background-color: #eff1f4;">
			        				<label class="col-2 col-form-label py-1"><strong>적용금액</strong></label>
			        				<label class="col-2 col-form-label py-1 text-end"><strong>-<span id="discountAmount">0</span>원</strong></label>
				        		</div>
			      			</div>
			      		</div>
			      	</div>
				</div>
				<div class="accordion accordion-flush border p-0 mt-2" id="accordionExample5">
				  	<div class="accordion-item">
				    	<h2 class="accordion-header" id="heading5">
				      		<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse5" aria-expanded="true" aria-controls="collapse5" style="font-size: 1.2rem; color: black; background-color: white;">
				      			<strong>결제정보</strong>
				      		</button>
				    	</h2>
				    	<div id="collapse5" class="accordion-collapse collapse show" aria-labelledby="heading5" data-bs-parent="#accordionExample5">
				      		<div class="accordion-body px-4">
				      			<div class="row justify-content-between">
			        				<label class="col-2 col-form-label py-1">주문상품</label>
			        				<label class="col-2 col-form-label py-1 text-end"><span id="totalProductPrice"></span>원</label>
				        		</div>
				      			<div class="row justify-content-between">
			        				<label class="col-2 col-form-label py-1">할인/부가결제</label>
			        				<label class="col-2 col-form-label py-1 text-end">-<span id="totalDiscount">0</span>원</label>
				        		</div>
				      			<div class="row mb-2 justify-content-between">
			        				<label class="col-2 col-form-label py-1">배송비</label>
			        				<label class="col-2 col-form-label py-1 text-end">+<span id="totalDeliveryCharge"></span>원</label>
				        		</div>
				      			<div class="row py-1 justify-content-between" style="font-size: 1.2rem; background-color: #eff1f4;">
			        				<label class="col-2 col-form-label py-1"><strong>결제금액</strong></label>
			        				<label class="col-2 col-form-label py-1 text-end"><strong><span id="totalAmount"></span>원</strong></label>
			        				<input id="totalAmount-input" type="hidden" name="totalAmount" value="">
				        		</div>
				      		</div>
				      	</div>
					</div>
				</div>
				<div class="accordion accordion-flush border p-0 mt-2" id="accordionExample6">
				  	<div class="accordion-item">
				    	<h2 class="accordion-header" id="heading6">
				      		<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse6" aria-expanded="true" aria-controls="collapse6" style="font-size: 1.2rem; color: black; background-color: white;">
				      			<strong>결제수단</strong>
				      		</button>
				    	</h2>
				    	<div id="collapse6" class="accordion-collapse collapse show" aria-labelledby="heading6" data-bs-parent="#accordionExample6">
				      		<div class="accordion-body px-4">
				      			<div class="row border">
				      				<label class="col col-form-label py-2"><strong>결제수단 선택</strong></label>
				      			</div>
				      			<div class="row border-start border-end border-bottom">
				      				<div class="col py-2">
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="paymentMethod" id="flexRadioDefault1" checked>
		  									<label class="form-check-label" for="flexRadioDefault1">무통장입금</label>
										</div>
										<!-- 미구현
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadio2" id="flexRadioDefault1">
		  									<label class="form-check-label" for="flexRadioDefault1">신용카드</label>
										</div>
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadio2" id="flexRadioDefault1">
		  									<label class="form-check-label" for="flexRadioDefault1">휴대폰</label>
										</div>
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadio2" id="flexRadioDefault1">
		  									<label class="form-check-label" for="flexRadioDefault1">카카오페이</label>
										</div>
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadio2" id="flexRadioDefault1">
		  									<label class="form-check-label" for="flexRadioDefault1">에스크로(실시간 계좌이체)</label>
										</div>
										 -->
		        					</div>
				      			</div>
				      			<div class="row mb-2 mt-4">
		        					<label class="col-2 col-form-label">입금은행</label>
		        					<div class="col-10">
										<select class="form-select" name="depositBank" required>
				  							<option value="" selected>::: 선택해 주세요. :::</option>
											<option value="농협">농협:1234567890123 빈스</option>
										</select>
									</div>
		        				</div>
				      			<div class="row mb-2">
		        					<label class="col-2 col-form-label">입금자명</label>
		        					<div class="col-10">
										<input type="text" name="depositPersonName" class="form-control" required>
									</div>
		        				</div>
		        				<!-- 미구현
				      			<div class="row mb-1 mt-4">
		        					<label class="col col-form-label"><strong>현금영수증</strong></label>
		        				</div>
		        				<div class="row mb-2">
		        					<div class="col">
										<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadio3" id="flexRadioDefault1">
		  									<label class="form-check-label" for="flexRadioDefault1">현금영수증 신청</label>
										</div>
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadio3" id="flexRadioDefault1" checked>
		  									<label class="form-check-label" for="flexRadioDefault1">신청안함</label>
										</div>
									</div>
		        				</div>
		        				 -->
		        				<!-- 미구현
		        				<div class="row py-3 border" style="background-color: #f7f7f7">
		        					<div class="col">
		        						<div class="form-check">
											<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
											<label class="form-check-label" for="flexCheckDefault">
										  		결제수단과 입력정보를 다음에도 사용
											</label>
										</div>
		        					</div>
		        				</div>
		        				 -->
				      		</div>
				      	</div>
					</div>
				</div>
				<div class="accordion accordion-flush border p-0 mt-2" id="accordionExample7">
				  	<div class="accordion-item">
				    	<h2 class="accordion-header" id="heading7">
				      		<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse7" aria-expanded="true" aria-controls="collapse7" style="font-size: 1.2rem; color: black; background-color: white;">
				      			<strong>적립 혜택</strong>
				      		</button>
				    	</h2>
				    	<div id="collapse7" class="accordion-collapse collapse" aria-labelledby="heading7" data-bs-parent="#accordionExample7">
				      		<div class="accordion-body px-4">
				      			<div class="row justify-content-between">
			        				<label class="col-2 col-form-label py-1">상품별 적립금</label>
			        				<label class="col-2 col-form-label py-1 text-end"><span id="totalProductPoint"></span>원</label>
				        		</div>
				      			<!-- 미구현
				      			<div class="row justify-content-between">
			        				<label class="col-2 col-form-label py-1">회원 적립금</label>
			        				<label class="col-2 col-form-label py-1 text-end">150원</label>
				        		</div>
				      			<div class="row mb-2 justify-content-between">
			        				<label class="col-2 col-form-label py-1">쿠폰 적립금</label>
			        				<label class="col-2 col-form-label py-1 text-end">0원</label>
				        		</div>
				        		 -->
				      			<div class="row py-1 justify-content-between" style="font-size: 1.2rem; background-color: #eff1f4;">
			        				<label class="col-2 col-form-label py-1"><strong>적립 예정금액</strong></label>
			        				<label class="col-2 col-form-label py-1 text-end"><strong><span id="totalPoint"></span>원</strong></label>
			        				<input id="totalPoint-input" type="hidden" name="totalPoint" value="">
				        		</div>
				      		</div>
				      	</div>
					</div>
				</div>
				<div class="border p-4 mt-2" style="background-color: white;">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" id="agreeAllTerms-checkbox" onclick="agreeAllTerms()">
						<label class="form-check-label" for="flexCheckDefault"><strong>모든 약관 동의</strong></label>
					</div>
					<hr>
					<div class="form-check">
						<input class="form-check-input" type="checkbox" id="agreePurchaseCondition-checkbox" required>
						<label class="form-check-label" for="flexCheckDefault">[필수] 구매조건 확인 및 결제진행 동의</label>
					</div>
				</div>
				<div class="border p-4 d-grid">
					<button class="btn btn-secondary" type="submit" <%=isStockAvailable ? "" : "style='display: none;'" %>><span id="totalAmount-button"></span>원 결제하기</button>
					<button class="btn btn-warning" type="button" <%=isStockAvailable ? "style='display: none;'" : "" %> disabled>재고부족으로 주문불가</button>
					<p class="text-muted mt-4" style="font-size: 0.85rem;">- 무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다. 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</p>
					<p class="text-muted" style="font-size: 0.85rem;">- 최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</p>
				</div>
			</div>
		</div>
	</form>
</div>
<%
	}
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	var totalProductPrice = 0;
	var numberOfProductItems = 0;
	
	// 페이지 로딩이 끝나고 자동으로 실행되는 함수이다.
	window.onload = function() {
		numberOfProductItems = document.getElementById("numberOfProductItems").value;
		
		updateTotalProductPrice();
		updateTotalDeliveryCharge();
		updateTotalAmount();
		updateTotalProductPoint();
	}
	
	// 상품가격의 총금액을 갱신한다.
	function updateTotalProductPrice() {
		totalProductPrice = 0;
		var productItemPrices = document.querySelectorAll(".productItemPrice");
		var productItemQuantities = document.querySelectorAll(".productItemQuantity");
		
		for (var i = 0; i < productItemPrices.length; i++) {
			totalProductPrice += parseInt(productItemPrices[i].innerHTML)*parseInt(productItemQuantities[i].value);
		}
		
		document.getElementById("totalProductPrice").innerHTML = totalProductPrice;
	}
	
	// 배송비를 갱신한다.
	function updateTotalDeliveryCharge() {
		var totalDeliveryCharge = 3000;
		var freeDeliveryCharges = document.querySelectorAll(".freeDeliveryCharge");
		var deliveryChargeStatus = "조건";

		if (totalProductPrice >= 50000) {
			totalDeliveryCharge = 0;
			deliveryChargeStatus = "무료";
		}
		
		for (var i = 0; i < freeDeliveryCharges.length; i++) {
			freeDeliveryCharges[i].innerHTML = deliveryChargeStatus;
		}
		document.getElementById("totalDeliveryCharge").innerHTML = totalDeliveryCharge;
	}
	
	// 상품적립포인트를 갱신한다.
	// 적립률은 상품, 회원등급 관계없이 모두 1%이다.
	function updateTotalProductPoint() {
		var totalProductPoint = 0;
		
		totalProductPoint = document.getElementById("totalProductPrice").innerHTML*0.01;
		
		document.getElementById("totalProductPoint").innerHTML = totalProductPoint;
		document.getElementById("totalPoint").innerHTML = totalProductPoint;
		document.getElementById("totalPoint-input").value = totalProductPoint;
	}
	
	// 총금액을 갱신한다.
	function updateTotalAmount() {
		var totalAmount = 0;
		totalAmount += parseInt(document.getElementById("totalProductPrice").innerHTML);
		totalAmount -= parseInt(document.getElementById("totalDiscount").innerHTML);
		totalAmount += parseInt(document.getElementById("totalDeliveryCharge").innerHTML);
		
		document.getElementById("totalAmount").innerHTML = totalAmount;
		document.getElementById("totalAmount-button").innerHTML = totalAmount;
		document.getElementById("totalAmount-input").value = totalAmount;
	}

	// 할인금액을 갱신한다.
	function updateDiscountAmount(discountAmount) {
		document.getElementById("discountAmount").innerHTML = discountAmount;
		document.getElementById("totalDiscount").innerHTML = discountAmount;
		
		updateTotalAmount();
	}
	
	// 상품아이템의 삭제 버튼을 클릭했을 때 실행된다.
	// 상품아이템의 수가 1개 이하이면 홈페이지로 이동한다.
	function deleteProductItem(productItemElementNo) {
		if (numberOfProductItems <= 1) {
			location.href="/semi-project/index.jsp";
			return;
		}
		
		document.getElementById("productItem" + productItemElementNo).remove();
		updateTotalProductPrice();
		updateTotalDeliveryCharge();
		updateTotalAmount();
		updateTotalProductPoint();
	}

	// 사용 적립금이 user의 잔여 적립금 이하인지 확인한다.
	// 사용 적립금이 user의 잔여 적립금보다 클 경우 경고창을 표시하고 사용 적립금 값을 0으로 변경한다.
	// 사용 적립금이 결제금액보다 많을 경우 경고창을 표시하고 사용 적립금 값을 0으로 변경한다.
	function checkUsingPoint(el) {
		if (parseInt(el.value) > parseInt(document.getElementById("availablePoint").innerHTML)) {
			alert("사용 가능 적립금보다 많습니다.\n사용 적립금을 다시 입력해 주세요.");
			el.value = 0;
		}
		if (parseInt(el.value) > parseInt(document.getElementById("totalAmount").innerHTML)) {
			alert("사용 적립금이 결제금액보다 많습니다.\n사용 적립금을 다시 입력해 주세요.");
			el.value = 0;
		}
		
		updateDiscountAmount(el.value);
	}
	
	// 포인트 전액 사용 버튼을 클릭했을 때 실행된다.
	// 사용 적립금이 결제금액보다 많을 경우 경고창을 표시하고 사용 적립금 값을 0으로 변경한다.
	// 사용 적립금이 결제금액 이하일 경우 사용 적립금의 값을 user의 잔여 적립금으로 변경한다.
	function useAllPoint() {
		var availablePoint = document.getElementById("availablePoint").innerHTML;
		var discountAmount = 0;
		
		if (availablePoint > parseInt(document.getElementById("totalAmount").innerHTML)) {
			alert("사용 적립금이 결제금액보다 많습니다.\n사용 적립금을 다시 입력해 주세요.");
			document.getElementById("usingPoint").value = 0;
		} else {
			document.getElementById("usingPoint").value = availablePoint;
			discountAmount = availablePoint;
		}
		
		updateDiscountAmount(discountAmount);
	}
	
	function agreeAllTerms() {
		document.getElementById("agreePurchaseCondition-checkbox").checked = document.getElementById("agreeAllTerms-checkbox").checked;
	}
	
	function checkSubmit(e) {
		e.preventDefault();
		
		var addresses = document.querySelectorAll(".addresses-radio");
		var defaultAddress = document.getElementById("addressDefault-radio");
		if (defaultAddress.checked) {
			for (var i = 0; i < addresses.length; i++) {
				document.getElementById("address" + i).remove();
			}
		} else {
			document.getElementById("addressDefault").remove();
			for (var i = 0; i < addresses.length; i++) {
				if (!addresses[i].checked) {
					document.getElementById("address" + i).remove();
				}
			}
		}
		
		document.querySelector("form").submit();
	}
	
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수
	
	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	            if(data.userSelectedType === 'R'){
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraAddr !== ''){
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                // 조합된 참고항목을 해당 필드에 넣는다.
	                document.getElementById("detailAddress").value = extraAddr;
	            
	            } else {
	                document.getElementById("detailAddress").value = '';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("postalCode").value = data.zonecode;
	            document.getElementById("baseAddress").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailAddress").focus();
	        }
	    }).open();
	}
</script>
</body>
</html>