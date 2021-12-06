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
<div class="container"> 
	<form id="form-search" method="post" action="order.jsp">
		<div class="row justify-content-center">
			<div class="col-10">
				<label class="col-12 col-form-label text-center p-3" style="color: white; background-color: #404040"><strong>주문/결제</strong></label>
				<div class="accordion accordion-flush border p-0" id="accordionExample">
		  			<div class="accordion-item">
		    			<h2 class="accordion-header" id="headingOne">
		      				<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" style="color: black; background-color: white;">
		      					<strong>배송지</strong>
		      				</button>
		    			</h2>
		    			<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
		      				<div class="accordion-body px-3">
		        				<div class="row mb-3">
		        					<div class="col">
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
		  									<label class="form-check-label" for="flexRadioDefault1">회원 정보와 동일	</label>
										</div>
		        						<div class="form-check form-check-inline">
		  									<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" checked>
		  									<label class="form-check-label" for="flexRadioDefault1">새로운 배송지</label>
										</div>
		        					</div>
		        				</div>
		        				<div class="row mb-2">
		        					<label class="col-2 col-form-label">받는사람</label>
		        					<div class="col-10">
										<input type="text" name="receivePerson" class="form-control">
									</div>
		        				</div>
		        				<div class="row mb-2">
		        					<label class="col-2 col-form-label">주소</label>
		        					<div class="col-2">
										<input type="text" name="postalCode" class="form-control" disabled readonly>
									</div>
		        					<div class="col-2">
										<button class="btn btn-secondary">주소검색</button>
									</div>
		        				</div>
		        				<div class="row justify-content-end mb-2">
		        					<div class="col-10">
										<input type="text" name="baseAddress" class="form-control">
									</div>
		        				</div>
		        				<div class="row justify-content-end mb-2">
		        					<div class="col-10">
										<input type="text" name="detailAddress" class="form-control">
									</div>
		        				</div>
		        				<div class="row mb-2">
		        					<label class="col-2 col-form-label">휴대전화</label>
		        					<div class="col-10">
		        						<select class="form-select" name="firstPhoneNumber" style="width: 28%; display: inline;">
				  							<option value="010" selected>010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
		        						<label style="width: 5%; display: inline;">-</label>
										<input type="number" name="middlePhoneNumber" class="form-control" style="width: 28%; display: inline;">
										<label style="width: 5%; display: inline;">-</label>
										<input type="number" name="lastPhoneNumber" class="form-control" style="width: 28%; display: inline;">
									</div>
		        				</div>
		        				<div class="row mb-1">
		        					<label class="col-2 col-form-label">이메일</label>
		        					<div class="col-10">
		        						<input type="text" name="emailLocalPart" class="form-control" style="width: 28%; display: inline;">
										<label style="width: 5%; display: inline;">@</label>
		        						<select class="form-select" name="emailDomain" style="width: 28%; display: inline;">
				  							<option value="" selected>-이메일 선택-</option>
											<option value="naver.com">naver.com</option>
											<option value="gmail.com">gmail.com</option>
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
				<div class="accordion accordion-flush border p-0 mt-2" id="accordionExample2">
		  			<div class="accordion-item">
		    			<h2 class="accordion-header" id="heading2">
		      				<button class="accordion-button btn-light" type="button" data-bs-toggle="collapse" data-bs-target="#collapse2" aria-expanded="true" aria-controls="collapse2" style="color: black; background-color: white;">
		      					<strong>주문상품</strong>
		      				</button>
		    			</h2>
		    			<div id="collapse2" class="accordion-collapse collapse show" aria-labelledby="heading2" data-bs-parent="#accordionExample2">
		      				<div class="accordion-body px-3">
		      				</div>
		      			</div>
		      		</div>
		      	</div>
			</div>
		</div>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>