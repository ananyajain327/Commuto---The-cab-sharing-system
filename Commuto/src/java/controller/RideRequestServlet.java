package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.User;

@WebServlet("/RideRequestServlet")
public class RideRequestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        int seats = Integer.parseInt(request.getParameter("seats"));

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO ride_requests(passenger_id, source, destination, seats_required) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, currentUser.getUserId());
            ps.setString(2, source);
            ps.setString(3, destination);
            ps.setInt(4, seats);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("availableRides.jsp?source=" + source + "&destination=" + destination + "&requested=true");
    }
}