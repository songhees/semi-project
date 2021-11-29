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
    	.sortingName:hover {
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
		
		// TODO 30에 들어갈 값은 totalRecords로 ProductDao에서 구해와서 대입하기
		Pagination pagination = new Pagination(pageNo, 30);
	
		if ("best".equals(category)) {
			// TODO DB에서 상품 판매량 상위 ?개를 가져온다.
		} else {
			// TODO 카테고리가 알맞은지 먼저 확인하고, 해당하는 상품 리스트를 가져온다.
		}
	%>
	<div class="row">
		<div class="col my-4 text-center">
			<h4>OUTER</h4>
		</div>
	</div>
	<div class="row">
		<div class="col d-flex justify-content-start">
			<p style="font-size: 0.8em;">TOTAL <strong>30</strong> PRODUCT</p>
		</div>
		<div class="col d-flex justify-content-end">
			<span class="sortingName">신상품</span>
			<span class="px-3">|</span>
			<span class="sortingName">낮은가격</span>
			<span class="px-3">|</span>
			<span class="sortingName">높은가격</span>
			<span class="px-3">|</span>
			<span class="sortingName">낮은가격</span>
			<span class="px-3">|</span>
			<span class="sortingName">상품후기</span>
		</div>
	</div>
	<div class="row row-cols-4 g-4 my-4">
		<div class="col">
			<div class="card border-light h-100">
				<img src="http://localhost/semi-project/resources/images/product/1000/thumbnail/1000_1.jpg" class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				<div class="card-body">
					<p class="card-text">히든 단추 블라우스 셔츠 4color</p>
					<hr>
					<p class="card-text">25,500원</p>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card border-light h-100">
				<img src="http://localhost/semi-project/resources/images/product/1001/thumbnail/1001_1.jpg" class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				<div class="card-body">
					<p class="card-text">히든 단추 블라우스 셔츠 4color</p>
					<hr>
					<p class="card-text">25,500원</p>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card border-light h-100">
				<img src="http://localhost/semi-project/resources/images/product/1002/thumbnail/1002_1.jpg" class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				<div class="card-body">
					<p class="card-text">히든 단추 블라우스 셔츠 4color</p>
					<hr>
					<p class="card-text">25,500원</p>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card border-light h-100">
				<img src="http://localhost/semi-project/resources/images/product/1003/thumbnail/1003_1.jpg" class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				<div class="card-body">
					<p class="card-text">히든 단추 블라우스 셔츠 4color</p>
					<hr>
					<p class="card-text">25,500원</p>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card border-light h-100">
				<img src="http://localhost/semi-project/resources/images/product/1000/thumbnail/1000_1.jpg" class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				<div class="card-body">
					<p class="card-text">히든 단추 블라우스 셔츠 4color</p>
					<hr>
					<p class="card-text">25,500원</p>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card border-light h-100">
				<img src="http://localhost/semi-project/resources/images/product/1001/thumbnail/1001_1.jpg" class="card-img-top" onmouseenter="changeImage(this, 2)" onmouseleave="changeImage(this, 1)">
				<div class="card-body">
					<p class="card-text">히든 단추 블라우스 셔츠 4color</p>
					<hr>
					<p class="card-text">25,500원</p>
				</div>
			</div>
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
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=1" >&#60;&#60;</a></li>
					<li class="page-item <%=!pagination.isExistPrev() ? "disabled" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getPrevPage()%>" >&#60;</a></li>
					<%
						// Pagination 객체로부터 해당 페이지 블록의 시작 페이지번호와 끝 페이지번호만큼 페이지내비게이션 정보를 표시한다.
						for (int num = pagination.getBeginPage(); num <= pagination.getEndPage(); num++) {
					%>					
					<li class="page-item <%=pagination.getPageNo() == num ? "active" : "" %>"><a class="page-link" href="list.jsp?pageNo=<%=num%>"><%=num %></a></li>
					<%
						}
					%>					
					<!-- 
						Pagination객체가 제공하는 isExistNext()는 다음 블록이 존재하는 경우 true를 반환한다.
						Pagination객체가 제공하는 getNexPage()는 다음 블록의 첫 페이지값을 반환한다.
					 -->
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getNextPage()%>" >&#62;</a></li>
					<li class="page-item <%=!pagination.isExistNext() ? "disabled" :"" %>"><a class="page-link" href="list.jsp?pageNo=<%=pagination.getTotalPages()%>" >&#62;&#62;</a></li>
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