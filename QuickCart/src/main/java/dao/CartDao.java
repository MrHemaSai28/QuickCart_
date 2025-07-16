package dao;

import models.CartItem;
import java.util.List;

public interface CartDao {
    boolean addToCart(int userId, int productId);
    List<CartItem> getUserCart(int userId);
    boolean removeCartItem(int cartId);
    boolean updateCartQuantity(int cartId, int quantity);
    boolean  clearUserCart(int userId);
}
