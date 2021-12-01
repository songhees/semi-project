package semi.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import semi.criteria.ProductCriteria;
import semi.vo.Product;
import semi.vo.ProductCategory;

import semi.vo.ProductItem;


public class ProductDao {
	
	private static ProductDao self = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return self;
	}
	
	public List<Integer> getProductStyleNo(int no) throws SQLException {
		String sql = "select product_no "
				   + "from semi_product_style "
				   + "where product_style_no = ? ";
		
		List<Integer> productNo = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			productNo.add(rs.getInt("product_no"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productNo;
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
	
	public List<Product> getProductListBycategory(ProductCriteria criteria) throws SQLException {
		String sql = "SELECT PRODUCT_NO, CATEGORY_NO, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DISCOUNT_PRICE, \r\n"
				+ "       PRODUCT_DISCOUNT_FROM, PRODUCT_DISCOUNT_TO, PRODUCT_CREATED_DATE, PRODUCT_UPDATED_DATE, \r\n"
				+ "       PRODUCT_ON_SALE, PRODUCT_DETAIL, PRODUCT_TOTAL_SALE_COUNT, PRODUCT_TOTAL_STOCK, \r\n"
				+ "       PRODUCT_AVERAGE_REVIEW_RATE, CATEGORY_NAME, \r\n"
				+ "       REGEXP_REPLACE((SELECT LISTAGG(I.PRODUCT_COLOR, ',') WITHIN GROUP (ORDER BY A.PRODUCT_NO) \r\n"
				+ "                       FROM SEMI_PRODUCT_ITEM I\r\n"
				+ "                       WHERE I.PRODUCT_NO = A.PRODUCT_NO), '([^,]+)(,\\1)+', '\\1') COLORS \r\n"
				+ "FROM (SELECT ROW_NUMBER() OVER (ORDER BY "
				+				orderByToSqlOrderBy(criteria.getOrderBy())
				+ "				) RN, P.PRODUCT_NO, P.CATEGORY_NO, \r\n"
				+ "             P.PRODUCT_NAME, P.PRODUCT_PRICE, P.PRODUCT_DISCOUNT_PRICE, P.PRODUCT_DISCOUNT_FROM, \r\n"
				+ "             P.PRODUCT_DISCOUNT_TO, P.PRODUCT_CREATED_DATE, P.PRODUCT_UPDATED_DATE, \r\n"
				+ "             P.PRODUCT_ON_SALE, P.PRODUCT_DETAIL, P.PRODUCT_TOTAL_SALE_COUNT, \r\n"
				+ "             P.PRODUCT_TOTAL_STOCK, P.PRODUCT_AVERAGE_REVIEW_RATE, C.CATEGORY_NAME \r\n"
				+ "      FROM SEMI_PRODUCT P, SEMI_PRODUCT_CATEGORY C \r\n"
				+ "      WHERE P.CATEGORY_NO = C.CATEGORY_NO \r\n"
				+ "            AND C.CATEGORY_NAME = ?) A \r\n"
				+ "WHERE RN >= ? AND RN <= ?";
		
		List<Product> products = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		// TODO 테스트용 프린트
		System.out.println("begin: " + criteria.getBegin());
		System.out.println("end: " + criteria.getEnd());
		System.out.println("category: " + criteria.getCategory());
		pstmt.setString(1, criteria.getCategory());
		pstmt.setInt(2, criteria.getBegin());
		pstmt.setInt(3, criteria.getEnd());
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Product product = new Product();
			ProductCategory productCategory = new ProductCategory();
			List<String> colors = new ArrayList<>();
			
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
			product.setTotalSaleCount(rs.getInt("PRODUCT_TOTAL_SALE_COUNT"));
			product.setTotalStock(rs.getInt("PRODUCT_TOTAL_STOCK"));
			product.setAverageReviewRate(rs.getDouble("PRODUCT_AVERAGE_REVIEW_RATE"));
			
			productCategory.setNo(rs.getInt("CATEGORY_NO"));
			productCategory.setName(rs.getString("CATEGORY_NAME"));

			colors = stringToArrayList(rs.getString("COLORS"));
			
			product.setProductCategory(productCategory);
			product.setColors(colors);
			
			products.add(product);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	public List<Product> getAllProductList(ProductCriteria criteria) throws SQLException {
		String sql = "SELECT PRODUCT_NO, CATEGORY_NO, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DISCOUNT_PRICE, \r\n"
				+ "       PRODUCT_DISCOUNT_FROM, PRODUCT_DISCOUNT_TO, PRODUCT_CREATED_DATE, PRODUCT_UPDATED_DATE, \r\n"
				+ "       PRODUCT_ON_SALE, PRODUCT_DETAIL, PRODUCT_TOTAL_SALE_COUNT, PRODUCT_TOTAL_STOCK, \r\n"
				+ "       PRODUCT_AVERAGE_REVIEW_RATE, \r\n"
				+ "       REGEXP_REPLACE((SELECT LISTAGG(I.PRODUCT_COLOR, ',') WITHIN GROUP (ORDER BY A.PRODUCT_NO) \r\n"
				+ "                       FROM SEMI_PRODUCT_ITEM I\r\n"
				+ "                       WHERE I.PRODUCT_NO = A.PRODUCT_NO), '([^,]+)(,\\1)+', '\\1') COLORS \r\n"
				+ "FROM (SELECT ROW_NUMBER() OVER (ORDER BY "
				+ 				orderByToSqlOrderBy(criteria.getOrderBy())
				+ "				) RN, PRODUCT_NO, CATEGORY_NO, \r\n"
				+ "             PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_DISCOUNT_PRICE, PRODUCT_DISCOUNT_FROM, \r\n"
				+ "             PRODUCT_DISCOUNT_TO, PRODUCT_CREATED_DATE, PRODUCT_UPDATED_DATE, \r\n"
				+ "             PRODUCT_ON_SALE, PRODUCT_DETAIL, PRODUCT_TOTAL_SALE_COUNT, \r\n"
				+ "             PRODUCT_TOTAL_STOCK, PRODUCT_AVERAGE_REVIEW_RATE \r\n"
				+ "      FROM SEMI_PRODUCT P) A \r\n"
				+ "WHERE RN >= ? AND RN <= ?";
		
		List<Product> products = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		
		// TODO 테스트용 프린트
		System.out.println("begin: " + criteria.getBegin());
		System.out.println("end: " + criteria.getEnd());
		pstmt.setInt(1, criteria.getBegin());
		pstmt.setInt(2, criteria.getEnd());
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Product product = new Product();
			List<String> colors = new ArrayList<>();
			
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
			product.setTotalSaleCount(rs.getInt("PRODUCT_TOTAL_SALE_COUNT"));
			product.setTotalStock(rs.getInt("PRODUCT_TOTAL_STOCK"));
			product.setAverageReviewRate(rs.getDouble("PRODUCT_AVERAGE_REVIEW_RATE"));
			
			colors = stringToArrayList(rs.getString("COLORS"));
			product.setColors(colors);
			
			products.add(product);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return products;
	}
	
	/**
	 * 검색조건에 따른 상품의 총 개수를 구한다.
	 * @param criteria 검색조건
	 * @return 검색조건에 따른 상품의 총 개수
	 * @throws SQLException
	 */
	public int getProductTotalRecords(ProductCriteria criteria) throws SQLException {
		String sql = "SELECT COUNT(*) CN \n"
				+ "FROM SEMI_PRODUCT P";
		if (!"전체상품".equals(criteria.getCategory())) {
			sql += ", SEMI_PRODUCT_CATEGORY C \n"
				   + "WHERE P.CATEGORY_NO = C.CATEGORY_NO \n"
				   + "      AND C.CATEGORY_NAME = ?";
		} else {}
		
		int productTotalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		if (!"전체상품".equals(criteria.getCategory())) {
			pstmt.setString(1, criteria.getCategory());
		}
		ResultSet rs = pstmt.executeQuery();
		
		rs.next();
		productTotalRecords = rs.getInt("CN");
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productTotalRecords;
	}
	
	/**
	 * 정렬기준인 orderBy를 sql문에 적용할 수 있는 String으로 변환한다.
	 * @param orderBy 정렬기준
	 * @return sql문에 적용가능한 String
	 */
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
		if ("인기상품".equals(orderBy)) {
			return "P.PRODUCT_TOTAL_SALE_COUNT DESC";
		}
		if ("사용후기".equals(orderBy)) {
			return "P.PRODUCT_AVERAGE_REVIEW_RATE DESC";
		}
		
		// 기본값은 신상품 정렬기준이다.
		return "P.PRODUCT_CREATED_DATE DESC";
	}

	/**
	 * String을 쉼표(,)로 잘라서 List에 저장한다.
	 * @param str 자를 String
	 * @return 자르고 나온 String들을 저장한 List
	 */
	private List<String> stringToArrayList(String str) {
		List<String> result = new ArrayList<>();
		
		if (str == null) {
			return result;
		}
		result = Arrays.asList(str.split(","));
		
		return result;
	}
}
