package daoImp;

import dao.OrderDao;
import models.Order;
import models.OrderItem;
import models.Product;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImp implements OrderDao {
    private Connection con = DBConnection.getConnection();

    @Override
    public int createOrder(int userId, String address, String paymentType, double totalAmount) {
        String sql = "INSERT INTO orders (user_id, address, payment_type, total_amount) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setString(2, address);
            ps.setString(3, paymentType);
            ps.setDouble(4, totalAmount);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public boolean addOrderItem(int orderId, int productId, int quantity, double price) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orderList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String orderSql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";

            PreparedStatement orderStmt = conn.prepareStatement(orderSql);
            orderStmt.setInt(1, userId);
            ResultSet orderRs = orderStmt.executeQuery();

            while (orderRs.next()) {
                Order order = new Order();
                int orderId = orderRs.getInt("id");
                order.setId(orderId);
                order.setUserId(userId);
                order.setOrderDate(orderRs.getDate("order_date"));
                order.setAddress(orderRs.getString("address"));
                order.setPaymentType(orderRs.getString("payment_type"));
                order.setTotalAmount(orderRs.getDouble("total_amount"));
                
                String statusSql = "SELECT status FROM order_tracking WHERE order_id = ? ORDER BY id DESC LIMIT 1";
                PreparedStatement statusStmt = conn.prepareStatement(statusSql);
                statusStmt.setInt(1, orderId);
                ResultSet statusRs = statusStmt.executeQuery();
                String status = "Order Placed"; // default if no tracking found
                if (statusRs.next()) {
                    status = statusRs.getString("status");
                }
                order.setTrackingStatus(status);

                List<OrderItem> items = new ArrayList<>();
                String itemSql = "SELECT oi.*, p.name, p.image, p.price FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
                PreparedStatement itemStmt = conn.prepareStatement(itemSql);
                itemStmt.setInt(1, orderId);
                ResultSet itemRs = itemStmt.executeQuery();

                while (itemRs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(itemRs.getInt("id"));
                    item.setOrderId(orderId);
                    item.setQuantity(itemRs.getInt("quantity"));
                    item.setPrice(itemRs.getDouble("price"));

                    Product p = new Product();
                    p.setId(itemRs.getInt("product_id"));
                    p.setName(itemRs.getString("name"));
                    p.setImage(itemRs.getString("image"));
                    p.setPrice(itemRs.getDouble("price"));

                    item.setProduct(p);
                    items.add(item);
                }

                order.setItems(items);
                orderList.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderList;
    }

    @Override
    public void trackOrder(int orderId, String status) {
    	String sql = "INSERT INTO order_tracking (order_id, status) VALUES (?, ?)";
    	try (PreparedStatement ps = con.prepareStatement(sql)) {
    		ps.setInt(1, orderId);
    		ps.setString(2, status);
    		ps.executeUpdate();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    }
    
    @Override
    public void trackOrder(int orderId, String status, int userId, String reason) {
        try {
            // check latest status first
            String checkSql = "SELECT status FROM order_tracking WHERE order_id = ? ORDER BY id DESC LIMIT 1";
            PreparedStatement checkStmt = con.prepareStatement(checkSql);
            checkStmt.setInt(1, orderId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                String latestStatus = rs.getString("status");
                if ("Cancelled".equalsIgnoreCase(latestStatus)) {
                    // already cancelled, don't insert again
                    System.out.println("Order " + orderId + " already cancelled. Skipping...");
                    return;
                }
            }

            // continue if not already cancelled
            String trackSql = "INSERT INTO order_tracking (order_id, status) VALUES (?, ?)";
            String logSql = "INSERT INTO order_logs (order_id, user_id, status, reason) VALUES (?, ?, ?, ?)";

            PreparedStatement ps1 = con.prepareStatement(trackSql);
            ps1.setInt(1, orderId);
            ps1.setString(2, status);
            ps1.executeUpdate();

            PreparedStatement ps2 = con.prepareStatement(logSql);
            ps2.setInt(1, orderId);
            ps2.setInt(2, userId);
            ps2.setString(3, status);
            ps2.setString(4, reason);
            ps2.executeUpdate();

            ps1.close();
            ps2.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public void autoUpdateDeliveredStatus() {
        String sql = "UPDATE order_tracking ot " +
                     "JOIN (SELECT o.id FROM orders o " +
                     "LEFT JOIN order_tracking ot2 ON o.id = ot2.order_id AND ot2.status = 'Delivered' " +
                     "WHERE o.order_date < NOW() - INTERVAL 3 DAY AND ot2.id IS NULL) AS eligible_orders " +
                     "ON ot.order_id = eligible_orders.id " +
                     "SET ot.status = 'Delivered'";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}

