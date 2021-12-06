<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="semi.dao.InquiryDao"%>
<%@page import="semi.dto.InquiryDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	String password = request.getParameter("inquiryPassword");
	
	String secretPassword = DigestUtils.sha256Hex(password);
	
	InquiryDao inquiryDao = InquiryDao.getInstance();
	InquiryDto inquiryDto = inquiryDao.getInquiryDtoByInquiryNo(inquiryNo);
	
	if (!inquiryDto.getPassword().equals(secretPassword)) {
		response.sendRedirect("passwordcheckform.jsp?inquiryNo="+inquiryNo+"&error=mismatch-password");
		return;
	}
	
	response.sendRedirect("detail.jsp?inquiryNo="+inquiryDto.getInquiryNo());
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
