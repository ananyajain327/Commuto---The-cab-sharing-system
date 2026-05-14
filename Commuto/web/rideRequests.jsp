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

    if (!"DRIVER".equals(currentUser.getRole())) {
        response.sendRedirect("passengerDashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ride Requests | Commuto</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <style>
        .request-container {
            width: 90%;
            margin: 40px auto;
        }

        .request-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px;
        }

        .request-card {
            background: rgba(255,255,255,0.96);
            color: #111827;
            padding: 24px;
            border-radius: 18px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.22);
        }

        .request-card h2 {
            margin-bottom: 12px;
        }

        .request-card p {
            margin-bottom: 8px;
            font-size: 16px;
        }

        .status {
            color: #d97706;
            font-weight: bold;
        }

        @media(max-width: 900px) {
            .request-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<%@include file="navbar.jsp" %>

<div class="request-container">

    <div class="search-summary">
        <h2>Passenger Ride Requests</h2>
        <p>Requests made by passengers when no matching ride was available.</p>
    </div>

    <div class="request-grid">

        <%
            try {
                Connection con = DBConnection.getConnection();

                String sql =
                        "SELECT rr.*, u.full_name, u.email, u.phone "
                        + "FROM ride_requests rr "
                        + "JOIN users u ON rr.passenger_id = u.user_id "
                        + "WHERE rr.request_status='PENDING' "
                        + "ORDER BY rr.request_date DESC";

                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                boolean found = false;

                while (rs.next()) {
                    found = true;
        %>

        <div class="request-card">

            <h2>
                <%= rs.getString("source") %>
                →
                <%= rs.getString("destination") %>
            </h2>

            <p>Passenger: <%= rs.getString("full_name") %></p>
            <p>Email: <%= rs.getString("email") %></p>
            <p>Phone: <%= rs.getString("phone") %></p>
            <p>Seats Required: <%= rs.getInt("seats_required") %></p>
            <p>Status: <span class="status"><%= rs.getString("request_status") %></span></p>

            <br>

            <a href="addRide.jsp"
               class="btn btn-primary">
                Add Ride for This Request
            </a>

        </div>

        <%
                }

                if (!found) {
        %>

        <div class="request-card">
            <h2>No pending ride requests</h2>
            <p>Passenger requests will appear here.</p>
        </div>

        <%
                }

            } catch (Exception e) {
                e.printStackTrace();
        %>

        <div class="request-card">
            <h2>Error loading requests</h2>
            <p>Please check database connection.</p>
        </div>

        <%
            }
        %>

    </div>

</div>

</body>
</html>
