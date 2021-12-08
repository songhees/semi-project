<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" >
    <title></title>
</head>
<body>
<%@ include file="../common/navbar.jsp"%>
<%
int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
%>
<div class="container mb-5 pb-5">
	<div class="row mb-5">
		<div class="col">
			<div class="d-flex justify-content-end">
				<nav style="-bs-breadcrumb-divider: '&gt;';" aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="/semi-prodject/index.jsp" style="text-decoration: none; color: gray;">Home</a></li>
						<li class="breadcrumb-item">BOARD</li>
						<li class="breadcrumb-item active" aria-current="page">Q&amp;A</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
	<div class="row mt-5 pt-5 mb-3">
		<div class="col">
			<h4 align="center">
				<strong>Q&amp;A</strong>
			</h4>
			<h6 align="center">상품 Q&amp;A입니다.</h6>
		</div>
	</div>
	<div class="row mt-5 border">
		<div class="col mt-5">
			<form action="passwordcheck.jsp">
				<input type="hidden" name="inquiryNo" value="<%=inquiryNo %>">
				<div class="d-flex justify-content-center">
					<p class="fs-4">댓글삭제</p>
				</div>
				<div class="d-flex justify-content-center mt-1">
					<p class="fs-6 m-0">
						이 글은 비밀글입니다. <strong>비밀번호를 입력하여 주세요.</strong> 관리자는 확인버튼만 누르시면 됩니다.
					</p>
				</div>
				<div class="d-flex justify-content-center">
					<p class="fs-6">관리자는 확인버튼만 누르시면 됩니다.</p>
				</div>
				<div class="row mb-3 mt-4 d-flex justify-content-center">
					<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-5">
						<input name="inquiryPassword" type="password" class="form-control" id="password">
<%
	String error = request.getParameter("error");
	if ("mismatch-password".equals(error)) {			// login.jsp에서 사용자 인증처리를 회원가입시 입력한 비밀번호와 로그인시 입력한 비밀번호가 일치하지 않았다.
%>
						<div class="alert alert-light p-0" role="alert">
						  	<span style="color: red">비밀글 비밀번호가 틀립니다.</span>
						</div>
<%
	}
%>
					</div>
				</div>
				<div id="button-list" class="d-flex justify-content-center mt-5 mb-5">
					<div class="me-3">
						<a href="list.jsp?inquiryCategory=전체보기">
							<button type="button" class="btn btn-secondary btn-lg">
								<span class="fs-6">목록</span>
							</button>
						</a>
					</div>
					<div class="me-3">
						<button type="submit" class="btn btn-outline-secondary btn-lg">
							<span class="fs-6">확인</span>
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>