package dao;

import models.User;

public interface UserDao {
    boolean registerUser(User user);
    User login(String email, String password);
}
