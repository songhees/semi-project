package semi.dao;

import static utils.ConnectionUtil.getConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.Product;
import semi.vo.ProductCategory;

public class ProductDao {

	private static ProductDao self = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return self;
	}
	
	public List<Product> getProductListBycategory(int begin, int end, String category, String orderBy) throws SQLException {
		String sql = "SELECT PRODUCT_NO, CATEGORY_NO, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DISCOUNT_PRICE, \n"
				+ "       PRODUCT_DISCOUNT_FROM, PRODUCT_DISCOUNT_TO, PRODUCT_CREATED_DATE, PRODUCT_UPDATED_DATE, \n"
				+ "       PRODUCT_ON_SALE, PRODUCT_DETAIL, CATEGORY_NAME \n"
				+ "FROM (SELECT ROW_NUMBER() OVER (ORDER BY "
				+ orderByToSqlOrderBy(orderBy)
				+ ") RN, P.PRODUCT_NO, P.CATEGORY_NO, \n"
				+ "             P.PRODUCT_NAME, P.PRODUCT_PRICE, P.PRODUCT_DISCOUNT_PRICE, P.PRODUCT_DISCOUNT_FROM, \n"
				+ "             P.PRODUCT_DISCOUNT_TO, P.PRODUCT_CREATED_DATE, P.PRODUCT_UPDATED_DATE, \n"
				+ "             P.PRODUCT_ON_SALE, P.PRODUCT_DETAIL, C.CATEGORY_NAME \n"
				+ "      FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C \n"
				+ "      WHERE P.CATEGORY_NO = C.CATEGORY_NO \n"
				+ "            AND C.CATEGORY_NAME = ?) \n"
				+ "WHERE RN >= ? AND RN <= ?";
		
		List<Product> products = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		System.out.println("begin: " + begin);
		System.out.println("end: " + end);
		System.out.println("category: " + category);
		pstmt.setString(1, category);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Product product = new Product();
			ProductCategory productCategory = new ProductCategory();
			
			product.setNo(rs.getInt("PRODUCT_NO"));
			product.setName(rs.getString("PRODUCT_NAME"));
			product.setPrice(rs.getLong("PRODUCT_PRICE"));
			product.setDiscountPrice(rs.getLong("PRODUCT_DISCOUNT_PRICE"));
			product.setDiscountFrom(rs.getDate("PRODUCT_DISCOUNT_FROM"));
			product.setDiscountTo(rs.getDate("PRODUCT_DISCOUNT_TO"));
			product.setCreatedDate(rs.getDate("PRODUCT_CREATED_DATE"));
			product.setUpdatedDate(rs.getDate("PRODUCT_UPDATED_DATE"));
			product.setOnSale(rs.getString("PRODUCT_ON_SALE"));
			product.setDetail(rs.getString("PRODUCT_DETAIL"));
			
			productCategory.setNo(rs.getInt("CATEGORY_NO"));
			productCategory.setName(rs.getString("CATEGORY_NAME"));
			
			product.setCategory(productCategory);
			
			products.add(product);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	// 정렬순서를 sql문에 맞는 문법으로 변환한다.
	private String orderByToSqlOrderBy(String orderBy) {
		if ("신상품".equals(orderBy)) {
			return "P.PRODUCT_CREATED_DATE DESC";
		}
		if ("낮은가격".equals(orderBy)) {
			return "P.PRODUCT_PRICE ASC";
		}
		if ("높은가격".equals(orderBy)) {
			return "P.PRODUCT_PRICE DESC";
		}
		// TODO 미구현
		if ("인기상품".equals(orderBy)) {
			return "PRODUCT_SALE_COUNT DESC";
		}
		// TODO 미구현
		if ("사용후기".equals(orderBy)) {
			return "PRODUCT_CREATED_DATE DESC";
		}
		
		return null;
	}
	
	// TODO 미구현
	public List<Product> getAllProductList(int begin, int end, String order) {
		String sql = "";
		
		return null;
	}
	
	// TODO 미구현
	public int getTotalRecords(String category) throws SQLException {
		String sql = "SELECT COUNT(*) CN \n"
				+ "FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C \n"
				+ "WHERE P.CATEGORY_NO = C.CATEGORY_NO \n"
				+ "      AND C.CATEGORY_NAME = ?";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, category);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		totalRecords = rs.getInt("CN");
		
		return totalRecords;
	}
}
