package semi.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static utils.ConnectionUtil.*;
import semi.vo.ProductCategory;

public class AdminProductCategoryDao {

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
			category.setNo(rs.getInt("CATEGORY_NO"));
			category.setName(rs.getString("CATEGORY_NAME"));
			
			categories.add(category);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return categories;
	}
	
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
