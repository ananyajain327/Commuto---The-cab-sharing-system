package controller;

import dao.BookingDAO;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

import model.User;

@WebServlet("/BookRideServlet")
public class BookRideServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("currentUser");

        int passengerId = currentUser.getUserId();

        int rideId = Integer.parseInt(request.getParameter("rideId"));

        int seatsBooked = Integer.parseInt(
                request.getParameter("seatsBooked"));

        BookingDAO dao = new BookingDAO();

        boolean status = dao.bookRide(
                rideId,
                passengerId,
                seatsBooked
        );

        if (status) {

            response.sendRedirect("myBookings.jsp");

        } else {

            response.sendRedirect("availableRides.jsp");
        }
    }
}