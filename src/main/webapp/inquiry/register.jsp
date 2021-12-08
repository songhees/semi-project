<%@page import="semi.dao.InquiryDao"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="semi.dto.InquiryDto"%>
<%@page import="semi.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int categoryNo = Integer.parseInt(request.getParameter("inquiryCategory"));
	String title = request.getParameter("title");
	String password = request.getParameter("password");
	String secretPassword = DigestUtils.sha256Hex(password);
	String content = request.getParameter("content");
	
	if (title != null && title.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-title");
		return;
	}
	if (content != null && content.isBlank()) {
		response.sendRedirect("form.jsp?error=empty-content");
		return;
	}
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}
	int userNo = loginUserInfo.getNo();
	
	InquiryDto inquiryDto = new InquiryDto();
	inquiryDto.setProductNo(productNo);
	inquiryDto.setCategoryNo(categoryNo);
	inquiryDto.setTitle(title);
	inquiryDto.setPassword(secretPassword);
	inquiryDto.setInquiryContent(content);
	inquiryDto.setUserNo(userNo);
	
	InquiryDao inquiryDao = InquiryDao.getInstance();
	inquiryDao.insertInquiry(inquiryDto);
	
	response.sendRedirect("list.jsp");
%>