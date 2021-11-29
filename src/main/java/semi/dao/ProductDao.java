package semi.dao;

import static utils.ConnectionUtil.getConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import semi.vo.Product;
import semi.vo.ProductCategory;
import semi.vo.ProductItem;

public class ProductDao {
	
	private static ProductDao self = new ProductDao();
	private ProductDao() {}
	public static ProductDao getInstance() {
		return self;
	}
	
	public List<String> getProductThumbnailImage(int no) throws SQLException {
		String sql = "select thumbnail_image_url "
				   + "from semi_product_thumbnail_image "
				   + "where product_no = ? ";
		
		List<String> urlList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			urlList.add(rs.getString("thumbnail_image_url"));
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return urlList;
	}
	
	public Product getProductDetail(int no) throws SQLException {
		String sql = "select p.product_no, p.product_name, p.product_price, p.product_discount_price, "
				   + "       p.product_discount_from, p.product_discount_to, p.product_created_date, "
				   + "		 p.product_updated_date, p.product_on_sale, p.product_detail, c.category_no, "
				   + "		 c.category_name "
				   + "from semi_product p, semi_product_category c "
				   + "where p.category_no = c.category_no "
				   + "		and p.product_no = ? ";
				
		Product product = null;		
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
			
		if (rs.next()) {
			product = new Product();
			ProductCategory category = new ProductCategory();
			
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDiscountPrice(rs.getInt("product_discount_price"));
			product.setDiscountFrom(rs.getDate("product_discount_from"));
			product.setDiscountTo(rs.getDate("product_discount_to"));
			product.setCreatedDate(rs.getDate("product_created_date"));
			product.setUpdatedDate(rs.getDate("product_updated_date"));
			product.setOnSale(rs.getString("product_on_sale"));
			product.setDetail(rs.getString("product_detail"));
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			product.setProductCategory(category);
		}
		
		rs.close();
		pstmt.close();
		connection.close();
		
		return product;
	}
	
	public List<ProductItem> getProductItemList(int no) throws SQLException {
		String sql = "select p.product_no, p.product_name, p.product_price, p.product_discount_price, "
				   + "       p.product_discount_from, p.product_discount_to, p.product_created_date, "
				   + "		 p.product_updated_date, p.product_on_sale, p.product_detail, c.category_no, "
				   + "		 c.category_name, i.product_item_no, i.product_size, i.product_color, "
				   + "		 i.product_stock, i.product_sale_count "
				   + "from semi_product p, semi_product_category c, semi_product_item i "
				   + "where p.category_no = c.category_no"
				   + "		and p.product_no = i.product_no "
				   + "		and p.product_no = ? ";
				
		List<ProductItem> productItemList = new ArrayList<>();
		
		Connection connection = getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		pstmt.setInt(1, no);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			ProductItem productItem = new ProductItem();
			productItem.setNo(rs.getInt("product_item_no"));
			productItem.setSize(rs.getString("product_size"));
			productItem.setColor(rs.getString("product_color"));
			productItem.setStock(rs.getInt("product_stock"));
			productItem.setSaleCount(rs.getInt("product_sale_count"));
			
			Product product = new Product();
			ProductCategory category = new ProductCategory();
			product.setNo(rs.getInt("product_no"));
			product.setName(rs.getString("product_name"));
			product.setPrice(rs.getInt("product_price"));
			product.setDiscountPrice(rs.getInt("product_discount_price"));
			product.setDiscountFrom(rs.getDate("product_discount_from"));
			product.setDiscountTo(rs.getDate("product_discount_to"));
			product.setCreatedDate(rs.getDate("product_created_date"));
			product.setUpdatedDate(rs.getDate("product_updated_date"));
			product.setOnSale(rs.getString("product_on_sale"));
			product.setDetail(rs.getString("product_detail"));
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			product.setProductCategory(category);
			productItem.setProduct(product);
			
			productItemList.add(productItem);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return productItemList;
	}

}
