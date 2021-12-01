package semi.service;

import java.sql.SQLException;
import java.util.List;

import semi.dao.ProductCategoryDao;
import semi.dao.ProductDao;
import semi.vo.Product;
import semi.vo.ProductCategory;

public class AdminService {

	private final ProductCategoryDao categoryDao = new ProductCategoryDao();
//	private final ProductDao productDao = new ProductDao();
	
	private static AdminService service = new AdminService();
	private AdminService() {}
	public static AdminService getInstance() {
		return service;
	}
	
	/**************************************************************************
	 * 카테고리 관련 서비스                                                         * 
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
	
	
	/**************************************************************************
	 * 상품 관련 서비스                                                            * 
	 **************************************************************************/
	
	/**
	 * 모든 상품정보를 반환한다.
	 * @return 상품정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */ 
//	public List<Product> getAllProducts() throws SQLException {
//		return productDao.getAllProducts();
//	}
	
	/**
	 * 지정된 카테고리번호에 해당하는 상품정보를 반환한다.
	 * @param categoryNo 카테고리번호
	 * @return 상품정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
//	public List<Product> getProductsByCategory(int categoryNo) throws SQLException {
//		return productDao.getProductsByCategory(categoryNo);
//	}
	
	
	
}
