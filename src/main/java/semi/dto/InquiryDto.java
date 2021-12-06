package semi.dto;

import java.util.Date;

public class InquiryDto {
	// semi_product_inquiry
	private int inquiryNo;
	private String title;
	private String password;
	private int productNo;
	private String inquiryContent;
	private Date inquiryCreatedDate;
	private String inquiryDeleted;
	// semi_product_inquiry_reply
	private int replyNo;
	private String replyContent;
	private Date replyCreatedDate;
	private String replyDeleted;
	// semi_user
	private int userNo;
	private String userName;
	// semi_inquiry_category
	private int categoryNo;
	private String categoryName;
	
	public InquiryDto() {
	}

	public int getInquiryNo() {
		return inquiryNo;
	}

	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getInquiryContent() {
		return inquiryContent;
	}

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}

	public Date getInquiryCreatedDate() {
		return inquiryCreatedDate;
	}

	public void setInquiryCreatedDate(Date inquiryCreatedDate) {
		this.inquiryCreatedDate = inquiryCreatedDate;
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Date getReplyCreatedDate() {
		return replyCreatedDate;
	}

	public void setReplyCreatedDate(Date replyCreatedDate) {
		this.replyCreatedDate = replyCreatedDate;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getInquiryDeleted() {
		return inquiryDeleted;
	}

	public void setInquiryDeleted(String inquiryDeleted) {
		this.inquiryDeleted = inquiryDeleted;
	}

	public String getReplyDeleted() {
		return replyDeleted;
	}

	public void setReplyDeleted(String replyDeleted) {
		this.replyDeleted = replyDeleted;
	}
	
	
	
}
