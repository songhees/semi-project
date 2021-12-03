package semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.Review;

import static utils.ConnectionUtil.getConnection;

public class ReviewDao {
	
	private static ReviewDao self = new ReviewDao();
	private ReviewDao() {}
	public static ReviewDao getInstance() {
		return self;
	}
	
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from semi_product_review ";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	public List<Review> getReviewList(int begin, int end) throws SQLException {
		String sql = "";
		
		List<Review> reviewList = new ArrayList<>();
		
		
		return reviewList;
	}

}
