<%@page import="java.io.File"%>
<%@page import="semi.vo.ProductDetailImage"%>
<%@page import="semi.vo.ProductThumbnailImage"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="semi.vo.ProductItem"%>
<%@page import="java.util.List"%>
<%@page import="semi.vo.ProductCategory"%>
<%@page import="utils.MultipartRequest"%>
<%@page import="semi.vo.Product"%>
<%@page import="semi.admin.service.AdminService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int pageNo = Integer.parseInt(request.getParameter("pageNo"));
	
	AdminService service = AdminService.getInstance();
	Product product = service.getProductByNo(productNo);
	List<ProductItem> items = service.getItemsByProductNo(productNo);
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
	String onSale = mr.getParameter("onSale");
	
	product.setNo(productNo);
	product.setProductCategory(category);
	product.setName(name);
	product.setPrice(price);
	product.setOnSale(onSale);
	
	String[] itemNoArray = mr.getParameterValues("itemNo");
	String[] colorArray = mr.getParameterValues("color");
	String[] sizeArray = mr.getParameterValues("size");
	String[] stockArray = mr.getParameterValues("stock");
	
	if (itemNoArray == null) {
		for (ProductItem item : items) {
			service.removeItem(item.getNo());
		}
	} else {
		boolean isFound = false;
		for (ProductItem item : items) {
			for (int i = 0; i < itemNoArray.length; i++) {
				if (item.getNo() == Integer.parseInt(itemNoArray[i])) {
					isFound = true;
				}
			}
			if (!isFound) {
				service.removeItem(item.getNo());
			}
		}		
	}
	
	if (stockArray != null) {
		for (int i = 0; i < stockArray.length; i++) {
			if (itemNoArray[i] == null) {
				ProductItem item = new ProductItem();
				item.setProduct(product);
				item.setColor(colorArray[i]);
				item.setSize(sizeArray[i]);
				int stock = Integer.parseInt(stockArray[i]);
				item.setStock(stock);
				totalStock += stock;
				service.addItem(item);
			} else {
				ProductItem item = service.getItemByItemNo(Integer.parseInt(itemNoArray[i]));
				item.setColor(colorArray[i]);
				item.setSize(sizeArray[i]);
				int stock = Integer.parseInt(stockArray[i]);
				item.setStock(stock);
				totalStock += stock;
				service.updateItem(item);
			}
		}
	}
	
	product.setTotalStock(totalStock);
	
	String discountPrice = mr.getParameter("discountPrice");
		
	if (!discountPrice.isEmpty()) { // 할인정보를 입력했을 경우
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
		Date discountFrom = (Date)format.parse(mr.getParameter("discountFrom"));
		Date discountTo = (Date)format.parse(mr.getParameter("discountTo"));
			
		product.setDiscountPrice(Integer.parseInt(discountPrice));
		product.setDiscountFrom(discountFrom);
		product.setDiscountTo(discountTo);
	} else {
		product.setDiscountPrice(0);
		product.setDiscountFrom(null);
		product.setDiscountTo(null);
	}
	
	String detail = mr.getParameter("detail");
		
	if (detail != null) {
		product.setDetail(detail);
	} else {
		product.setDetail(null);
	}
	
	service.updateProduct(product);
	
	String[] thumbnailSavedArray = mr.getParameterValues("thumbnailImageSaved");
	String[] detailSavedArray = mr.getParameterValues("detailImageSaved");
	
	service.removeThumbnailImage(productNo);
	service.removeDetailImage(productNo);
	
	if (thumbnailSavedArray != null) {
		for (int i = 0; i < thumbnailSavedArray.length; i++) {
			ProductThumbnailImage image = new ProductThumbnailImage();
			image.setNo(productNo);
			image.setUrl(thumbnailSavedArray[i]);
			service.addThumbnailImage(image);
		}
	}
	if (detailSavedArray != null) {
		for (int i = 0; i < detailSavedArray.length; i++) {
			ProductDetailImage image = new ProductDetailImage();
			image.setProductNo(productNo);
			image.setUrl(detailSavedArray[i]);
			service.addDetailImage(image);
		}
	}
	
	String[] thumbnailArray = mr.getFilenames("thumbnailImage");
		
	if (thumbnailArray[0] != null) { // 섬네일이미지를 선택했을 경우
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
	
	response.sendRedirect("detail.jsp?productNo=" + productNo + "&pageNo=" + pageNo);
%>