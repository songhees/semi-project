package semi.criteria;

public class ProductCriteria {

	private int begin;
	private int end;
	private String category;
	private String orderBy;
	
	public ProductCriteria() {}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	@Override
	public String toString() {
		return "GetProductListBycategoryCritetia [begin=" + begin + ", end=" + end + ", category=" + category
				+ ", orderBy=" + orderBy + "]";
	}
	
	
}
