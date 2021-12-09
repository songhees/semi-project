<%@page import="semi.admin.service.AdminService"%>
<%@page import="semi.vo.InquiryReply"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	int replyNo = Integer.parseInt(request.getParameter("replyNo"));	
	int pageNo = Integer.parseInt(request.getParameter("pageNo"));
	String content = request.getParameter("content");
	
	InquiryReply reply = new InquiryReply();
	reply.setInquiryNo(inquiryNo);
	reply.setNo(replyNo);
	reply.setContent(content);

	AdminService service = AdminService.getInstance();
	service.updateReply(reply);
	
	response.sendRedirect("detail.jsp?inquiryNo=" + inquiryNo + "&pageNo=" + pageNo);
%>