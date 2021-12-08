package semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.dto.InquiryDto;
import semi.vo.InquiryCategory;

import static utils.ConnectionUtil.getConnection;

public class InquiryDao {
	
	private static InquiryDao self = new InquiryDao();
	private InquiryDao() {}
	public static InquiryDao getInstance() {
		return self;
	}
	
	public List<InquiryDto> getInquiryDtoByProductNo(int no) throws SQLException {
		String sql = "select i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, "
				   + "       i.inquiry_password, i.inquiry_content, r.reply_no, r.reply_content, "
				   + "       i.user_no, u.user_name, i.inquiry_created_date, r.reply_created_date, "
				   + "		 i.inquiry_deleted, r.reply_deleted "
				   + "from semi_product_inquiry i, semi_product_inquiry_reply r, "
				   + "     semi_inquiry_category c, semi_user u "
				   + "where i.inquiry_no = r.inquiry_no(+) "
				   + "      and i.category_no = c.category_no "
				   + "      and i.user_no = u.user_no "
				   + "      and i.product_no = ? "
				   + "order by i.inquiry_no desc ";
		
		List<InquiryDto> inquiryDtoList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryDto inquiryDto = new InquiryDto();
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setInquiryContent(rs.getString("inquiry_content"));
			inquiryDto.setInquiryCreatedDate(rs.getDate("inquiry_created_date"));
			inquiryDto.setInquiryDeleted(rs.getString("inquiry_deleted"));
			inquiryDto.setReplyNo(rs.getInt("reply_no"));
			inquiryDto.setReplyContent(rs.getString("reply_content"));
			inquiryDto.setReplyCreatedDate(rs.getDate("reply_created_date"));
			inquiryDto.setReplyDeleted(rs.getString("reply_deleted"));
			inquiryDto.setUserNo(rs.getInt("user_no"));
			inquiryDto.setUserName(rs.getString("user_name"));
			inquiryDto.setCategoryNo(rs.getInt("category_no"));
			inquiryDto.setCategoryName(rs.getString("category_name"));
			
			inquiryDtoList.add(inquiryDto);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiryDtoList;
	}
	

	public List<InquiryDto> getAllInquiryDtoList() throws SQLException {
		String sql = "select i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, "
				   + "       i.inquiry_password, i.inquiry_content, r.reply_no, r.reply_content, "
				   + "       i.user_no, u.user_name, i.inquiry_created_date, r.reply_created_date, "
				   + "		 i.inquiry_deleted, r.reply_deleted, i.product_no "
				   + "from semi_product_inquiry i, semi_product_inquiry_reply r, "
				   + "     semi_inquiry_category c, semi_user u "
				   + "where i.inquiry_no = r.inquiry_no(+) "
				   + "      and i.category_no = c.category_no "
				   + "      and i.user_no = u.user_no "
				   + "order by i.inquiry_no desc ";
		
		List<InquiryDto> inquiryDtoList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryDto inquiryDto = new InquiryDto();
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setProductNo(rs.getInt("product_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setInquiryContent(rs.getString("inquiry_content"));
			inquiryDto.setInquiryCreatedDate(rs.getDate("inquiry_created_date"));
			inquiryDto.setInquiryDeleted(rs.getString("inquiry_deleted"));
			inquiryDto.setReplyNo(rs.getInt("reply_no"));
			inquiryDto.setReplyContent(rs.getString("reply_content"));
			inquiryDto.setReplyCreatedDate(rs.getDate("reply_created_date"));
			inquiryDto.setReplyDeleted(rs.getString("reply_deleted"));
			inquiryDto.setUserNo(rs.getInt("user_no"));
			inquiryDto.setUserName(rs.getString("user_name"));
			inquiryDto.setCategoryNo(rs.getInt("category_no"));
			inquiryDto.setCategoryName(rs.getString("category_name"));
			
			inquiryDtoList.add(inquiryDto);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiryDtoList;
	}
	
	public List<InquiryDto> getInquiryDtoListByCategory(String inquiryCategory) throws SQLException {
		String sql = "select i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, "
				   + "       i.inquiry_password, i.inquiry_content, r.reply_no, r.reply_content, "
				   + "       i.user_no, u.user_name, i.inquiry_created_date, r.reply_created_date, "
				   + "		 i.inquiry_deleted, r.reply_deleted, i.product_no "
				   + "from semi_product_inquiry i, semi_product_inquiry_reply r, "
				   + "     semi_inquiry_category c, semi_user u "
				   + "where i.inquiry_no = r.inquiry_no(+) "
				   + "      and i.category_no = c.category_no "
				   + "      and i.user_no = u.user_no "
				   + "		and c.category_name = ? "
				   + "order by i.inquiry_no desc ";
		
		List<InquiryDto> inquiryDtoList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, inquiryCategory);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryDto inquiryDto = new InquiryDto();
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setProductNo(rs.getInt("product_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setInquiryContent(rs.getString("inquiry_content"));
			inquiryDto.setInquiryCreatedDate(rs.getDate("inquiry_created_date"));
			inquiryDto.setInquiryDeleted(rs.getString("inquiry_deleted"));
			inquiryDto.setReplyNo(rs.getInt("reply_no"));
			inquiryDto.setReplyContent(rs.getString("reply_content"));
			inquiryDto.setReplyCreatedDate(rs.getDate("reply_created_date"));
			inquiryDto.setReplyDeleted(rs.getString("reply_deleted"));
			inquiryDto.setUserNo(rs.getInt("user_no"));
			inquiryDto.setUserName(rs.getString("user_name"));
			inquiryDto.setCategoryNo(rs.getInt("category_no"));
			inquiryDto.setCategoryName(rs.getString("category_name"));
			
			inquiryDtoList.add(inquiryDto);
		}

		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiryDtoList;	
	}
	
	public InquiryDto getInquiryDtoByInquiryNo(int inquiryNo) throws SQLException {
		String sql = "select i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, "
				   + "i.inquiry_password, i.inquiry_content, r.reply_no, r.reply_content, "
				   + "i.user_no, u.user_name, i.inquiry_created_date, r.reply_created_date, "
				   + "i.inquiry_deleted, r.reply_deleted, i.product_no "
				   + "from semi_product_inquiry i, semi_product_inquiry_reply r, "
				   + "semi_inquiry_category c, semi_user u "
				   + "where i.inquiry_no = r.inquiry_no(+) "
				   + "and i.category_no = c.category_no "
				   + "and i.user_no = u.user_no "
				   + "and i.inquiry_no = ? "
				   + "order by i.inquiry_no desc ";
		
		InquiryDto inquiryDto = new InquiryDto();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, inquiryNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setProductNo(rs.getInt("product_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setInquiryContent(rs.getString("inquiry_content"));
			inquiryDto.setInquiryCreatedDate(rs.getDate("inquiry_created_date"));
			inquiryDto.setInquiryDeleted(rs.getString("inquiry_deleted"));
			inquiryDto.setReplyNo(rs.getInt("reply_no"));
			inquiryDto.setReplyContent(rs.getString("reply_content"));
			inquiryDto.setReplyCreatedDate(rs.getDate("reply_created_date"));
			inquiryDto.setReplyDeleted(rs.getString("reply_deleted"));
			inquiryDto.setUserNo(rs.getInt("user_no"));
			inquiryDto.setUserName(rs.getString("user_name"));
			inquiryDto.setCategoryNo(rs.getInt("category_no"));
			inquiryDto.setCategoryName(rs.getString("category_name"));
		}
				
		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiryDto;
	}
	
	public List<InquiryCategory> getInquiryCategoryList() throws SQLException {
		String sql = "select category_no, category_name "
				   + "from semi_inquiry_category ";
		
		List<InquiryCategory> inquiryCategoryList = new ArrayList<>();
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryCategory inquiryCategory = new InquiryCategory();
			inquiryCategory.setNo(rs.getInt("category_no"));
			inquiryCategory.setName(rs.getString("category_name"));
			
			inquiryCategoryList.add(inquiryCategory);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiryCategoryList;
	}
	
	public void insertInquiry(InquiryDto inquiryDto) throws SQLException {
		String sql = "insert into semi_product_inquiry(user_no, product_no, category_no, inquiry_title, "
				   + "inquiry_password, inquiry_content) "
				   + "values(?,?,?,?,?,?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, inquiryDto.getUserNo());
		pstmt.setInt(2, inquiryDto.getProductNo());
		pstmt.setInt(3, inquiryDto.getCategoryNo());
		pstmt.setString(4, inquiryDto.getTitle());
		pstmt.setString(5, inquiryDto.getPassword());
		pstmt.setString(6, inquiryDto.getInquiryContent());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void updateInquiry(InquiryDto inquiryDto) throws SQLException {
		String sql = "update semi_product_inquiry "
				   + "set "
				   + "	category_no = ?, "
				   + "	inquiry_title = ?, "
				   + "	inquiry_content = ? "
				   + "where inquiry_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, inquiryDto.getCategoryNo());
		pstmt.setString(2, inquiryDto.getTitle());
		pstmt.setString(3, inquiryDto.getInquiryContent());
		pstmt.setInt(4, inquiryDto.getInquiryNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void deleteInquiry(InquiryDto inquiryDto) throws SQLException {
		String sql = "update semi_product_inquiry "
				   + "set "
				   + "	inquiry_deleted = ?,"
				   + "	inquiry_deleted_date = sysdate "
				   + "where inquiry_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, inquiryDto.getInquiryDeleted());
		pstmt.setInt(2, inquiryDto.getInquiryNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
}
