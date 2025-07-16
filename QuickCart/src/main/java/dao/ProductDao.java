package dao;

import models.Product;
import java.util.List;

public interface ProductDao {
    boolean addProduct(Product p);
    boolean updateProduct(Product p);
    boolean deleteProduct(int id);
    List<Product> getAllProducts();
    Product getProductById(int id);
    List<Product> getRecommendedProducts(String category, int excludeProductId);

}
