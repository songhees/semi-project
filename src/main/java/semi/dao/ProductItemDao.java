package semi.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.criteria.ProductItemCriteria;
import semi.vo.Product;
import semi.vo.ProductItem;

public class ProductItemDao {
	
	private static ProductItemDao self = new ProductItemDao();
	private ProductItemDao() {}
	public static ProductItemDao getInstance() {
		return self;
	}
	
	public List<ProductItem> getProductItemListByProductNo(int productNo) throws SQLException {
		String sql = "SELECT I.PRODUCT_ITEM_NO, I.PRODUCT_NO, I.PRODUCT_SIZE, I.PRODUCT_COLOR, I.PRODUCT_STOCK, \r\n"
				+ "       I.PRODUCT_SALE_COUNT \r\n"
				+ "FROM SEMI_PRODUCT_ITEM I, SEMI_PRODUCT P \r\n"
				+ "WHERE I.PRODUCT_NO = P.PRODUCT_NO \r\n"
				+ "      AND P.PRODUCT_NO = ?;";
		
		List<ProductItem> productItems = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			ProductItem productItem = new ProductItem();
			Product product = new Product();
			
			productItem.setNo(rs.getInt("PRODUCT_ITEM_NO"));
			productItem.setSize(rs.getString("PRODUCT_SIZE"));
			productItem.setColor(rs.getString("PRODUCT_COLOR"));
			productItem.setStock(rs.getInt("PRODUCT_STOCK"));
			productItem.setSaleCount(rs.getInt("PRODUCT_SALE_COUNT"));
			
			product.setNo(rs.getInt("PRODUCT_NO"));
			productItem.setProduct(product);
			
			productItems.add(productItem);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return productItems;
	}
	
	public ProductItem getProductItemByProductItemNo(int productItemNO) throws SQLException {
		return null;
	}
	
	public ProductItem getProductItemByProductItemCriteria(ProductItemCriteria criteria) throws SQLException {
		return null;
	}
}
