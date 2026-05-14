package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Ride;

public class RideDAO {

    public boolean addRide(Ride ride) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String query =
                    "INSERT INTO rides(driver_id, source, destination, ride_date, ride_time, "
                    + "total_seats, available_seats, total_fare,vehicle_number, source_lat, source_lng) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, ride.getDriverId());
            ps.setString(2, ride.getSource());
            ps.setString(3, ride.getDestination());
            ps.setString(4, ride.getRideDate());
            ps.setString(5, ride.getRideTime());
            ps.setInt(6, ride.getTotalSeats());
            ps.setInt(7, ride.getAvailableSeats());
            ps.setDouble(8, ride.getTotalFare());
            ps.setDouble(9, ride.getSourceLat());
            ps.setDouble(10, ride.getSourceLng());
            ps.setString(11, ride.getVehicleNumber());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<Ride> getAllRides() {

        ArrayList<Ride> list = new ArrayList<Ride>();

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM rides WHERE status='ACTIVE'";

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Ride ride = new Ride();

                ride.setRideId(rs.getInt("ride_id"));
                ride.setDriverId(rs.getInt("driver_id"));
                ride.setSource(rs.getString("source"));
                ride.setDestination(rs.getString("destination"));
                ride.setRideDate(rs.getString("ride_date"));
                ride.setRideTime(rs.getString("ride_time"));
                ride.setTotalSeats(rs.getInt("total_seats"));
                ride.setAvailableSeats(rs.getInt("available_seats"));
                ride.setTotalFare(rs.getDouble("total_fare"));
                ride.setSourceLat(rs.getDouble("source_lat"));
                ride.setSourceLng(rs.getDouble("source_lng"));
                ride.setStatus(rs.getString("status"));

                list.add(ride);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public ArrayList<Ride> searchRides(String source, String destination) {

    ArrayList<Ride> list = new ArrayList<Ride>();

    try {
        Connection con = DBConnection.getConnection();

        String query = "SELECT * FROM rides WHERE status='ACTIVE' "
                + "AND LOWER(source) LIKE LOWER(?) "
                + "AND LOWER(destination) LIKE LOWER(?)";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, "%" + source + "%");
        ps.setString(2, "%" + destination + "%");

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Ride ride = new Ride();

            ride.setRideId(rs.getInt("ride_id"));
            ride.setDriverId(rs.getInt("driver_id"));
            ride.setSource(rs.getString("source"));
            ride.setDestination(rs.getString("destination"));
            ride.setRideDate(rs.getString("ride_date"));
            ride.setRideTime(rs.getString("ride_time"));
            ride.setTotalSeats(rs.getInt("total_seats"));
            ride.setAvailableSeats(rs.getInt("available_seats"));
            ride.setTotalFare(rs.getDouble("total_fare"));
            ride.setSourceLat(rs.getDouble("source_lat"));
            ride.setSourceLng(rs.getDouble("source_lng"));
            ride.setStatus(rs.getString("status"));

            list.add(ride);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
}