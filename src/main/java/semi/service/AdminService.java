package semi.service;

import java.sql.SQLException;
import java.util.List;

import semi.dao.ProductCategoryDao;
import semi.dao.ProductDao;
import semi.dao.ProductDetailImageDao;
import semi.dao.ProductItemDao;
import semi.dao.ProductThumbnailImageDao;
import semi.vo.Product;
import semi.vo.ProductCategory;
import semi.vo.ProductDetailImage;
import semi.vo.ProductItem;
import semi.vo.ProductThumbnailImage;

public class AdminService {

	private final ProductCategoryDao categoryDao = new ProductCategoryDao();
	private final ProductDao productDao = new ProductDao();
	private final ProductItemDao productItemDao = new ProductItemDao();
	private final ProductThumbnailImageDao productThumbnailImageDao = new ProductThumbnailImageDao();
	private final ProductDetailImageDao productDetailImageDao = new ProductDetailImageDao();
	
	private static AdminService service = new AdminService();
	private AdminService() {}
	public static AdminService getInstance() {
		return service;
	}
	
	/**************************************************************************
	 * 상품관리 기능                                                              * 
	 **************************************************************************/

	/**
	 * 모든 상품 카테고리정보를 반환한다.
	 * @return 상품 카테고리정보 목록
	 * @throws SQLException	데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<ProductCategory> getAllCategories() throws SQLException {
		return categoryDao.getAllCategories();
	}
	
	/**
	 * 지정받은 카테고리 번호에 해당되는 카테고리정보를 반환한다.
	 * @param categoryNo 카테고리번호
	 * @return 카테고리 정보
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public ProductCategory getCategoryByNo(int categotyNo) throws SQLException {
		return categoryDao.getCategoryByNo(categotyNo);
	}
	
	/**
	 * 모든 상품정보를 반환한다.
	 * @return 상품정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */ 
	public List<Product> getAllProducts() throws SQLException {
		return productDao.getAllProducts();
	}
	
	/**
	 * 지정된 카테고리번호에 해당하는 상품정보를 반환한다.
	 * @param categoryNo 카테고리번호
	 * @return 상품정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<Product> getProductsByCategory(int categoryNo) throws SQLException {
		return productDao.getProductsByCategory(categoryNo);
	}
	
	/**
	 * 총 상품 레코드의 개수를 반환한다.
	 * @return 상품 레코드의 개수
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public int getTotalRecords() throws SQLException {
		return productDao.getTotalRecords();
	}
	
	/**
	 * 지정된 카테고리에 해당하는 총 상품 레코드의 개수를 반환한다.
	 * @return 상품 레코드의 개수
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public int getTotalRecordsByCategory(int categoryNo) throws SQLException {
		return productDao.getTotalRecordsByCategory(categoryNo);
	}
	
	/**
	 * 지정된 범위만큼 계산된 상품정보 목록을 반환한다.
	 * @param begin
	 * @param end
	 * @return 상품정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<Product> getProductList(int begin, int end) throws SQLException {
		return productDao.getProductList(begin, end);
	}
	
	/**
	 * 지정된 카테고리와 범위만큼 계산된 상품정보 목록을 반환한다.
	 * @param begin
	 * @param end
	 * @param categoryNo
	 * @return 상품정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<Product> getProductListByCategory(int begin, int end, int categoryNo) throws SQLException {
		return productDao.getProductListByCategory(begin, end, categoryNo);
	}
	
	/**
	 * 지정받은 상품번호에 해당하는 상품정보를 반환한다.
	 * @param productNo 상품번호
	 * @return 상품정보
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public Product getProductByNo(int productNo) throws SQLException {
		return productDao.getProductByNo(productNo);
	}
	
	/**
	 * 지정된 상품번호에 해당되는 품목정보를 반환한다.
	 * @param productNo 상품번호
	 * @return 품목정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<ProductItem> getItemsByProductNo(int productNo) throws SQLException {
		return productItemDao.getItemsByProductNo(productNo);
	}
	
	/**
	 * 지정된 상품번호에 해당되는 상품의 섬네일이미지 정보를 반환한다.
	 * @param productNo 상품번호
	 * @return 섬네일이미지 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<ProductThumbnailImage> getThumbnailImagesByProductNo(int productNo) throws SQLException {
		return productThumbnailImageDao.getThumbnailImagesByProductNo(productNo);
	}
	
	/**
	 * 지정된 상품번호에 해당되는 상품의 상세이미지 정보를 반환한다.
	 * @param productNo 상품번호
	 * @return 상세이미지 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<ProductDetailImage> getDetailImagesByProductNo(int productNo) throws SQLException {
		return productDetailImageDao.getDetailImagesByProductNo(productNo);
	}
	
	
	/**************************************************************************
	 * 주문관리 기능                                                              * 
	 **************************************************************************/
	
	/**************************************************************************
	 * 고객관리 기능                                                              * 
	 **************************************************************************/
}
