package controller;

import dao.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AcceptRideServlet")
public class AcceptRideServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        try {
            Connection con = DBConnection.getConnection();

            String getQuery =
                    "SELECT b.ride_id, b.seats_booked, r.total_fare, r.available_seats "
                    + "FROM bookings b "
                    + "JOIN rides r ON b.ride_id = r.ride_id "
                    + "WHERE b.booking_id=?";

            PreparedStatement ps = con.prepareStatement(getQuery);
            ps.setInt(1, bookingId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int rideId = rs.getInt("ride_id");
                int seatsBooked = rs.getInt("seats_booked");
                double totalFare = rs.getDouble("total_fare");
                int availableSeats = rs.getInt("available_seats");

                if (availableSeats >= seatsBooked) {

                    String acceptQuery =
                            "UPDATE bookings SET booking_status='ACCEPTED' WHERE booking_id=?";

                    ps = con.prepareStatement(acceptQuery);
                    ps.setInt(1, bookingId);
                    ps.executeUpdate();

                    String seatQuery =
                            "UPDATE rides SET available_seats = available_seats - ? WHERE ride_id=?";

                    ps = con.prepareStatement(seatQuery);
                    ps.setInt(1, seatsBooked);
                    ps.setInt(2, rideId);
                    ps.executeUpdate();

                    String countQuery =
                            "SELECT IFNULL(SUM(seats_booked),0) AS total_passengers "
                            + "FROM bookings WHERE ride_id=? AND booking_status='ACCEPTED'";

                    ps = con.prepareStatement(countQuery);
                    ps.setInt(1, rideId);

                    ResultSet rs2 = ps.executeQuery();

                    int totalPassengers = 0;

                    if (rs2.next()) {
                        totalPassengers = rs2.getInt("total_passengers");
                    }

                    if (totalPassengers > 0) {

                        double farePerPerson = totalFare / totalPassengers;

                        String fareQuery =
                                "UPDATE bookings SET fare_per_person=? "
                                + "WHERE ride_id=? AND booking_status='ACCEPTED'";

                        ps = con.prepareStatement(fareQuery);
                        ps.setDouble(1, farePerPerson);
                        ps.setInt(2, rideId);
                        ps.executeUpdate();
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("bookingHistory.jsp");
    }
}