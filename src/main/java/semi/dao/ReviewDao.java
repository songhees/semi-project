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
	
	public int getTotalRecordsByProductNo(int no) throws SQLException {
		String sql = "select count(*) cnt "
				   + "from semi_product_review "
				   + "where product_no = ?"
				   + "and review_deleted = 'N' ";
		
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	public List<Review> getReviewList(int no, int begin, int end, String reviewOrderBy) throws SQLException {
		String sql = "";
		if (reviewOrderBy == "최신순") {
			sql = "select review_no, user_no, review_rate, review_content, review_created_date "
			    + "from (select row_number() over (order by review_no desc) rn, "
			    + "      review_no, user_no, review_rate, review_content, review_created_date "
			    + "      from semi_product_review"
			    + "      where product_no = ? "
			    + "      and review_deleted = 'N') "
			    + "where rn >= ? and rn <= ? "
			    + "order by rn ";
		} else {
			sql = "select review_no, user_no, review_rate, review_content, review_created_date "
			    + "from (select row_number() over (order by review_rate desc) rn, "
			    + "      review_no, user_no, review_rate, review_content, review_created_date "
			    + "      from semi_product_review"
			    + "      where product_no = ? "
			    + "      and review_deleted = 'N') "
			    + "where rn >= ? and rn <= ? "
			    + "order by rn ";
		}
		
		List<Review> reviewList = new ArrayList<>();

		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.setInt(2, begin);
		pstmt.setInt(3, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			Review review = new Review();
			review.setNo(rs.getInt("review_no"));
			review.setUserNo(rs.getInt("user_no"));
			review.setRate(rs.getInt("review_rate"));
			review.setContent(rs.getString("review_content"));
			review.setCreatedDate(rs.getDate("review_created_date"));
			reviewList.add(review);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return reviewList;
	}
	
	public List<String> getReviewImageNameListByReviewNo(int reviewNo) throws SQLException {
		String sql = "select review_image_name "
				   + "from semi_review_image "
				   + "where review_no = ? ";
		
		List<String> reviewImageNameList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, reviewNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			reviewImageNameList.add(rs.getString("review_image_name"));
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return reviewImageNameList;
	}
	
	public int getReviewNo() throws SQLException {
		String sql = "select review_seq.nextval seq from dual";
		
		int reviewNo = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		reviewNo = rs.getInt("seq");
		rs.close();
		pstmt.close();
		connection.close();
		
		return reviewNo;
	}
	
	public void insertProductReview(Review review) throws SQLException {
		String sql = "insert into semi_product_review "
				   + "(review_no, user_no, product_no, review_content, review_rate) "
				   + "values (?, ?, ?, ?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, review.getNo());
		pstmt.setInt(2, review.getUserNo());
		pstmt.setInt(3, review.getProductNo());
		pstmt.setString(4, review.getContent());
		pstmt.setInt(5, review.getRate());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void insertReviewImage(Review review) throws SQLException {
		String sql = "insert into semi_review_image "
				   + "(review_no, review_image_name) "
				   + "values (?, ?) ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, review.getNo());
		pstmt.setString(2, review.getFilename());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public Review getReviewDetailByReviewNo(int reviewNo) throws SQLException {
		String sql = "select user_no, product_no, review_rate, review_content, review_created_date "
				   + "from semi_product_review "
				   + "where review_no = ? ";
		
		Review review = null;
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, reviewNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			review = new Review();
			review.setUserNo(rs.getInt("user_no"));
			review.setProductNo(rs.getInt("product_no"));
			review.setRate(rs.getInt("review_rate"));
			review.setContent(rs.getString("review_content"));
			review.setCreatedDate(rs.getDate("review_created_date"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return review;
	}
	
	public void deleteReview(Review review) throws SQLException {
		String sql = "update semi_product_review "
				   + "set "
				   + "	review_deleted = ?, "
				   + "  review_deleted_date = sysdate "
				   + "where review_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, review.getDeleted());
		pstmt.setInt(2, review.getNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public List<Review> getReviewDetailByProductNo(int ProductNo) throws SQLException {
		String sql = "select review_no, user_no, review_rate, review_content, review_created_date "
				   + "from semi_product_review "
				   + "where product_no = ? ";
		
		List<Review> reviewList = new ArrayList<>();
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, ProductNo);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next()) {
			Review review = new Review();
			review.setUserNo(rs.getInt("user_no"));
			review.setNo(rs.getInt("review_no"));
			review.setRate(rs.getInt("review_rate"));
			review.setContent(rs.getString("review_content"));
			review.setCreatedDate(rs.getDate("review_created_date"));
			
			reviewList.add(review);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return reviewList;
	}

}
