<%@page import="semi.vo.ProductStyle"%>
<%@page import="java.io.File"%>
<%@page import="semi.vo.ProductDetailImage"%>
<%@page import="semi.vo.ProductCategory"%>
<%@page import="semi.vo.ProductThumbnailImage"%>
<%@page import="semi.vo.ProductItem"%>
<%@page import="semi.admin.service.AdminService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="semi.vo.Product"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="utils.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AdminService service = AdminService.getInstance();	
	int productNo = service.getProductNo();
	Product product = new Product();
	int totalStock = 0;

	String saveDirectory = "C:\\web-workspace\\web-projects\\semi-project\\src\\main\\webapp\\resources\\images\\product\\" + productNo;
	
	File folder = new File(saveDirectory);
	if (!folder.exists()) {
		folder.mkdirs();
	}

	MultipartRequest mr = new MultipartRequest(request, saveDirectory);

	int categoryNo = Integer.parseInt(mr.getParameter("categoryNo"));
	ProductCategory category = new ProductCategory();
	category = service.getCategoryByNo(categoryNo);	

	String name = mr.getParameter("name");
	int price = Integer.parseInt(mr.getParameter("price"));
	
	product.setNo(productNo);
	product.setProductCategory(category);
	product.setName(name);
	product.setPrice(price);
	service.addProduct(product);
	
	product = service.getProductByNo(productNo);
	
	String[] colorArray = mr.getParameterValues("color");
	String[] sizeArray = mr.getParameterValues("size");
	String[] stockArray = mr.getParameterValues("stock");
	
	if (stockArray != null) {
		for (int i = 0; i < stockArray.length; i++) {
			ProductItem item = new ProductItem();
			item.setProduct(product);
			item.setColor(colorArray[i]);
			item.setSize(sizeArray[i]);
			int stock = Integer.parseInt(stockArray[i]);
			item.setStock(stock);
			totalStock += stock;
			service.addItem(item);
		}
	}
	
	product.setTotalStock(totalStock);
	
	String discountPrice = mr.getParameter("discountPrice");
	
	if (!discountPrice.isEmpty()) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
		Date discountFrom = (Date)format.parse(mr.getParameter("discountFrom"));
		Date discountTo = (Date)format.parse(mr.getParameter("discountTo"));
		
		product.setDiscountPrice(Integer.parseInt(discountPrice));
		product.setDiscountFrom(discountFrom);
		product.setDiscountTo(discountTo);
	}

	String detail = mr.getParameter("detail");
	
	if (detail != null) {
		product.setDetail(detail);
	}

	service.updateProduct(product);
	
	String[] thumbnailArray = mr.getFilenames("thumbnailImage");
	
	if (thumbnailArray[0] != null) {
		for (int i = 0; i < thumbnailArray.length; i++) {
			ProductThumbnailImage image = new ProductThumbnailImage();
			image.setNo(productNo);
			image.setUrl(thumbnailArray[i]);
			service.addThumbnailImage(image);
		}
	}
	
	String[] detailArray = mr.getFilenames("detailImage");
	
	if (detailArray[0] != null) {
		for (int i = 0; i < detailArray.length; i++) {
			ProductDetailImage image = new ProductDetailImage();
			image.setProductNo(productNo);
			image.setUrl(detailArray[i]);
			service.addDetailImage(image);
		}
	}
	
	String[] styleArray = mr.getParameterValues("style");
	
	if (styleArray != null) {
		for (int i = 0; i < styleArray.length; i++) {
			ProductStyle style = new ProductStyle();
			style.setNo(productNo);
			Product styleProduct = new Product();
			styleProduct = service.getProductByNo(Integer.parseInt(styleArray[i]));
			style.setProduct(styleProduct);
			service.addStyle(style);
		}
	}

	response.sendRedirect("detail.jsp?productNo=" + productNo);
%>