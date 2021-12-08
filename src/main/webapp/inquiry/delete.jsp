<%@page import="semi.dao.InquiryDao"%>
<%@page import="semi.dto.InquiryDto"%>
<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	InquiryDao inquiryDao = InquiryDao.getInstance();
	InquiryDto inquiryDto = inquiryDao.getInquiryDtoByInquiryNo(inquiryNo);
	String password = request.getParameter("password");
	String secretPassword = DigestUtils.sha256Hex(password);
	
	if (!inquiryDto.getPassword().equals(secretPassword)) {
		response.sendRedirect("detail.jsp?inquiryNo="+inquiryNo+"&error=mismatch-password");
		return;
	}
	
	inquiryDto.setInquiryDeleted("Y");
	inquiryDao.deleteInquiry(inquiryDto);	
	
	response.sendRedirect("list.jsp");
%>