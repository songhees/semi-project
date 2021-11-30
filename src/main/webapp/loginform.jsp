<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>로그인</title>
    <style>
		.container {
			min-width: 992px;
		}
		
		.no-drag {
			-ms-user-select: none; -moz-user-select: -moz-none; -webkit-user-select: none; -khtml-user-select: none; user-select:none;
		}
		
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
<div class="container-fluid">
	<div id="homeBannerCarousel" class="carousel slide" data-bs-ride="carousel">
  		<div class="carousel-indicators">
    		<button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    		<button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
    		<button type="button" data-bs-target="#homeBannerCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
  		</div>
  	</div>
</div>
<div class="container">    
	<div id="contents">
		<div id="loginbox">
			<form class="border p-3 bg-white" method="post" action="login.jsp">
				<div class="mb-3">
					<label>LOGIN</label>
					<p>가입하신 아이디와 비밀번호를 입력해주세요.</p>
					<input type="text" class="form-control" name="id" id="user-id">
				</div>
			</form>
		</div>
	</div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>