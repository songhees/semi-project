package semi.criteria;

public class ProductCriteria {

	private int begin;				// 현재 페이지번호에 해당하는 데이터 조회 시작 순번
	private int end;				// 현재 페이지번호에 해당하는 데이터 조회 끝 순번
	private String category;		// 카테고리 이름
	private String orderBy;			// 정렬기준
	private String nameKeyword;		// 검색할 상품 이름
	private long priceRangeFrom;	// 가격 범위의 시작
	private long priceRangeTo;		// 가격 범위의 끝
	
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

	public String getNameKeyword() {
		return nameKeyword;
	}

	public void setNameKeyword(String nameKeyword) {
		this.nameKeyword = nameKeyword;
	}

	public long getPriceRangeFrom() {
		return priceRangeFrom;
	}

	public void setPriceRangeFrom(long priceRangeFrom) {
		this.priceRangeFrom = priceRangeFrom;
	}

	public long getPriceRangeTo() {
		return priceRangeTo;
	}

	public void setPriceRangeTo(long priceRangeTo) {
		this.priceRangeTo = priceRangeTo;
	}

	@Override
	public String toString() {
		return "ProductCriteria [begin=" + begin + ", end=" + end + ", category=" + category + ", orderBy=" + orderBy
				+ ", nameKeyword=" + nameKeyword + ", priceRangeFrom=" + priceRangeFrom + ", priceRangeTo="
				+ priceRangeTo + "]";
	}
	
	
}
