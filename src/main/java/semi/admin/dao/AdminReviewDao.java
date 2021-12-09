package semi.admin.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.Product;
import semi.vo.Review2;
import semi.vo.User;

public class AdminReviewDao {
	
	AdminUserDao userDao = new AdminUserDao();
	AdminProductDao productDao = new AdminProductDao();
	
	public Review2 getReviewByNo(int no) throws SQLException {
		Review2 review = new Review2();
		
		String sql = "SELECT REVIEW_NO, "
				   + "       USER_NO, "
				   + "       PRODUCT_NO, "
				   + "       REVIEW_RATE, "
				   + "       REVIEW_CONTENT, "
				   + "       REVIEW_CREATED_DATE, "
				   + "       REVIEW_DELETED_DATE, "
				   + "       REVIEW_DELETED "
				   + "FROM SEMI_PRODUCT_REVIEW "
				   + "WHERE REVIEW_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			review = rowToReview(rs);
			review.setDeletedDate(rs.getDate("REVIEW_DELETED_DATE"));
			review.setDeleted(rs.getString("REVIEW_DELETED"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return review;
	}

	public List<Review2> getReviewList(int begin, int end) throws SQLException {
		List<Review2> reviewList = new ArrayList<>();
		
		String sql = "SELECT RN, "
				   + "       REVIEW_NO, "
				   + "       USER_NO, "
				   + "       PRODUCT_NO, "
				   + "       REVIEW_RATE, "
				   + "       REVIEW_CONTENT, "
				   + "       REVIEW_CREATED_DATE "
			       + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY REVIEW_CREATED_DATE DESC) RN, "
			       + "             REVIEW_NO, "
			       + "             USER_NO, "
			       + "             PRODUCT_NO, "
			       + "             REVIEW_RATE, "
			       + "             REVIEW_CONTENT, "
			       + "             REVIEW_CREATED_DATE "
			       + "      FROM SEMI_PRODUCT_REVIEW "
			       + "      WHERE REVIEW_DELETED = 'N') "
			       + "WHERE RN >= ? AND RN <= ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			reviewList.add(rowToReview(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return reviewList;
	}
	
	public int getTotalRecords() throws SQLException {
		int totalRecords = 0;
		
		String sql = "SELECT COUNT(*) CNT "
				   + "FROM SEMI_PRODUCT_REVIEW "
				   + "WHERE REVIEW_DELETED = 'N'";
		
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
	
	private Review2 rowToReview(ResultSet rs) throws SQLException {
		Review2 review = new Review2();
		
		review.setNo(rs.getInt("REVIEW_NO"));
		review.setRate(rs.getInt("REVIEW_RATE"));
		review.setContent(rs.getString("REVIEW_CONTENT"));
		review.setCreatedDate(rs.getDate("REVIEW_CREATED_DATE"));
		
		int userNo = rs.getInt("USER_NO");
		User user = new User();
		user = userDao.getUserByNo(userNo);
		review.setUser(user);
		
		int productNo = rs.getInt("PRODUCT_NO");
		Product product = new Product();
		product = productDao.getProductByNo(productNo);
		review.setProduct(product);
		
		return review;
	}
}
