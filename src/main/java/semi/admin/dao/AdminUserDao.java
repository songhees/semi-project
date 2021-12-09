package semi.admin.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.User;

public class AdminUserDao {
	
	public User getUserByNo(int no) throws SQLException {
		User user = null;
		
		String sql = "SELECT USER_NO, "
				   + "       GRADE_CODE, "
				   + "       USER_ID, "
				   + "       USER_PASSWORD, "
				   + "       USER_NAME, "
				   + "       USER_TEL, "
				   + "       USER_EMAIL, "
				   + "       USER_EMAIL_SUBSCRIPTION, "
				   + "       USER_SMS_SUBSCRIPTION, "
				   + "       USER_POINT, "
				   + "       USER_ADMIN, "
				   + "       USER_DELETED, "
				   + "       USER_DELETED_DATE, "
				   + "       USER_UPDATED_DATE, "
				   + "       USER_CREATED_DATE "
				   + "FROM SEMI_USER "
				   + "WHERE USER_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			user = new User();
			user = rowToUser(rs);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	public User getUserByEmail(String email) throws SQLException {
		User user = null;
		
		String sql = "SELECT USER_NO, "
				   + "       GRADE_CODE, "
				   + "       USER_ID, "
				   + "       USER_PASSWORD, "
				   + "       USER_NAME, "
				   + "       USER_TEL, "
				   + "       USER_EMAIL, "
				   + "       USER_EMAIL_SUBSCRIPTION, "
				   + "       USER_SMS_SUBSCRIPTION, "
				   + "       USER_POINT, "
				   + "       USER_ADMIN, "
				   + "       USER_DELETED, "
				   + "       USER_DELETED_DATE, "
				   + "       USER_UPDATED_DATE, "
				   + "       USER_CREATED_DATE "
				   + "FROM SEMI_USER "
				   + "WHERE USER_EMAIL = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			user = new User();
			user = rowToUser(rs);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}

	public User getUserById(String id) throws SQLException {
		User user = null;
		
		String sql = "SELECT USER_NO, "
				   + "       GRADE_CODE, "
				   + "       USER_ID, "
				   + "       USER_PASSWORD, "
				   + "       USER_NAME, "
				   + "       USER_TEL, "
				   + "       USER_EMAIL, "
				   + "       USER_EMAIL_SUBSCRIPTION, "
				   + "       USER_SMS_SUBSCRIPTION, "
				   + "       USER_POINT, "
				   + "       USER_ADMIN, "
				   + "       USER_DELETED, "
				   + "       USER_DELETED_DATE, "
				   + "       USER_UPDATED_DATE, "
				   + "       USER_CREATED_DATE "
				   + "FROM SEMI_USER "
				   + "WHERE USER_ID = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			user = new User();
			user = rowToUser(rs);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return user;
	}
	
	public void addUser(User user) throws SQLException {
		String sql = "INSERT INTO SEMI_USER ("
				   + "  USER_NO, "
				   + "	USER_ID, "
				   + "  USER_PASSWORD, "
				   + "  USER_NAME, "
				   + "  USER_TEL, "
				   + "  USER_EMAIL) "
				   + "VALUES (USER_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, user.getId());
		pstmt.setString(2, user.getPassword());
		pstmt.setString(3, user.getName());
		pstmt.setString(4, user.getTel());
		pstmt.setString(5, user.getEmail());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public int getTotalRecords() throws SQLException {
		int totalRecords = 0;
		
		String sql = "SELECT COUNT(*) CNT "
				   + "FROM SEMI_USER ";
		
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
	
	public List<User> getUserList(int begin, int end) throws SQLException {
		List<User> userList = new ArrayList<>();
		
		String sql = "SELECT RN, "
				   + "       USER_NO, "
				   + "       GRADE_CODE, "
				   + "       USER_ID, "
				   + "       USER_PASSWORD, "
				   + "       USER_NAME, "
				   + "       USER_TEL, "
				   + "       USER_EMAIL, "
				   + "       USER_EMAIL_SUBSCRIPTION, "
				   + "       USER_SMS_SUBSCRIPTION, "
				   + "       USER_POINT, "
				   + "       USER_ADMIN, "
				   + "       USER_DELETED, "
				   + "       USER_DELETED_DATE, "
				   + "       USER_UPDATED_DATE, "
				   + "       USER_CREATED_DATE "
				   + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY U.USER_CREATED_DATE DESC) RN,"
				   + "             U.USER_NO, "
				   + "			   U.GRADE_CODE, "
				   + "			   U.USER_ID, "
				   + "             U.USER_PASSWORD, "
				   + "			   U.USER_NAME, "
				   + "			   U.USER_TEL, "
				   + "			   U.USER_EMAIL, "
				   + "			   U.USER_EMAIL_SUBSCRIPTION, "
				   + "			   U.USER_SMS_SUBSCRIPTION, "
				   + "			   U.USER_POINT, "
				   + "             U.USER_ADMIN, "
				   + "			   U.USER_DELETED, "
				   + "			   U.USER_DELETED_DATE, "
				   + "			   U.USER_UPDATED_DATE, "
				   + "			   U.USER_CREATED_DATE "
				   + "      FROM SEMI_USER U) "
				   + "WHERE RN >= ? AND RN <= ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			userList.add(rowToUser(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return userList;
	}
	
	private User rowToUser(ResultSet rs) throws SQLException {
		User user = new User();
		
		user.setNo(rs.getInt("USER_NO"));
		user.setGradeCode(rs.getString("GRADE_CODE"));
		user.setId(rs.getString("USER_ID"));
		user.setPassword(rs.getString("USER_PASSWORD"));
		user.setName(rs.getString("USER_NAME"));
		user.setTel(rs.getString("USER_TEL"));
		user.setEmail(rs.getString("USER_EMAIL"));
		user.setEmailSubscription(rs.getString("USER_EMAIL_SUBSCRIPTION"));
		user.setSmsSubscription(rs.getString("USER_SMS_SUBSCRIPTION"));
		user.setPoint(rs.getInt("USER_POINT"));
		user.setAdmin(rs.getString("USER_ADMIN"));
		user.setDeleted(rs.getString("USER_DELETED"));
		user.setDeletedDate(rs.getDate("USER_DELETED_DATE"));
		user.setUpdatedDate(rs.getDate("USER_UPDATED_DATE"));
		user.setCreatedDate(rs.getDate("USER_CREATED_DATE"));
		
		return user;
	}
}
