<%@page import="semi.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

// 로그인되어 있지 않는 유저일 경우
/* 	if (loginUserInfo == null) {
	response.sendRedirect("../loginform.jsp");		
	return;
} */


// 로그인한 유저와 수정할 유저의 아이디비교
/* if (userId.equals(loginUserInfo.getId())) {
	response.sendRedirect("../index.jsp");		
} */


%>