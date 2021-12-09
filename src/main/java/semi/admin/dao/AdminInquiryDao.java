package semi.admin.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.Inquiry;
import semi.vo.InquiryCategory;
import semi.vo.Product;
import semi.vo.User;

public class AdminInquiryDao {
	
	AdminUserDao userDao = new AdminUserDao();
	AdminProductDao productDao = new AdminProductDao();

	public Inquiry getInquiryByNo(int no) throws SQLException {
		Inquiry inquiry = new Inquiry();
		
		String sql = "SELECT I.INQUIRY_NO, "
				   + "       I.USER_NO, "
				   + "       I.PRODUCT_NO, "
				   + "       I.INQUIRY_TITLE, "
				   + "       I.INQUIRY_PASSWORD, "
				   + "       I.INQUIRY_CONTENT, "
				   + "       I.INQUIRY_CREATED_DATE, "
				   + "       I.INQUIRY_DELETED_DATE, "
				   + "       I.INQUIRY_DELETED, "
				   + "       C.CATEGORY_NO, "
				   + "       C.CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT_INQUIRY I, SEMI_INQUIRY_CATEGORY C "
				   + "WHERE I.CATEGORY_NO = C.CATEGORY_NO "
				   + "AND I.INQUIRY_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			inquiry = rowToInquiry(rs);
			inquiry.setDeletedDate(rs.getDate("INQUIRY_DELETED_DATE"));
			inquiry.setDeleted(rs.getString("INQUIRY_DELETED"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiry;
	}
	
	public List<Inquiry> getInquiryList(int begin, int end) throws SQLException {
		List<Inquiry> inquiryList = new ArrayList<>();
		
		String sql = "SELECT RN,"
				   + "       INQUIRY_NO, "
				   + "       USER_NO, "
				   + "       PRODUCT_NO, "
				   + "       INQUIRY_TITLE, "
				   + "       INQUIRY_PASSWORD, "
				   + "       INQUIRY_CONTENT, "
				   + "       INQUIRY_CREATED_DATE, "
				   + "       CATEGORY_NO, "
				   + "       CATEGORY_NAME "
				   + "FROM (SELECT ROW_NUMBER() OVER (ORDER BY I.INQUIRY_CREATED_DATE DESC) RN, "
				   + "             I.INQUIRY_NO, "
				   + "             I.USER_NO, "
				   + "             I.PRODUCT_NO, "
				   + "		       I.INQUIRY_TITLE, "
				   + "             I.INQUIRY_PASSWORD, "
				   + "             I.INQUIRY_CONTENT, "
				   + "             I.INQUIRY_CREATED_DATE, "
				   + "             C.CATEGORY_NO, "
				   + "             C.CATEGORY_NAME "
				   + "      FROM SEMI_PRODUCT_INQUIRY I, SEMI_INQUIRY_CATEGORY C "
				   + "      WHERE I.CATEGORY_NO = C.CATEGORY_NO "
				   + "      AND I.INQUIRY_DELETED = 'N') "
				   + "WHERE RN >= ? AND RN <= ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			inquiryList.add(rowToInquiry(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiryList;
	}
	
	public int getTotalRecords() throws SQLException {
		int totalRecords = 0;
		
		String sql = "SELECT COUNT(*) CNT "
				   + "FROM SEMI_PRODUCT_INQUIRY "
				   + "WHERE INQUIRY_DELETED = 'N'";
		
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
	
	private Inquiry rowToInquiry(ResultSet rs) throws SQLException {
		Inquiry inquiry = new Inquiry();
		
		inquiry.setNo(rs.getInt("INQUIRY_NO"));
		inquiry.setTitle(rs.getString("INQUIRY_TITLE"));
		inquiry.setPassword(rs.getString("INQUIRY_PASSWORD"));
		inquiry.setContent(rs.getString("INQUIRY_CONTENT"));
		inquiry.setCreatedDate(rs.getDate("INQUIRY_CREATED_DATE"));
		
		int userNo = rs.getInt("USER_NO");
		User user = new User();
		user = userDao.getUserByNo(userNo);
		inquiry.setUser(user);
		
		int productNo = rs.getInt("PRODUCT_NO");
		Product product = new Product();
		product = productDao.getProductByNo(productNo);
		inquiry.setProduct(product);
		
		int categoryNo = rs.getInt("CATEGORY_NO");
		String categoryName = rs.getString("CATEGORY_NAME");
		InquiryCategory category = new InquiryCategory();
		category.setNo(categoryNo);
		category.setName(categoryName);
		inquiry.setCategory(category);
		
		return inquiry;
	}
}
