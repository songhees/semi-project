<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title>회원가입</title>
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
<%
	pageContext.setAttribute("menu", "resister");
%>
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
	<div class="titleArea">
		<h2>JOIN</h2>
	</div>
	<table border="1">
		<colgroup>
			<col style="width:150px;">
			<col style="width:auto;">
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					아이디<img src="resources/images/home/blue_star.jpg" alt="필수">
				</th>
				<td>
					<input id="user_id" name="id" class="inputTypeText" type="text">
					(영문소문자/숫자, 4~16자)
				</td>
			</tr>
			<tr>
				<th scope="row">
					비밀번호<img src="resources/images/home/blue_star.jpg" alt="필수">
				</th>
				<td>
					<input id="user_password" name="password" class="inputTypeText" type="text">
					(영문 대소문자/숫자/특수문자 중 3가지 이상 조합, 8자~16자)
				</td>
			</tr>
			<tr>
				<th scope="row">
					비밀번호 확인<img src="resources/images/home/blue_star.jpg" alt="필수">
				</th>
				<td>
					<input id="user_check_password" name="check_password" class="inputTypeText" type="text">
				</td>
			</tr>
			<tr>
				<th scope="row">
					이름<img src="resources/images/home/blue_star.jpg" alt="필수">
				</th>
				<td>
					<input id="user_name" name="name" class="inputTypeText" type="text">
				</td>
			</tr>
			<tr>
				<th scope="row">
					휴대전화<img src="resources/images/home/blue_star.jpg" alt="필수">
				</th>
				<td>
					<input id="user_tel" name="tel" class="inputTypeText" type="text">
				</td>
			</tr>
			<tr>
				<th scope="row">
					이메일<img src="resources/images/home/blue_star.jpg" alt="필수">
				</th>
				<td>
					<input id="user_email" name="email" class="inputTypeText" type="text">
				</td>
			</tr>
		</tbody>
	</table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>