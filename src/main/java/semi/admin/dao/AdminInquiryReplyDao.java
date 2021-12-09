package semi.admin.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import semi.vo.InquiryReply;
import semi.vo.User;

public class AdminInquiryReplyDao {
	
	AdminUserDao userDao = new AdminUserDao();

	public InquiryReply getReplyByInquiryNo(int inquiryNo) throws SQLException {
		InquiryReply reply = null;
		
		String sql = "SELECT REPLY_NO, "
				   + "       INQUIRY_NO, "
				   + "       USER_NO, "
				   + "       REPLY_CONTENT, "
				   + "       REPLY_CREATED_DATE "
				   + "FROM SEMI_PRODUCT_INQUIRY_REPLY "
				   + "WHERE INQUIRY_NO = ? "
				   + "AND REPLY_DELETED = 'N'";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, inquiryNo);
		ResultSet rs= pstmt.executeQuery();
		
		if (rs.next()) {
			reply = new InquiryReply();
			reply.setNo(rs.getInt("REPLY_NO"));
			reply.setInquiryNo(rs.getInt("INQUIRY_NO"));
			User writer = new User();
			writer = userDao.getUserByNo(rs.getInt("USER_NO"));
			reply.setWriter(writer);
			reply.setContent(rs.getString("REPLY_CONTENT"));
			reply.setCreatedDate(rs.getDate("REPLY_CREATED_DATE"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return reply;
	}
	
	public void addReply(InquiryReply reply) throws SQLException {
		String sql = "INSERT INTO SEMI_PRODUCT_INQUIRY_REPLY ( "
				   + "	REPLY_NO, "
				   + "  INQUIRY_NO, "
				   + "  USER_NO, "
				   + "  REPLY_CONTENT, "
				   + "  REPLY_CREATED_DATE) "
				   + "VALUES (REPLY_SEQ.NEXTVAL, ?, ?, ?, SYSDATE)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, reply.getInquiryNo());
		pstmt.setInt(2, reply.getWriter().getNo());
		pstmt.setString(3, reply.getContent());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void updateReply(InquiryReply reply) throws SQLException {
		String sql = "UPDATE SEMI_PRODUCT_INQUIRY_REPLY "
				   + "SET REPLY_CONTENT = ? "
				   + "WHERE REPLY_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, reply.getContent());
		pstmt.setInt(2, reply.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void deleteReply(int replyNo) throws SQLException {
		String sql = "UPDATE SEMI_PRODUCT_INQUIRY_REPLY "
				   + "SET REPLY_DELETED = 'Y' "
				   + "WHERE REPLY_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, replyNo);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
}
