<%@page import="semi.vo.User"%>
<%@page import="semi.vo.Review"%>
<%@page import="semi.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String reviewPageNo = request.getParameter("pageNo");
	
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");
	
	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp");
		return;
	}
	
	ReviewDao reviewDao = ReviewDao.getInstance();

	Review review = reviewDao.getReviewDetailByReviewNo(reviewNo);
	
	if (review.getUserNo() != loginUserInfo.getNo()) {
		response.sendRedirect("detail.jsp?no="+review.getProductNo()+"&pageNo="+reviewPageNo);
		return;
	}
	
	review.setDeleted("Y");
	review.setNo(reviewNo);
	
	reviewDao.deleteReview(review);
	
	
	response.sendRedirect("detail.jsp?no="+review.getProductNo()+"&pageNo="+reviewPageNo);
%>