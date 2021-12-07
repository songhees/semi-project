<%@page import="semi.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	int userNo = loginUserInfo.getNo();
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int categoryNo = Integer.parseInt(request.getParameter("inquiryCategory"));
	String title = request.getParameter("title");
	String password = request.getParameter("password");
	String content = request.getParameter("content");
	
	
	
	
	
	response.sendRedirect("list.jsp");
%>