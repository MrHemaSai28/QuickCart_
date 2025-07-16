package dao;

import java.util.List;
import models.Order;


public interface OrderDao {
    int createOrder(int userId, String address, String paymentType, double totalAmount);
    boolean addOrderItem(int orderId, int productId, int quantity, double price);
    void trackOrder(int orderId, String status);
    List<Order> getOrdersByUserId(int userId);
	void trackOrder(int orderId, String status, int userId, String reason);
	void autoUpdateDeliveredStatus();
}
