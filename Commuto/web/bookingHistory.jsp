<%@page import="java.sql.*"%>
<%@page import="dao.DBConnection"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User currentUser = (User) session.getAttribute("currentUser");

    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Requests | Commuto</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <style>
        .history-container {
            width: 90%;
            margin: 40px auto;
        }

        .history-card {
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 20px;
            color: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.35);
        }

        .history-card h2 {
            margin-bottom: 12px;
        }

        .history-card p {
            margin-bottom: 8px;
        }

        .status {
            font-weight: bold;
            color: #ffd166;
        }

        .action-form {
            display: inline-block;
            margin-right: 10px;
            margin-top: 12px;
        }
    </style>
</head>

<body>

<%@include file="navbar.jsp" %>

<div class="history-container">

<%
    try {
        Connection con = DBConnection.getConnection();

        String query =
                "SELECT b.booking_id, b.seats_booked, b.fare_per_person, "
                + "b.booking_status, u.full_name, u.email, u.phone, "
                + "r.source, r.destination, r.ride_date, r.ride_time "
                + "FROM bookings b "
                + "JOIN users u ON b.passenger_id = u.user_id "
                + "JOIN rides r ON b.ride_id = r.ride_id "
                + "WHERE r.driver_id=? "
                + "ORDER BY b.booking_id DESC";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, currentUser.getUserId());

        ResultSet rs = ps.executeQuery();

        boolean hasData = false;

        while (rs.next()) {
            hasData = true;
            String status = rs.getString("booking_status");
%>

    <div class="history-card">

        <h2>
            <%= rs.getString("source") %>
            →
            <%= rs.getString("destination") %>
        </h2>

        <p>Passenger: <%= rs.getString("full_name") %></p>
        <p>Email: <%= rs.getString("email") %></p>
        <p>Phone: <%= rs.getString("phone") %></p>
        <p>Date: <%= rs.getString("ride_date") %></p>
        <p>Time: <%= rs.getString("ride_time") %></p>
        <p>Seats Requested: <%= rs.getInt("seats_booked") %></p>
        <p>Fare Per Person: ₹<%= rs.getDouble("fare_per_person") %></p>

        <p>
            Booking Status:
            <span class="status"><%= status %></span>
        </p>

        <% if ("PENDING".equals(status)) { %>

            <form action="AcceptRideServlet" method="post" class="action-form">
                <input type="hidden"
                       name="csrfToken"
                       value="<%= session.getAttribute("csrfToken") %>">

                <input type="hidden"
                       name="bookingId"
                       value="<%= rs.getInt("booking_id") %>">

                <button type="submit" class="btn btn-primary">
                    Accept
                </button>
            </form>

            <form action="RejectRideServlet" method="post" class="action-form">
                <input type="hidden"
                       name="csrfToken"
                       value="<%= session.getAttribute("csrfToken") %>">

                <input type="hidden"
                       name="bookingId"
                       value="<%= rs.getInt("booking_id") %>">

                <button type="submit" class="btn btn-secondary">
                    Reject
                </button>
            </form>

        <% } %>

    </div>

<%
        }

        if (!hasData) {
%>
    <div class="history-card">
        <h2>No booking requests yet</h2>
        <p>Passenger requests will appear here.</p>
    </div>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
    <div class="history-card">
        <h2>Error loading booking requests</h2>
        <p>Please check database connection.</p>
    </div>
<%
    }
%>

</div>

</body>
</html>