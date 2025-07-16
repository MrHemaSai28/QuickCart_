package dao;

import java.util.List;

import models.Address;

public interface AddressDao {
    boolean saveAddress(Address address);
    Address getAddressByUserId(int userId);
    boolean updateAddress(Address a); 
    List<Address> getAllAddressesByUserId(int userId);
    Address getAddressById(int id);
}
