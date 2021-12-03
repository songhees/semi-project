package semi.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.dto.InquiryDto;
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
}
