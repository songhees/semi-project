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
	
	public List<InquiryDto> getInquiryDtoByProductNo(int no, int begin, int end) throws SQLException {
		String sql = "select i.rn, i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, "
				   + "       i.inquiry_password, i.content, i.reply_no, i.user_no, u.user_name, "
				   + "       i.created_date, i.product_no "
				   + "from ( "
				   + "		select row_number() over (order by inquiry_no desc, type asc) rn, inquiry_no, "
				   + "			   inquiry_title, content, created_date, product_no, user_no, reply_no, "
				   + "			   inquiry_password, category_no "
				   + "		from ( "
				   + "			  select inquiry_no, inquiry_title, inquiry_content content, inquiry_created_date created_date, "
				   + "			  		 product_no, user_no, null reply_no, inquiry_password, category_no, 0 type "
				   + "			  from semi_product_inquiry "
				   + "			  where product_no = ? "
				   + "			  and inquiry_deleted = 'N' "
				   + "			  union all "
				   + "			  select inquiry_no, null, reply_content, reply_created_date, null, null, reply_no, null, null, 1 "
				   + "			  from semi_product_inquiry_reply "
				   + "			  where reply_content is not null "
				   + " 			  and inquiry_no in (select inquiry_no from semi_product_inquiry where product_no = ?) "
				   + "			  and reply_deleted = 'N' "
				   + "			  ) "
				   + "		) i, semi_inquiry_category c, semi_user u "
				   + "where i.category_no = c.category_no(+) "
				   + "      and i.user_no = u.user_no(+) "
				   + "		and rn >= ? and rn <= ? ";
		
		List<InquiryDto> inquiryDtoList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		pstmt.setInt(2, no);
		pstmt.setInt(3, begin);
		pstmt.setInt(4, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryDto inquiryDto = new InquiryDto();
			inquiryDto.setRn(rs.getInt("rn"));
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setContent(rs.getString("content"));
			inquiryDto.setCreatedDate(rs.getDate("created_date"));
			inquiryDto.setProductNo(rs.getInt("product_no"));
			inquiryDto.setReplyNo(rs.getInt("reply_no"));
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
	

	public List<InquiryDto> getInquiryDtoListByCategoryNo(int categoryNo, int begin, int end) throws SQLException {
		String sql = "select i.rn, i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, "
				   + "       i.inquiry_password, i.content, i.reply_no, "
				   + "       i.user_no, u.user_name, i.created_date, i.product_no "
				   + "from ( "
				   + "      select row_number() over (order by inquiry_no desc, type asc) rn, inquiry_no, inquiry_title, content, created_date, "
				   + "             product_no, user_no, reply_no, inquiry_password, category_no "
				   + "		from ( "
				   + "			  select inquiry_no, inquiry_title, inquiry_content content, inquiry_created_date created_date, inquiry_deleted deleted, "
				   + "			  		 product_no, user_no, null reply_no, inquiry_password, category_no, 0 type "
				   + "			  from semi_product_inquiry "
				   + "			  where category_no = ? "
				   + "			  		and inquiry_deleted = 'N' "
				   + "			  union all "
				   + "			  select inquiry_no, null, reply_content, reply_created_date, reply_deleted, null, null, reply_no, null, null, 1 "
				   + "			  from semi_product_inquiry_reply "
				   + "			  where reply_content is not null "
				   + "					and inquiry_no in (select inquiry_no from semi_product_inquiry where category_no = ? ) "
				   + "					and reply_deleted = 'N' "
				   + "			  ) "
				   + "		) i, semi_inquiry_category c, semi_user u "
				   + "where i.category_no = c.category_no(+) "
				   + "and i.user_no = u.user_no(+) "
				   + "and rn >= ? and rn <= ? ";
		
		List<InquiryDto> inquiryDtoList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, categoryNo);
		pstmt.setInt(2, categoryNo);
		pstmt.setInt(3, begin);
		pstmt.setInt(4, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryDto inquiryDto = new InquiryDto();
			inquiryDto.setRn(rs.getInt("rn"));
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setContent(rs.getString("content"));
			inquiryDto.setCreatedDate(rs.getDate("created_date"));
			inquiryDto.setProductNo(rs.getInt("product_no"));
			inquiryDto.setReplyNo(rs.getInt("reply_no"));
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
		String sql = "select i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, i.product_no, "
				   + "i.inquiry_password, i.inquiry_content, i.user_no, u.user_name, i.inquiry_created_date "
				   + "from semi_product_inquiry i, semi_inquiry_category c, semi_user u "
				   + "where i.category_no = c.category_no "
				   + "and i.user_no = u.user_no "
				   + "and i.inquiry_no = ? "
				   + "and i.inquiry_deleted = 'N' "
				   + "order by i.inquiry_no desc ";
		
		InquiryDto inquiryDto = null;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, inquiryNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			inquiryDto = new InquiryDto();
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setContent(rs.getString("inquiry_content"));
			inquiryDto.setCreatedDate(rs.getDate("inquiry_created_date"));
			inquiryDto.setUserNo(rs.getInt("user_no"));
			inquiryDto.setUserName(rs.getString("user_name"));
			inquiryDto.setCategoryNo(rs.getInt("category_no"));
			inquiryDto.setCategoryName(rs.getString("category_name"));
			inquiryDto.setProductNo(rs.getInt("product_no"));
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
		pstmt.setString(6, inquiryDto.getContent());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	// 수정 필요
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
		pstmt.setString(3, inquiryDto.getContent());
		pstmt.setInt(4, inquiryDto.getInquiryNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	// 수정 필요
	public void deleteInquiry(InquiryDto inquiryDto) throws SQLException {
		String sql = "update semi_product_inquiry "
				   + "set "
				   + "	inquiry_deleted = ?,"
				   + "	inquiry_deleted_date = sysdate "
				   + "where inquiry_no = ? ";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setString(1, inquiryDto.getDeleted());
		pstmt.setInt(2, inquiryDto.getInquiryNo());
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public int getTotalRecords() throws SQLException {
		String sql = "select count(*) cnt "
				   + "from (select * "
				   + "      from (select inquiry_no "
				   + "            from semi_product_inquiry "
				   + "            union all "
				   + "            select inquiry_no "
				   + "            from semi_product_inquiry_reply "
				   + "            where reply_content is not null)) ";
				
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
	
	public int getTotalRecordsByProductNo(int productNo) throws SQLException {
		String sql = "select count(*) cnt "
				   + "from (select * "
				   + "      from (select inquiry_no "
				   + "            from semi_product_inquiry "
				   + "			  where product_no = ? "
				   + "			  and inquiry_deleted = 'N' "
				   + "            union all "
				   + "            select inquiry_no "
				   + "            from semi_product_inquiry_reply "
				   + "            where reply_deleted = 'N' "
				   + "			  and reply_content is not null"
				   + "			  and inquiry_no in (select inquiry_no from semi_product_inquiry where product_no = ? ))) ";
				
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		pstmt.setInt(2, productNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
	}
	
	public List<InquiryDto> getAllInquiryDtoList(int begin, int end) throws SQLException {
		String sql = "select i.rn, i.inquiry_no, i.category_no, c.category_name, i.inquiry_title, "
				   + "       i.inquiry_password, i.content, i.reply_no, i.user_no, u.user_name, "
				   + "       i.created_date, i.product_no "
				   + "from ( "
				   + "		select row_number() over (order by inquiry_no desc, type asc) rn, inquiry_no, "
				   + "			   inquiry_title, content, created_date, product_no, user_no, reply_no, "
				   + "			   inquiry_password, category_no "
				   + "		from ( "
				   + "			  select inquiry_no, inquiry_title, inquiry_content content, inquiry_created_date created_date, "
				   + "			  		 product_no, user_no, null reply_no, inquiry_password, category_no, 0 type "
				   + "			  from semi_product_inquiry "
				   + "			  where inquiry_deleted = 'N' "
				   + "			  union all "
				   + "			  select inquiry_no, null, reply_content, reply_created_date, null, null, reply_no, null, null, 1 "
				   + "			  from semi_product_inquiry_reply "
				   + "			  where reply_content is not null "
				   + "			  and reply_deleted = 'N' "
				   + "			  ) "
				   + "		) i, semi_inquiry_category c, semi_user u "
				   + "where i.category_no = c.category_no(+) "
				   + "      and i.user_no = u.user_no(+) "
				   + "		and rn >= ? and rn <= ? ";
		
		List<InquiryDto> inquiryDtoList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, begin);
		pstmt.setInt(2, end);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryDto inquiryDto = new InquiryDto();
			inquiryDto.setRn(rs.getInt("rn"));
			inquiryDto.setInquiryNo(rs.getInt("inquiry_no"));
			inquiryDto.setTitle(rs.getString("inquiry_title"));
			inquiryDto.setPassword(rs.getString("inquiry_password"));
			inquiryDto.setContent(rs.getString("content"));
			inquiryDto.setCreatedDate(rs.getDate("created_date"));
			inquiryDto.setProductNo(rs.getInt("product_no"));
			inquiryDto.setReplyNo(rs.getInt("reply_no"));
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
	
	public int getTotalRecordsByCategoryNo(int categoryNo) throws SQLException {
		String sql = "select count(*) cnt "
				   + "from (select * "
				   + "      from (select inquiry_no "
				   + "            from semi_product_inquiry "
				   + "			  where category_no = ? "
				   + "			  and inquiry_deleted = 'N' "
				   + "            union all "
				   + "            select inquiry_no "
				   + "            from semi_product_inquiry_reply "
				   + "            where reply_deleted = 'N' "
				   + "			  and reply_content is not null"
				   + "			  and inquiry_no in (select inquiry_no from semi_product_inquiry where category_no = ? ))) ";
				
		int totalRecords = 0;
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, categoryNo);
		pstmt.setInt(2, categoryNo);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		totalRecords = rs.getInt("cnt");
		rs.close();
		pstmt.close();
		connection.close();
		
		return totalRecords;
		
	}
	
	public List<InquiryDto> getReplyByInquiryNo(int inquiryNo) throws SQLException {
		String sql = "select reply_content, reply_created_date "
				   + "from semi_product_inquiry_reply "
				   + "where inquiry_no = ? "
				   + "and reply_deleted = 'N' ";
		
		List<InquiryDto> inquiryDtoList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, inquiryNo);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			InquiryDto inquiryDto = new InquiryDto();
			inquiryDto.setContent(rs.getString("reply_content"));
			inquiryDto.setCreatedDate(rs.getDate("reply_created_date"));
			
			inquiryDtoList.add(inquiryDto);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return inquiryDtoList;
	}
}
