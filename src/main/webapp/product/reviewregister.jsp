<%@page import="semi.vo.User"%>
<%@page import="utils.MultipartRequest"%>
<%@page import="semi.vo.Review"%>
<%@page import="java.io.File"%>
<%@page import="semi.dao.ReviewDao"%>
<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	User loginUserInfo = (User)session.getAttribute("LOGIN_USER_INFO");

	if (loginUserInfo == null) {
		response.sendRedirect("../loginform.jsp?error=login-required");
		return;
	}

	ReviewDao reviewDao = ReviewDao.getInstance();
	int reviewNo = reviewDao.getReviewNo();
	String saveDirectory = "D:\\Develop\\projects\\WEB-WORKSPACE\\web-projects\\semi-project\\src\\main\\webapp\\resources\\images\\review\\review_no\\" + reviewNo; //폴더 경로
	File Folder = new File(saveDirectory);
	
	// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
	if (!Folder.exists()) {
		try{
		    Folder.mkdir(); //폴더 생성합니다.
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
         }else {
	}

	// 멀티파트요청을 처리하는 MultipartRequest객체 생성하기
	MultipartRequest mr = new MultipartRequest(request, saveDirectory);
	
	// 요청파라미터값 조회하기
	int productNo = Integer.parseInt(mr.getParameter("productNo"));
	String reviewContent = mr.getParameter("reviewContent");
	int reviewRate = Integer.parseInt(mr.getParameter("reviewRate"));
	int userNo = Integer.parseInt(mr.getParameter("userNo"));
	// 업로드된 파일이름 조회하기
	String reviewImage = mr.getFilename("reviewImage");
	
	// 상품객체 생성해서 상품정보와 업로드된 파일의 파일명을 저장한다.
	Review review = new Review();
	// session으로 바꾸기
	review.setNo(reviewNo);
	review.setUserNo(userNo);
	review.setProductNo(productNo);
	review.setContent(reviewContent);
	review.setRate(reviewRate);
	review.setFilename(reviewImage);
	
	reviewDao.insertProductReview(review);
	if (reviewImage != null) {
		reviewDao.insertReviewImage(review);
	}
	response.sendRedirect("detail.jsp?no=" + productNo);
%>