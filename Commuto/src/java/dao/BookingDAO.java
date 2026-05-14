package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookingDAO {

    public boolean bookRide(int rideId, int passengerId, int seatsBooked) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String rideQuery = "SELECT total_fare, available_seats FROM rides WHERE ride_id=?";
            PreparedStatement ps = con.prepareStatement(rideQuery);
            ps.setInt(1, rideId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int availableSeats = rs.getInt("available_seats");

                if (availableSeats >= seatsBooked) {

                    String insertQuery =
                            "INSERT INTO bookings(ride_id, passenger_id, seats_booked, fare_per_person, booking_status) "
                            + "VALUES(?,?,?,?,?)";

                    ps = con.prepareStatement(insertQuery);
                    ps.setInt(1, rideId);
                    ps.setInt(2, passengerId);
                    ps.setInt(3, seatsBooked);
                    ps.setDouble(4, 0.0);
                    ps.setString(5, "PENDING");

                    int rows = ps.executeUpdate();

                    if (rows > 0) {
                        status = true;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}