package semi.admin.dao;

import static utils.ConnectionUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.ProductThumbnailImage;

public class AdminProductThumbnailImageDao {

	public List<ProductThumbnailImage> getThumbnailImagesByProductNo(int productNo) throws SQLException {
		List<ProductThumbnailImage> images = new ArrayList<>();
		
		String sql = "SELECT PRODUCT_NO, THUMBNAIL_IMAGE_URL "
				   + "FROM SEMI_PRODUCT_THUMBNAIL_IMAGE "
				   + "WHERE PRODUCT_NO = ? "
				   + "ORDER BY THUMBNAIL_IMAGE_URL ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			ProductThumbnailImage image = new ProductThumbnailImage();
			
			image.setNo(rs.getInt("PRODUCT_NO"));
			image.setUrl(rs.getString("THUMBNAIL_IMAGE_URL"));
			
			images.add(image);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return images;
	}
	
	public void addThumbnailImage(ProductThumbnailImage image) throws SQLException {
		String sql = "INSERT INTO SEMI_PRODUCT_THUMBNAIL_IMAGE (PRODUCT_NO, THUMBNAIL_IMAGE_URL) "
				   + "VALUES (?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, image.getNo());
		pstmt.setString(2, image.getUrl());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void removeThumbnailImage(int productNo) throws SQLException {
		String sql = "DELETE FROM SEMI_PRODUCT_THUMBNAIL_IMAGE "
				   + "WHERE PRODUCT_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
}
