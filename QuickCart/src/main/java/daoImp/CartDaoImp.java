package daoImp;

import dao.CartDao;
import dao.ProductDao;
import models.CartItem;
import models.Product;
import util.DBConnection;

import java.sql.*;
import java.util.*;

public class CartDaoImp implements CartDao {
    private Connection con = DBConnection.getConnection();
    private ProductDao productDao = new ProductDaoImp();

    @Override
    public boolean addToCart(int userId, int productId) {
        String checkSql = "SELECT id, quantity FROM cart WHERE user_id = ? AND product_id = ?";
        String updateSql = "UPDATE cart SET quantity = ? WHERE id = ?";
        String insertSql = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";

        try (
            PreparedStatement checkStmt = con.prepareStatement(checkSql)
        ) {
            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, productId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int cartId = rs.getInt("id");
                int currentQty = rs.getInt("quantity");

                try (PreparedStatement updateStmt = con.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, currentQty + 1);
                    updateStmt.setInt(2, cartId);
                    return updateStmt.executeUpdate() > 0;
                }

            } else {
                try (PreparedStatement insertStmt = con.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, productId);
                    insertStmt.setInt(3, 1);
                    return insertStmt.executeUpdate() > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }



    @Override
    public List<CartItem> getUserCart(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE user_id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CartItem c = new CartItem();
                c.setId(rs.getInt("id"));
                c.setUserId(userId);
                Product p = productDao.getProductById(rs.getInt("product_id"));
                c.setProduct(p);
                c.setQuantity(rs.getInt("quantity"));
                list.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public boolean removeCartItem(int cartId) {
        String sql = "DELETE FROM cart WHERE id=?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    
    @Override
    public boolean updateCartQuantity(int cartId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean clearUserCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


}
