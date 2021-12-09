package semi.admin.service;

import java.sql.SQLException;
import java.util.List;

import semi.admin.dao.AdminInquiryDao;
import semi.admin.dao.AdminInquiryReplyDao;
import semi.admin.dao.AdminProductCategoryDao;
import semi.admin.dao.AdminProductDao;
import semi.admin.dao.AdminProductItemDao;
import semi.admin.dao.AdminProductThumbnailImageDao;
import semi.admin.dao.AdminUserDao;
import semi.admin.dao.AdminProductDetailImageDao;
import semi.admin.dao.AdminProductStyleDao;
import semi.vo.Product;
import semi.vo.ProductCategory;
import semi.vo.ProductDetailImage;
import semi.vo.ProductItem;
import semi.vo.ProductStyle;
import semi.vo.ProductThumbnailImage;
import semi.vo.User;
import semi.vo.Inquiry;
import semi.vo.InquiryReply;

public class AdminService {

	private final AdminProductCategoryDao categoryDao = new AdminProductCategoryDao();
	private final AdminProductDao productDao = new AdminProductDao();
	private final AdminProductItemDao itemDao = new AdminProductItemDao();
	private final AdminProductThumbnailImageDao thumbnailImageDao = new AdminProductThumbnailImageDao();
	private final AdminProductDetailImageDao detailImageDao = new AdminProductDetailImageDao();
	private final AdminProductStyleDao styleDao = new AdminProductStyleDao();
	private final AdminUserDao userDao = new AdminUserDao();
	private final AdminInquiryDao inquiryDao = new AdminInquiryDao();
	private final AdminInquiryReplyDao replyDao = new AdminInquiryReplyDao();
	
	
	private static AdminService service = new AdminService();
	private AdminService() {}
	public static AdminService getInstance() {
		return service;
	}
	
	/**************************************************************************
	 * 상품관리 기능                                                              * 
	 **************************************************************************/

	public List<ProductCategory> getAllCategories() throws SQLException {
		return categoryDao.getAllCategories();
	}
	
	public ProductCategory getCategoryByNo(int categoryNo) throws SQLException {
		return categoryDao.getCategoryByNo(categoryNo);
	}
	
	public List<Product> getAllProducts() throws SQLException {
		return productDao.getAllProducts();
	}
	
	public List<Product> getAllProductsOrderByCategory() throws SQLException {
		return productDao.getAllProductsOrderByCategory();
	}
	
	public List<Product> getProductsByCategory(int categoryNo) throws SQLException {
		return productDao.getProductsByCategory(categoryNo);
	}
	
	public int getTotalProductRecords() throws SQLException {
		return productDao.getTotalRecords();
	}
	
	public int getTotalRecordsByCategory(int categoryNo) throws SQLException {
		return productDao.getTotalRecordsByCategory(categoryNo);
	}
	
	public List<Product> getProductList(int begin, int end) throws SQLException {
		return productDao.getProductList(begin, end);
	}
	
	public List<Product> getProductListByCategory(int begin, int end, int categoryNo) throws SQLException {
		return productDao.getProductListByCategory(begin, end, categoryNo);
	}
	
	public Product getProductByNo(int productNo) throws SQLException {
		return productDao.getProductByNo(productNo);
	}
	
	public List<ProductItem> getItemsByProductNo(int productNo) throws SQLException {
		return itemDao.getItemsByProductNo(productNo);
	}
	
	public List<ProductThumbnailImage> getThumbnailImagesByProductNo(int productNo) throws SQLException {
		return thumbnailImageDao.getThumbnailImagesByProductNo(productNo);
	}
	
	public List<ProductDetailImage> getDetailImagesByProductNo(int productNo) throws SQLException {
		return detailImageDao.getDetailImagesByProductNo(productNo);
	}

	public int getProductNo() throws SQLException {
		return productDao.getProductNo();
	}
	
	public void addThumbnailImage(ProductThumbnailImage image) throws SQLException {
		thumbnailImageDao.addThumbnailImage(image);
	}
	
	public void addDetailImage(ProductDetailImage image) throws SQLException {
		detailImageDao.addDetailImage(image);
	}
	
	public void addProduct(Product product) throws SQLException {
		productDao.addProduct(product);
	}
	
	public void updateProduct(Product product) throws SQLException {
		productDao.updateProduct(product);
	}
	
	public void addItem(ProductItem item) throws SQLException {
		itemDao.addItem(item);
	}
	
	public void removeItem(int productItemNo) throws SQLException {
		itemDao.removeItem(productItemNo);
	}
	
	public ProductItem getItemByItemNo(int itemNo) throws SQLException {
		return itemDao.getItemByItemNo(itemNo);
	}
	
	public void updateItem(ProductItem item) throws SQLException {
		itemDao.updateItem(item);
	}
	
	public void removeThumbnailImage(int productNo) throws SQLException {
		thumbnailImageDao.removeThumbnailImage(productNo);
	}
	
	public void removeDetailImage(int productNo) throws SQLException {
		detailImageDao.removeDetailImage(productNo);
	}
	
	public void addStyle(ProductStyle style) throws SQLException {
		styleDao.addStyle(style);
	}
	
	public List<ProductStyle> getStylesByNo(int productNo) throws SQLException {
		return styleDao.getStylesByNo(productNo);
	}
	
	/**************************************************************************
	 * 주문관리 기능                                                              * 
	 **************************************************************************/
	
	/**************************************************************************
	 * 고객관리 기능                                                              * 
	 **************************************************************************/
	
	public User getUserById(String id) throws SQLException {
		return userDao.getUserById(id);
	}
	
	public User getUserByEmail(String email) throws SQLException {
		return userDao.getUserByEmail(email);
	}
	
	public void addUser(User user) throws SQLException {
		userDao.addUser(user);
	}
	
	public int getTotalUserRecords() throws SQLException {
		return userDao.getTotalRecords();
	}
	
	public List<User> getUserList(int begin, int end) throws SQLException {
		return userDao.getUserList(begin, end);
	}
	
	public User getUserByNo(int no) throws SQLException {
		return userDao.getUserByNo(no);
	}
	
	/**************************************************************************
	 * 문의관리 기능                                                              * 
	 **************************************************************************/
	
	public int getTotalInquiryRecords() throws SQLException {
		return inquiryDao.getTotalRecords();
	}
	
	public List<Inquiry> getInquiryList(int begin, int end) throws SQLException {
		return inquiryDao.getInquiryList(begin, end);
	}
	
	public Inquiry getInquiryByNo(int no) throws SQLException {
		return inquiryDao.getInquiryByNo(no);
	}
	
	public void addReply(InquiryReply reply) throws SQLException { 
		replyDao.addReply(reply);
	}
	
	public InquiryReply getReplyByInquiryNo(int inquiryNo) throws SQLException {
		return replyDao.getReplyByInquiryNo(inquiryNo);
	}
	
	public void updateReply(InquiryReply reply) throws SQLException {
		replyDao.updateReply(reply);
	}
	
	public void deleteReply(int replyNo) throws SQLException {
		replyDao.deleteReply(replyNo);
	}
	
	/**************************************************************************
	 * 리뷰관리 기능                                                              * 
	 **************************************************************************/
}
