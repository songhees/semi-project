<%@page import="semi.admin.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	int replyNo = Integer.parseInt(request.getParameter("replyNo"));
	int pageNo = Integer.parseInt(request.getParameter("pageNo"));
	
	AdminService service = AdminService.getInstance();
	service.deleteReply(replyNo);
	
	response.sendRedirect("detail.jsp?inquiryNo=" + inquiryNo + "&pageNo=" + pageNo);
%>