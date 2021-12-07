package semi.admin.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.ProductDetailImage;

public class AdminProductDetailImageDao {

	public List<ProductDetailImage> getDetailImagesByProductNo(int productNo) throws SQLException {
		List<ProductDetailImage> images = new ArrayList<>();
		
		String sql = "SELECT PRODUCT_NO, DETAIL_IMAGE_URL "
				   + "FROM SEMI_PRODUCT_DETAIL_IMAGE "
				   + "WHERE PRODUCT_NO = ? "
				   + "ORDER BY DETAIL_IMAGE_URL ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			ProductDetailImage image = new ProductDetailImage();
			
			image.setProductNo(rs.getInt("PRODUCT_NO"));
			image.setUrl(rs.getString("DETAIL_IMAGE_URL"));
			
			images.add(image);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return images;
	}
	
	public void addDetailImage(ProductDetailImage image) throws SQLException {
		String sql = "INSERT INTO SEMI_PRODUCT_DETAIL_IMAGE (PRODUCT_NO, DETAIL_IMAGE_URL) "
				   + "VALUES (?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, image.getProductNo());
		pstmt.setString(2, image.getUrl());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void removeDetailImage(int productNo) throws SQLException {
		String sql = "DELETE FROM SEMI_PRODUCT_DETAIL_IMAGE "
				   + "WHERE PRODUCT_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
}
