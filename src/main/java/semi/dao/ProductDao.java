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

import semi.vo.ProductItem;

import semi.vo.ProductDetailImage;



public class ProductDao {
	
	private static ProductDao self = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return self;
	}
	
	public List<String> getProductThumbnailImage(int no) throws SQLException {
		String sql = "select thumbnail_image_url "
				   + "from semi_product_thumbnail_image "
				   + "where product_no = ? ";
		
		List<String> urlList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			urlList.add(rs.getString("thumbnail_image_url"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return urlList;
	}
	
	public Product getProductDetail(int no) throws SQLException {
		String sql = "select p.product_no, p.product_name, p.product_price, p.product_discount_price, "
				   + "       p.product_discount_from, p.product_discount_to, p.product_created_date, "
				   + "		 p.product_updated_date, p.product_on_sale, p.product_detail, c.category_no, "
				   + "		 c.category_name "
				   + "from semi_product p, semi_product_category c "
				   + "where p.category_no = c.category_no "
				   + "		and p.product_no = ? ";
				
		Product product = null;		
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
			
		if (rs.next()) {
			product = new Product();
			ProductCategory category = new ProductCategory();
			
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDiscountPrice(rs.getInt("product_discount_price"));
			product.setDiscountFrom(rs.getDate("product_discount_from"));
			product.setDiscountTo(rs.getDate("product_discount_to"));
			product.setCreatedDate(rs.getDate("product_created_date"));
			product.setUpdatedDate(rs.getDate("product_updated_date"));
			product.setOnSale(rs.getString("product_on_sale"));
			product.setDetail(rs.getString("product_detail"));
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			product.setProductCategory(category);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return product;
	}
	
	public List<ProductItem> getProductItemList(int no) throws SQLException {
		String sql = "select p.product_no, p.product_name, p.product_price, p.product_discount_price, "
				   + "       p.product_discount_from, p.product_discount_to, p.product_created_date, "
				   + "		 p.product_updated_date, p.product_on_sale, p.product_detail, c.category_no, "
				   + "		 c.category_name, i.product_item_no, i.product_size, i.product_color, "
				   + "		 i.product_stock, i.product_sale_count "
				   + "from semi_product p, semi_product_category c, semi_product_item i "
				   + "where p.category_no = c.category_no"
				   + "		and p.product_no = i.product_no "
				   + "		and p.product_no = ? ";
				
		List<ProductItem> productItemList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			ProductItem productItem = new ProductItem();
			productItem.setNo(rs.getInt("product_item_no"));
			productItem.setSize(rs.getString("product_size"));
			productItem.setColor(rs.getString("product_color"));
			productItem.setStock(rs.getInt("product_stock"));
			productItem.setSaleCount(rs.getInt("product_sale_count"));
			
			Product product = new Product();
			ProductCategory category = new ProductCategory();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDiscountPrice(rs.getInt("product_discount_price"));
			product.setDiscountFrom(rs.getDate("product_discount_from"));
			product.setDiscountTo(rs.getDate("product_discount_to"));
			product.setCreatedDate(rs.getDate("product_created_date"));
			product.setUpdatedDate(rs.getDate("product_updated_date"));
			product.setOnSale(rs.getString("product_on_sale"));
			product.setDetail(rs.getString("product_detail"));
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			product.setProductCategory(category);
			productItem.setProduct(product);
			
			productItemList.add(productItem);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return productItemList;
	}

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
