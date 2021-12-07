package semi.admin.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.Product;
import semi.vo.ProductStyle;

public class AdminProductStyleDao {
	
	AdminProductDao productDao = new AdminProductDao();

	public void addStyle(ProductStyle style) throws SQLException {
		String sql = "INSERT INTO SEMI_PRODUCT_STYLE ( "
				   + "	PRODUCT_STYLE_NO, "
				   + "	PRODUCT_NO) "
				   + "VALUES (?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, style.getNo());
		pstmt.setInt(2, style.getProduct().getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public List<ProductStyle> getStylesByNo(int productNo) throws SQLException {
		List<ProductStyle> styles = new ArrayList<>();
		
		String sql = "SELECT PRODUCT_STYLE_NO, PRODUCT_NO "
				   + "FROM SEMI_PRODUCT_STYLE "
				   + "WHERE PRODUCT_STYLE_NO = ? "
				   + "ORDER BY PRODUCT_NO ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			ProductStyle style = new ProductStyle();
			
			style.setNo(rs.getInt("PRODUCT_STYLE_NO"));
			int styleProductNo = rs.getInt("PRODUCT_NO");
			Product product = new Product();
			product = productDao.getProductByNo(styleProductNo);
			style.setProduct(product);
			
			styles.add(style);
		}
		
		return styles;
	}
}
