package semi.service;

// temp
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// temp
import utils.ConnectionUtil;

public class AdminService {

	private final CategoryDao categoryDao = new CategoryDao();
	private final UserDao userDao = new UserDao();
	private final ProductDao productDao = new ProductDao();
	private final OrderDao orderDao = new OrderDao();
	
	private static AdminService service = new AdminService();
	private AdminService() {}
	private static AdminService getInstance() {
		return service;
	}
	
	public List<Category> getAllCategories() throws SQLException {
		return categoryDao.selectAllCategories();
	}
}



// temp
class CategoryDao {
	
	public List<Category> selectAllCategories() throws SQLException {
		List<Category> categories = new ArrayList<>();
		
		String sql = "SELECT CATEGORY_NO, CATEGORY_NAME "
				   + "FROM SEMI_PRODUCT_CATEGORY "
				   + "ORDER BY CATEGORY_NO ASC";
		
		Connection connection = ConnectionUtil.getConnection();
		PreparedStatement pstmt = connection.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Category category = new Category();
			category.setNo(rs.getInt("category_no"));
			category.setName(rs.getString("category_name"));
			
			categories.add(category);
		}
		rs.close();
		pstmt.close();
		connection.close();
		
		return categories;
	}
}

class Category {
	private int no;
	private String name;
	
	public Category() {}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

class UserDao {
	
}

class ProductDao {
	
}

class OrderDao {
	
}