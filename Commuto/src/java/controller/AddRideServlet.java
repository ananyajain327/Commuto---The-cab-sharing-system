package controller;

import dao.RideDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Ride;
import model.User;

@WebServlet("/AddRideServlet")
public class AddRideServlet extends HttpServlet {

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
//        String rideDate = request.getParameter("rideDate");
//        String rideTime = request.getParameter("rideTime");
       java.time.LocalDate currentDate = java.time.LocalDate.now();

        java.time.LocalTime currentTime = java.time.LocalTime.now();

        String rideDate = currentDate.toString();

        String rideTime = currentTime.withNano(0).toString();
        String vehicleNumber =
        request.getParameter("vehicleNumber");


        int totalSeats = Integer.parseInt(request.getParameter("totalSeats"));
        double totalFare = Double.parseDouble(request.getParameter("totalFare"));

        Ride ride = new Ride();

        ride.setDriverId(currentUser.getUserId());
        ride.setSource(source);
        ride.setDestination(destination);
        ride.setRideDate(rideDate);
        ride.setRideTime(rideTime);
        ride.setTotalSeats(totalSeats);
        ride.setAvailableSeats(totalSeats);
        ride.setTotalFare(totalFare);
        ride.setVehicleNumber(vehicleNumber);

        RideDAO dao = new RideDAO();

        boolean status = dao.addRide(ride);

        if (status) {
            response.sendRedirect("driverDashboard.jsp");
        } else {
            response.sendRedirect("addRide.jsp");
        }
    }
}
