<%@page import="semi.dto.InquiryDto"%>
<%@page import="semi.dao.InquiryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<%
	int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	int categoryNo = Integer.parseInt(request.getParameter("inquiryCategory"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	InquiryDao inquiryDao = InquiryDao.getInstance();
	InquiryDto inquiryDto = inquiryDao.getInquiryDtoByInquiryNo(inquiryNo);
	
	inquiryDto.setCategoryNo(categoryNo);
	inquiryDto.setTitle(title);
	inquiryDto.setInquiryContent(content);
	
	inquiryDao.updateInquiry(inquiryDto);
	
	response.sendRedirect("detail.jsp?inquiryNo=" + inquiryNo);
%>