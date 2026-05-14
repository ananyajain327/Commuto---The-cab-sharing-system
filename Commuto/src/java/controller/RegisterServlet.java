package controller;

import dao.UserDAO;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        System.out.println(fullName);
        System.out.println(email);
        System.out.println(password);
        System.out.println(phone);
        System.out.println(role);

        if (fullName == null || email == null
                || password == null || phone == null
                || role == null) {

            response.sendRedirect("register.jsp?error=empty");
            return;
        }

        User user = new User();

        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPassword(password.trim());
        user.setPhone(phone.trim());
        user.setRole(role.trim());

        UserDAO dao = new UserDAO();

        boolean status = dao.registerUser(user);

        if (status) {

            response.sendRedirect("login.jsp");

        } else {

            response.sendRedirect("register.jsp?error=failed");
        }
    }
}