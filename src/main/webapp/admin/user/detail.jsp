<%@page import="semi.admin.service.AdminService"%>
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
<%
	pageContext.setAttribute("menu", "user");
%>
<%@ include file="/admin/common/navbar.jsp" %>
<%
	int userNo = Integer.parseInt(request.getParameter("userNo"));
	String tempPageNo = request.getParameter("pageNo");
	int pageNo = 1;
	if (tempPageNo != null) {
		pageNo = Integer.parseInt(tempPageNo);
	}
	
	AdminService service = AdminService.getInstance();
	
	User user = service.getUserByNo(userNo);
%>
	<div class="container">    
		<div class="row">
			<div class="col">
				<h1>고객 정보</h1>
			</div>
			<div class="col text-end">
				<a href="list.jsp?pageNo=<%=pageNo %>" class="btn btn-secondary">목록</a>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<table class="table">
					<tbody>
						<tr class="d-flex">
							<th class="col-2">고객번호</th>
							<td class="col-4"><%=user.getNo() %></td>
							<th class="col-2">아이디</th>
							<td class="col-4"><%=user.getId() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">이름</th>
							<td class="col-4"><%=user.getName() %></td>
							<th class="col-2">계정유형</th>
							<td class="col-4"><%="Y".equals(user.getAdmin()) ? "관리자" : "고객" %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">등급</th>
							<td class="col-4"><%=user.getGradeCode() %></td>
							<th class="col-2">포인트</th>
							<td class="col-4"><%=user.getPoint() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">전화번호</th>
							<td class="col-4"><%=user.getTel() %></td>
							<th class="col-2">이메일</th>
							<td class="col-4"><%=user.getEmail() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">전화번호 광고수신</th>
							<td class="col-4"><%=user.getSmsSubscription() %></td>
							<th class="col-2">이메일 광고수신</th>
							<td class="col-4"><%=user.getEmailSubscription() %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">가입날짜</th>
							<td class="col-4"><%=user.toSimpleDate(user.getCreatedDate()) %></td>
							<th class="col-2">탈퇴여부</th>
							<td class="col-4"><%="Y".equals(user.getDeleted()) ? "탈퇴한 회원입니다." : "회원입니다." %></td>
						</tr>
						<tr class="d-flex">
							<th class="col-2">수정날짜</th>
							<td class="col-4"><%=user.toSimpleDate(user.getUpdatedDate()) == null ? "-" : user.toSimpleDate(user.getUpdatedDate()) %></td>
							<th class="col-2">탈퇴날짜</th>
							<td class="col-4"><%=user.toSimpleDate(user.getDeletedDate()) == null ? "-" : user.toSimpleDate(user.getDeletedDate()) %></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>