package controller;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Email = " + email);
        System.out.println("Password = " + password);

        if (email == null || password == null ||
                email.trim().equals("") || password.trim().equals("")) {

            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email.trim(), password.trim());

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            if ("DRIVER".equals(user.getRole())) {
                response.sendRedirect("driverDashboard.jsp");
            } else if ("PASSENGER".equals(user.getRole())) {
                response.sendRedirect("passengerDashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?error=role");
            }

        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}