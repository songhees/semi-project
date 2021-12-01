package semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static utils.ConnectionUtil.*;
import semi.vo.ProductCategory;

public class ProductCategoryDao {

	/**
	 * 모든 상품 카테고리정보를 반환한다.
	 * @return 상품 카테고리정보 목록
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public List<ProductCategory> getAllCategories() throws SQLException {
		List<ProductCategory> categories = new ArrayList<>();
		
		String sql = "SELECT CATEGORY_NO, CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT_CATEGORY "
				   + "ORDER BY CATEGORY_NO ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			ProductCategory category = new ProductCategory();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			categories.add(category);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return categories;
	}
	
	/**
	 * 지정받은 카테고리 번호에 해당되는 카테고리정보를 반환한다.
	 * @param categoryNo 카테고리번호
	 * @return 카테고리 정보
	 * @throws SQLException 데이터베이스 엑세스 작업 오류시 발생
	 */
	public ProductCategory getCategoryByNo(int categoryNo) throws SQLException {
		ProductCategory category = null;
		
		String sql = "SELECT CATEGORY_NO, CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT_CATEGORY "
				   + "WHERE CATEGORY_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, categoryNo);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			category = new ProductCategory();
			category.setNo(rs.getInt("CATEGORY_NO"));
			category.setName(rs.getString("CATEGORY_NAME"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return category;
	}
}
