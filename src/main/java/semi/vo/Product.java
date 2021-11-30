package semi.vo;

import java.util.Date;

public class Product {

	private int no;
	private ProductCategory productCategory;
	private String name;
	private long price;
	private long discountPrice;
	private Date discountFrom;
	private Date discountTo;
	private Date createdDate;
	private Date updatedDate;
	private String onSale;
	private String detail;
	private int totalSaleCount;
	private int totalStock;
	private double averageReviewRate;
	
	public Product() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public ProductCategory getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public long getPrice() {
		return price;
	}

	public void setPrice(long price) {
		this.price = price;
	}

	public long getDiscountPrice() {
		return discountPrice;
	}

	public void setDiscountPrice(long discountPrice) {
		this.discountPrice = discountPrice;
	}

	public Date getDiscountFrom() {
		return discountFrom;
	}

	public void setDiscountFrom(Date discountFrom) {
		this.discountFrom = discountFrom;
	}

	public Date getDiscountTo() {
		return discountTo;
	}

	public void setDiscountTo(Date discountTo) {
		this.discountTo = discountTo;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	public String getOnSale() {
		return onSale;
	}

	public void setOnSale(String onSale) {
		this.onSale = onSale;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public int getTotalSaleCount() {
		return totalSaleCount;
	}

	public void setTotalSaleCount(int totalSaleCount) {
		this.totalSaleCount = totalSaleCount;
	}

	public int getTotalStock() {
		return totalStock;
	}

	public void setTotalStock(int totalStock) {
		this.totalStock = totalStock;
	}

	public double getAverageReviewRate() {
		return averageReviewRate;
	}

	public void setAverageReviewRate(double averageReviewRate) {
		this.averageReviewRate = averageReviewRate;
	}

	@Override
	public String toString() {
		return "Product [no=" + no + ", productCategory=" + productCategory + ", name=" + name + ", price=" + price
				+ ", discountPrice=" + discountPrice + ", discountFrom=" + discountFrom + ", discountTo=" + discountTo
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", onSale=" + onSale + ", detail="
				+ detail + ", totalSaleCount=" + totalSaleCount + ", totalStock=" + totalStock + ", averageReviewRate="
				+ averageReviewRate + "]";
	}

	
}
