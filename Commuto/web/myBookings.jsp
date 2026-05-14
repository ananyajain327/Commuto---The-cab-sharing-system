<%@page import="java.sql.*"%>
<%@page import="dao.DBConnection"%>
<%@page import="model.User"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User currentUser =
            (User) session.getAttribute("currentUser");

    if(currentUser == null){
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>

<html>
<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>My Bookings</title>

    <link rel="stylesheet"
          href="assets/css/style.css">

    <style>

        .booking-container{
            width:90%;
            margin:40px auto;
        }

        .booking-card{
            background:rgba(255,255,255,0.15);
            backdrop-filter:blur(12px);
            border-radius:20px;
            padding:25px;
            margin-bottom:20px;
            color:white;
            box-shadow:0 10px 30px rgba(0,0,0,0.35);
        }

        .booking-card h2{
            margin-bottom:12px;
        }

        .booking-card p{
            margin-bottom:8px;
        }

    </style>

</head>

<body>

    <%@include file="navbar.jsp" %>

    <div class="booking-container">

        <%

            try{

                Connection con =
                        DBConnection.getConnection();

                String query =
                        "SELECT b.*, r.source, r.destination,"
                        + " r.ride_date, r.ride_time "
                        + "FROM bookings b "
                        + "JOIN rides r "
                        + "ON b.ride_id = r.ride_id "
                        + "WHERE b.passenger_id=?";

                PreparedStatement ps =
                        con.prepareStatement(query);

                ps.setInt(1,
                        currentUser.getUserId());

                ResultSet rs =
                        ps.executeQuery();

                while(rs.next()){

        %>

        <div class="booking-card">

            <h2>
                <%= rs.getString("source") %>
                →
                <%= rs.getString("destination") %>
            </h2>

            <p>
                Date:
                <%= rs.getString("ride_date") %>
            </p>

            <p>
                Time:
                <%= rs.getString("ride_time") %>
            </p>

            <p>
                Seats Booked:
                <%= rs.getInt("seats_booked") %>
            </p>

            <p>
                Fare Per Person:
                ₹<%= rs.getDouble("fare_per_person") %>
            </p>

            <p>
                Booking Status:
                <%= rs.getString("booking_status") %>
            </p>

        </div>

        <%
                }

            }catch(Exception e){
                e.printStackTrace();
            }

        %>

    </div>

</body>
</html>