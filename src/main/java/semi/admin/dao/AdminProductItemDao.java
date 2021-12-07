package semi.admin.dao;

import static utils.ConnectionUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.Product;
import semi.vo.ProductItem;

public class AdminProductItemDao {
	
	AdminProductDao productDao = new AdminProductDao();
	
	public List<ProductItem> getItemsByProductNo(int productNo) throws SQLException {
		List<ProductItem> items = new ArrayList<>();
		
		String sql = "SELECT PRODUCT_NO, "
				   + "       PRODUCT_ITEM_NO, "
				   + "       PRODUCT_COLOR, "
				   + "       PRODUCT_SIZE, "
				   + "       PRODUCT_STOCK, "
				   + "       PRODUCT_SALE_COUNT "
				   + "FROM SEMI_PRODUCT_ITEM "
				   + "WHERE PRODUCT_NO = ? "
				   + "ORDER BY PRODUCT_ITEM_NO ASC";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productNo);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			items.add(rowToItem(rs));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return items;
	}
	
	public ProductItem getItemByItemNo(int itemNo) throws SQLException {
		ProductItem item = new ProductItem();
		
		String sql = "SELECT PRODUCT_ITEM_NO, "
				   + "       PRODUCT_NO, "
				   + "       PRODUCT_SIZE, "
				   + "       PRODUCT_COLOR, "
				   + "       PRODUCT_STOCK, "
				   + "       PRODUCT_SALE_COUNT "
				   + "FROM SEMI_PRODUCT_ITEM "
				   + "WHERE PRODUCT_ITEM_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, itemNo);
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			item = rowToItem(rs);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return item;
	}
	
	public void addItem(ProductItem item) throws SQLException {
		String sql = "INSERT INTO SEMI_PRODUCT_ITEM ( "
				   + "	PRODUCT_ITEM_NO, "
				   + "	PRODUCT_NO, "
				   + "	PRODUCT_SIZE, "
				   + "	PRODUCT_COLOR, "
				   + "	PRODUCT_STOCK) "
				   + "VALUES (PRODUCT_ITEM_SEQ.NEXTVAL, ?, ?, ?, ?)";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, item.getProduct().getNo());
		pstmt.setString(2, item.getSize());
		pstmt.setString(3, item.getColor());
		pstmt.setInt(4, item.getStock());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void removeItem(int productItemNo) throws SQLException {
		String sql = "DELETE FROM SEMI_PRODUCT_ITEM "
				   + "WHERE PRODUCT_ITEM_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, productItemNo);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	public void updateItem(ProductItem item) throws SQLException {
		String sql = "UPDATE SEMI_PRODUCT_ITEM "
				   + "SET "
				   + "	PRODUCT_NO = ?, "
				   + "	PRODUCT_COLOR = ?, "
				   + "	PRODUCT_SIZE = ?, "
				   + "	PRODUCT_STOCK = ?, "
				   + "	PRODUCT_SALE_COUNT = ? "
				   + "WHERE PRODUCT_ITEM_NO = ?";
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, item.getProduct().getNo());
		pstmt.setString(2, item.getColor());
		pstmt.setString(3, item.getSize());
		pstmt.setInt(4, item.getStock());
		pstmt.setInt(5, item.getSaleCount());
		pstmt.setInt(6, item.getNo());
		
		pstmt.executeUpdate();
		
		pstmt.close();
		connection.close();
	}
	
	private ProductItem rowToItem(ResultSet rs) throws SQLException {
		ProductItem item = new ProductItem();
		
		item.setNo(rs.getInt("PRODUCT_ITEM_NO"));
		item.setColor(rs.getString("PRODUCT_COLOR"));
		item.setSize(rs.getString("PRODUCT_SIZE"));
		item.setStock(rs.getInt("PRODUCT_STOCK"));
		item.setSaleCount(rs.getInt("PRODUCT_SALE_COUNT"));
		
		int productNo = rs.getInt("PRODUCT_NO");
		Product product = new Product();
		product = productDao.getProductByNo(productNo);
		item.setProduct(product);
		
		return item;
	}
}
