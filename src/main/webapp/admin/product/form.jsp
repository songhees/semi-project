<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>상품 등록</title>
</head>
<body>
<%

%>
<%@ include file="/admin/common/navbar.jsp" %>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>상품 등록</h1>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<form class="row g-2" method="post" action="register.jsp" enctype="multipart/form-data">
					<div class="col-4">
						<label for="categoryNo" class="form-label">카테고리</label> 
						<select id="categoryNo" class="form-select" name="categoryNo">
							<option value="" selected disabled>카테고리를 선택하세요</option>
							<option value="1001">OUTER</option>
							<option value="1002">TOP</option>
							<option value="1003">SHIRT&amp;BLOUSE</option>
							<option value="1004">DRESS</option>
							<option value="1005">SKIRT</option>
							<option value="1006">PANTS</option>
						</select>
					</div>
					<div class="col-8">
						<label for="name" class="form-label">상품이름</label> 
						<input type="text" class="form-control" id="name" name="name">
					</div>
					<div class="col-4">
						<label for="price" class="form-label">가격</label>
						<input type="number" class="form-control" id="price" name="price">
					</div>
					<div class="col-4">
						<label for="discountPrice" class="form-label">할인가격</label>
						<input type="number" class="form-control" id="discountPrice" name="discountPrice">
					</div>
					<div class="col-2">
						<label for="discountFrom" class="form-label">할인시작일</label>
						<input type="datetime-local" class="form-control" id="discountFrom" name="discountFrom">
					</div>
					<div class="col-2">
						<label for="discountTo" class="form-label">할인종료일</label>
						<input type="datetime-local" class="form-control" id="discountTo" name="discountTo">
					</div>	
					
					<!-- 
						품목정보 1
					 -->
					<div class="col-4">
						<label for="color1" class="form-label">품목1 색상</label> 
						<input type="text" class="form-control" id="color1" name="color1">
					</div>
					<div class="col-4">
						<label for="size1" class="form-label">품목1 사이즈</label> 
						<input type="text" class="form-control" id="size1" name="size1">
					</div>
					<div class="col-4">
						<label for="stock1" class="form-label">품목1 재고량</label> 
						<input type="number" class="form-control" id="stock1" name="stock1">
					</div>
					<!-- 
						품목정보 2
					 -->
					<div class="col-4">
						<label for="color2" class="form-label">품목2 색상</label> 
						<input type="text" class="form-control" id="color2" name="color2">
					</div>
					<div class="col-4">
						<label for="size2" class="form-label">품목2 사이즈</label> 
						<input type="text" class="form-control" id="size2" name="size2">
					</div>
					<div class="col-4">
						<label for="stock2" class="form-label">품목2 재고량</label> 
						<input type="number" class="form-control" id="stock2" name="stock2">
					</div>
					<!-- 
						품목정보 3
					 -->
					<div class="col-4">
						<label for="color3" class="form-label">품목3 색상</label> 
						<input type="text" class="form-control" id="color3" name="color3">
					</div>
					<div class="col-4">
						<label for="size3" class="form-label">품목3 사이즈</label> 
						<input type="text" class="form-control" id="size3" name="size3">
					</div>
					<div class="col-4">
						<label for="stock3" class="form-label">품목3 재고량</label> 
						<input type="number" class="form-control" id="stock3" name="stock3">
					</div>
					
					<!-- 
						상세정보
					 -->
					<div class="col-12">
						<label for="detail" class="form-label">상세정보</label> 
						<textarea rows="10" class="form-control" id="detail" name="detail"></textarea>
					</div>
	
					<!-- 
						섬네일이미지 1
					 -->
					<div class="col-12">
						<label for="thumbnailImage1" class="form-label">섬네일이미지 파일1</label>
						<input type="file" class="form-control" id="thumbnailImage1" name="thumbnailImage1">
					</div>
					<!-- 
						섬네일이미지 2
					 -->
					<div class="col-12">
						<label for="thumbnailImage2" class="form-label">섬네일이미지 파일2</label>
						<input type="file" class="form-control" id="thumbnailImage2" name="thumbnailImage2">
					</div>
					<!-- 
						섬네일이미지 3
					 -->
					<div class="col-12">
						<label for="thumbnailImage3" class="form-label">섬네일이미지 파일3</label>
						<input type="file" class="form-control" id="thumbnailImage3" name="thumbnailImage3">
					</div>
					
					<!-- 
						상세이미지 1
					 -->
					<div class="col-12">
						<label for="detailImage1" class="form-label">상세이미지 파일1</label>
						<input type="file" class="form-control" id="detailImage1" name="detailImage1">
					</div>
					<!-- 
						상세이미지 2
					 -->
					<div class="col-12">
						<label for="detailImage2" class="form-label">상세이미지 파일2</label>
						<input type="file" class="form-control" id="detailImage2" name="detailImage2">
					</div>
					<!-- 
						상세이미지 3
					 -->
					<div class="col-12">
						<label for="detailImage3" class="form-label">상세이미지 파일3</label>
						<input type="file" class="form-control" id="detailImage3" name="detailImage3">
					</div>
	
					<div class="col-12 text-end">
						<a href="list.jsp" class="btn btn-secondary">취소</a>
						<button type="submit" class="btn btn-primary">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>