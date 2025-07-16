package daoImp;

import dao.AddressDao;
import models.Address;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddressDaoImp implements AddressDao {

    @Override
    public boolean saveAddress(Address a) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO address(user_id, name, phone, city, state, street, pincode, landmark) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, a.getUserId());
            ps.setString(2, a.getName());
            ps.setString(3, a.getPhone());
            ps.setString(4, a.getCity());
            ps.setString(5, a.getState());
            ps.setString(6, a.getStreet());
            ps.setString(7, a.getPincode());
            ps.setString(8, a.getLandmark());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
    @Override
    public boolean updateAddress(Address a) {
        String sql =
            "UPDATE address SET name=?, phone=?, city=?, state=?, street=?, pincode=?, landmark=? " +
            "WHERE id=? AND user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getName());
            ps.setString(2, a.getPhone());
            ps.setString(3, a.getCity());
            ps.setString(4, a.getState());
            ps.setString(5, a.getStreet());
            ps.setString(6, a.getPincode());
            ps.setString(7, a.getLandmark());
            ps.setInt   (8, a.getId());
            ps.setInt   (9, a.getUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
    
    @Override
    public Address getAddressByUserId(int userId) {
        Address a = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM address WHERE user_id = ? ORDER BY id DESC LIMIT 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new Address();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("user_id"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setCity(rs.getString("city"));
                a.setState(rs.getString("state"));
                a.setStreet(rs.getString("street"));
                a.setPincode(rs.getString("pincode"));
                a.setLandmark(rs.getString("landmark"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }
    
    
    @Override
    public List<Address> getAllAddressesByUserId(int userId) {
        List<Address> addresses = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM address WHERE user_id = ? ORDER BY id DESC LIMIT 5";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Address a = new Address();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("user_id"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setCity(rs.getString("city"));
                a.setState(rs.getString("state"));
                a.setStreet(rs.getString("street"));
                a.setPincode(rs.getString("pincode"));
                a.setLandmark(rs.getString("landmark"));
                addresses.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return addresses;
    }
    
    public Address getAddressById(int id) {
        Address a = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM address WHERE id = ?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                a = new Address();
                a.setId(rs.getInt("id"));
                a.setUserId(rs.getInt("user_id"));
                a.setName(rs.getString("name"));
                a.setPhone(rs.getString("phone"));
                a.setStreet(rs.getString("street"));
                a.setLandmark(rs.getString("landmark"));
                a.setCity(rs.getString("city"));
                a.setState(rs.getString("state"));
                a.setPincode(rs.getString("pincode"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }


}
