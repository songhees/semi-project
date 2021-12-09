<%@page import="semi.vo.User"%>
<%@page import="semi.vo.InquiryReply"%>
<%@page import="semi.admin.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int inquiryNo = Integer.parseInt(request.getParameter("inquiryNo"));
	int pageNo = Integer.parseInt(request.getParameter("pageNo"));
	String content = request.getParameter("content");
	
	User loginUserInfo = (User)session.getAttribute("ADMIN_USER_INFO");
	
	InquiryReply reply = new InquiryReply();
	reply.setInquiryNo(inquiryNo);
	reply.setWriter(loginUserInfo);
	reply.setContent(content);

	AdminService service = AdminService.getInstance();
	
	service.addReply(reply);
	
	response.sendRedirect("detail.jsp?inquiryNo=" + inquiryNo + "&pageNo=" + pageNo);
%>
