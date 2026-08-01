package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.User;
import util.PasswordUtil;

public class UserDAO {

    public boolean registerUser(User user) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("Connection is NULL");
                return false;
            }

            String query = "INSERT INTO users(full_name, email, password, phone, role) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
                System.out.println("User Registered Successfully");
            }

        } catch (Exception e) {
            System.out.println("Registration Error:");
            e.printStackTrace();
        }

        return status;
    }

    public User loginUser(String email, String password) {

        User user = null;

        try {
            Connection con = DBConnection.getConnection();

            if (con == null) {
                System.out.println("Connection is NULL");
                return null;
            }

            String query = "SELECT * FROM users WHERE email=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");

                if (!PasswordUtil.verify(password, storedHash)) {
                    return null;
                }

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            System.out.println("Login Error:");
            e.printStackTrace();
        }

        return user;
    }
}