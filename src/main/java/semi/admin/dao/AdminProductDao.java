package semi.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static utils.ConnectionUtil.*;
import semi.vo.Product;
import semi.vo.ProductCategory;

public class AdminProductDao {

	public List<Product> getAllProducts() throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "SELECT P.PRODUCT_NO, "
				   + "       P.PRODUCT_NAME, "
				   + "       P.PRODUCT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_FROM, "
				   + "       P.PRODUCT_DISCOUNT_TO, "
				   + "       P.PRODUCT_CREATED_DATE, "
				   + "       P.PRODUCT_UPDATED_DATE, "
				   + "       P.PRODUCT_ON_SALE, "
				   + "       P.PRODUCT_DETAIL, "
				   + "       P.PRODUCT_TOTAL_SALE_COUNT, "
				   + "       P.PRODUCT_TOTAL_STOCK, "
				   + "       P.PRODUCT_AVERAGE_REVIEW_RATE, "
				   + "       C.CATEGORY_NO, "
				   + "       C.CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C "
				   + "WHERE P.CATEGORY_NO = C.CATEGORY_NO "
				   + "ORDER BY P.PRODUCT_NO ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			products.add(rowToProduct(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	public List<Product> getAllProductsOrderByCategory() throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "SELECT P.PRODUCT_NO, "
				   + "       P.PRODUCT_NAME, "
				   + "       P.PRODUCT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_FROM, "
				   + "       P.PRODUCT_DISCOUNT_TO, "
				   + "       P.PRODUCT_CREATED_DATE, "
				   + "       P.PRODUCT_UPDATED_DATE, "
				   + "       P.PRODUCT_ON_SALE, "
				   + "       P.PRODUCT_DETAIL, "
				   + "       P.PRODUCT_TOTAL_SALE_COUNT, "
				   + "       P.PRODUCT_TOTAL_STOCK, "
				   + "       P.PRODUCT_AVERAGE_REVIEW_RATE, "
				   + "       C.CATEGORY_NO, "
				   + "       C.CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C "
				   + "WHERE P.CATEGORY_NO = C.CATEGORY_NO "
				   + "ORDER BY C.CATEGORY_NO ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			products.add(rowToProduct(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	public List<Product> getProductsByCategory(int categoryNo) throws SQLException {
		List<Product> products = new ArrayList<>();
		
		String sql = "SELECT P.PRODUCT_NO, "
				   + "       P.PRODUCT_NAME, "
				   + "       P.PRODUCT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_FROM, "
				   + "       P.PRODUCT_DISCOUNT_TO, "
				   + "       P.PRODUCT_CREATED_DATE, "
				   + "       P.PRODUCT_UPDATED_DATE, "
				   + "       P.PRODUCT_ON_SALE, "
				   + "       P.PRODUCT_DETAIL, "
				   + "       P.PRODUCT_TOTAL_SALE_COUNT, "
				   + "       P.PRODUCT_TOTAL_STOCK, "
				   + "       P.PRODUCT_AVERAGE_REVIEW_RATE, "
				   + "       C.CATEGORY_NO, "
				   + "       C.CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C "
				   + "WHERE P.CATEGORY_NO = C.CATEGORY_NO "
				   + "AND P.CATEGORY_NO = ? "
				   + "ORDER BY P.PRODUCT_NO ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, categoryNo);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			products.add(rowToProduct(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	public int getTotalRecords() throws SQLException {
		int totalRecords = 0;
		
		String sql = "SELECT COUNT(*) CNT "
				   + "FROM SEMI_PRODUCT";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		totalRecords = rs.getInt("CNT");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	public int getTotalRecordsByCategory(int categoryNo) throws SQLException {
		int totalRecords = 0;
		
		String sql = "SELECT COUNT(*) CNT "
				   + "FROM SEMI_PRODUCT "
				   + "WHERE CATEGORY_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, categoryNo);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		totalRecords = rs.getInt("CNT");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	public List<Product> getProductList(int begin, int end) throws SQLException {
		List<Product> productList = new ArrayList<>();
		
		String sql = "SELECT RN, "
		           + "       PRODUCT_NO, "
		           + "       PRODUCT_NAME, "
		           + "       PRODUCT_PRICE, "
		           + "       PRODUCT_DISCOUNT_PRICE, "
		           + "       PRODUCT_DISCOUNT_FROM, "
		           + "       PRODUCT_DISCOUNT_TO, "
		           + "       PRODUCT_CREATED_DATE, "
		           + "       PRODUCT_UPDATED_DATE, "
		           + "       PRODUCT_ON_SALE, "
		           + "       PRODUCT_DETAIL, "
		           + "       PRODUCT_TOTAL_SALE_COUNT, "
		           + "       PRODUCT_TOTAL_STOCK, "
		           + "       PRODUCT_AVERAGE_REVIEW_RATE, "
		           + "       CATEGORY_NO, "
		           + "       CATEGORY_NAME "
		           + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY P.PRODUCT_UPDATED_DATE DESC) RN, "
		           + "             P.PRODUCT_NO, "
		           + "             P.PRODUCT_NAME, "
		           + "             P.PRODUCT_PRICE, "
		           + "             P.PRODUCT_DISCOUNT_PRICE, "
		           + "             P.PRODUCT_DISCOUNT_FROM, "
		           + "             P.PRODUCT_DISCOUNT_TO, "
		           + "             P.PRODUCT_CREATED_DATE, "
		           + "             P.PRODUCT_UPDATED_DATE, "
		           + "             P.PRODUCT_ON_SALE, "
		           + "             P.PRODUCT_DETAIL, "
		           + "             P.PRODUCT_TOTAL_SALE_COUNT, "
		           + "             P.PRODUCT_TOTAL_STOCK, "
		           + "             P.PRODUCT_AVERAGE_REVIEW_RATE, "
		           + "             C.CATEGORY_NO, "
		           + "             C.CATEGORY_NAME "
		           + "      FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C "
		           + "      WHERE P.CATEGORY_NO = C.CATEGORY_NO) "
				   + "WHERE RN >= ? AND RN <= ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			productList.add(rowToProduct(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productList;
	}
	
	public List<Product> getProductListByCategory(int begin, int end, int categoryNo) throws SQLException {
		List<Product> productList = new ArrayList<>();
		
		String sql = "SELECT RN, "
		           + "       PRODUCT_NO, "
		           + "       PRODUCT_NAME, "
		           + "       PRODUCT_PRICE, "
		           + "       PRODUCT_DISCOUNT_PRICE, "
		           + "       PRODUCT_DISCOUNT_FROM, "
		           + "       PRODUCT_DISCOUNT_TO, "
		           + "       PRODUCT_CREATED_DATE, "
		           + "       PRODUCT_UPDATED_DATE, "
		           + "       PRODUCT_ON_SALE, "
		           + "       PRODUCT_DETAIL, "
		           + "       PRODUCT_TOTAL_SALE_COUNT, "
		           + "       PRODUCT_TOTAL_STOCK, "
		           + "       PRODUCT_AVERAGE_REVIEW_RATE, "
		           + "       CATEGORY_NO, "
		           + "       CATEGORY_NAME "
		           + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY P.PRODUCT_NO ASC) RN, "
		           + "             P.PRODUCT_NO, "
		           + "             P.PRODUCT_NAME, "
		           + "             P.PRODUCT_PRICE, "
		           + "             P.PRODUCT_DISCOUNT_PRICE, "
		           + "             P.PRODUCT_DISCOUNT_FROM, "
		           + "             P.PRODUCT_DISCOUNT_TO, "
		           + "             P.PRODUCT_CREATED_DATE, "
		           + "             P.PRODUCT_UPDATED_DATE, "
		           + "             P.PRODUCT_ON_SALE, "
		           + "             P.PRODUCT_DETAIL, "
		           + "             P.PRODUCT_TOTAL_SALE_COUNT, "
		           + "             P.PRODUCT_TOTAL_STOCK, "
		           + "             P.PRODUCT_AVERAGE_REVIEW_RATE, "
		           + "             C.CATEGORY_NO, "
		           + "             C.CATEGORY_NAME "
		           + "      FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C "
		           + "      WHERE P.CATEGORY_NO = C.CATEGORY_NO"
		           + "      AND P.CATEGORY_NO = ?) "
				   + "WHERE RN >= ? AND RN <= ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, categoryNo);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			productList.add(rowToProduct(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productList;
	}
	
	public Product getProductByNo(int productNo) throws SQLException {
		Product product = new Product();
		
		String sql = "SELECT P.PRODUCT_NO, "
				   + "       P.PRODUCT_NAME, "
				   + "       P.PRODUCT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_PRICE, "
				   + "       P.PRODUCT_DISCOUNT_FROM, "
				   + "       P.PRODUCT_DISCOUNT_TO, "
				   + "       P.PRODUCT_CREATED_DATE, "
				   + "       P.PRODUCT_UPDATED_DATE, "
				   + "       P.PRODUCT_ON_SALE, "
				   + "       P.PRODUCT_DETAIL, "
				   + "       P.PRODUCT_TOTAL_SALE_COUNT, "
				   + "       P.PRODUCT_TOTAL_STOCK, "
				   + "       P.PRODUCT_AVERAGE_REVIEW_RATE, "
				   + "       C.CATEGORY_NO, "
				   + "       C.CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C "
				   + "WHERE P.CATEGORY_NO = C.CATEGORY_NO "
				   + "AND P.PRODUCT_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			product = rowToProduct(rs);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return product;
	}
	
	public int getProductNo() throws SQLException {
		int productNo = 0;
		
		String sql = "SELECT PRODUCT_SEQ.NEXTVAL SEQ FROM DUAL";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		productNo = rs.getInt("SEQ");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productNo;
	}
	
	public void addProduct(Product product) throws SQLException {
		String sql = "INSERT INTO SEMI_PRODUCT ( "
				   + "	PRODUCT_NO, "
				   + "	CATEGORY_NO, "
				   + "	PRODUCT_NAME, "
				   + "	PRODUCT_PRICE) "
				   + "VALUES (?, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, product.getNo());
		pstmt.setInt(2, product.getProductCategory().getNo());
		pstmt.setString(3, product.getName());
		pstmt.setLong(4, product.getPrice());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void updateProduct(Product product) throws SQLException {
		String sql = "UPDATE SEMI_PRODUCT "
				   + "SET CATEGORY_NO = ?, "
				   + "	  PRODUCT_NAME = ?, "
				   + "    PRODUCT_PRICE = ?, "
				   + "    PRODUCT_DISCOUNT_PRICE = ?, "
				   + "    PRODUCT_DISCOUNT_FROM = ?, "
				   + "    PRODUCT_DISCOUNT_TO = ?, "
				   + "    PRODUCT_UPDATED_DATE = SYSDATE, "
				   + "    PRODUCT_ON_SALE = ?, "
				   + "    PRODUCT_DETAIL = ?, "
				   + "    PRODUCT_TOTAL_SALE_COUNT = ?, "
				   + "    PRODUCT_TOTAL_STOCK = ?, "
				   + "    PRODUCT_AVERAGE_REVIEW_RATE = ? "
				   + "WHERE PRODUCT_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, product.getProductCategory().getNo());
		pstmt.setString(2, product.getName());
		pstmt.setLong(3, product.getPrice());
		pstmt.setLong(4, product.getDiscountPrice());
		if (product.getDiscountFrom() == null) {
			pstmt.setDate(5, null);
		} else {
			pstmt.setDate(5, new java.sql.Date(product.getDiscountFrom().getTime()));
		}
		if (product.getDiscountTo() == null) {
			pstmt.setDate(6, null);
		} else {			
			pstmt.setDate(6, new java.sql.Date(product.getDiscountTo().getTime()));
		}
		pstmt.setString(7, product.getOnSale());
		pstmt.setString(8, product.getDetail());
		pstmt.setInt(9, product.getTotalSaleCount());
		pstmt.setInt(10, product.getTotalStock());
		pstmt.setDouble(11, product.getAverageReviewRate());
		pstmt.setInt(12, product.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	private Product rowToProduct(ResultSet rs) throws SQLException {
		Product product = new Product();
		
		product.setNo(rs.getInt("PRODUCT_NO"));
		product.setName(rs.getString("PRODUCT_NAME"));
		product.setPrice(rs.getInt("PRODUCT_PRICE"));
		product.setDiscountPrice(rs.getInt("PRODUCT_DISCOUNT_PRICE"));
		product.setDiscountFrom(rs.getDate("PRODUCT_DISCOUNT_FROM"));
		product.setDiscountTo(rs.getDate("PRODUCT_DISCOUNT_TO"));
		product.setCreatedDate(rs.getDate("PRODUCT_CREATED_DATE"));
		product.setUpdatedDate(rs.getDate("PRODUCT_UPDATED_DATE"));
		product.setOnSale(rs.getString("PRODUCT_ON_SALE"));
		product.setDetail(rs.getString("PRODUCT_DETAIL"));
		product.setTotalSaleCount(rs.getInt("PRODUCT_TOTAL_SALE_COUNT"));
		product.setTotalStock(rs.getInt("PRODUCT_TOTAL_STOCK"));
		product.setAverageReviewRate(rs.getDouble("PRODUCT_AVERAGE_REVIEW_RATE"));
		
		ProductCategory category = new ProductCategory();
		category.setNo(rs.getInt("CATEGORY_NO"));
		category.setName(rs.getString("CATEGORY_NAME"));
		product.setProductCategory(category);
		
		return product;
	}
}
