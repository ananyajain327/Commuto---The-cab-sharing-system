<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.RideDAO"%>
<%@page import="model.Ride"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User currentUser = (User) session.getAttribute("currentUser");

    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String source = request.getParameter("source");
    String destination = request.getParameter("destination");

    if (source == null) source = "";
    if (destination == null) destination = "";

    RideDAO dao = new RideDAO();
    ArrayList<Ride> list = dao.searchRides(source, destination);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Rides | Commuto</title>
    <link rel="stylesheet" href="assets/css/style.css">

    <style>
        .page-wrapper {
            width: 92%;
            margin: 35px auto;
        }

        .search-summary {
            background: rgba(255,255,255,0.95);
            padding: 22px;
            border-radius: 18px;
            margin-bottom: 28px;
            color: #111827;
            box-shadow: 0 10px 30px rgba(0,0,0,0.18);
        }

        .search-summary h2 {
            margin-bottom: 8px;
        }

        .rides-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
        }

        .ride-card-new {
            background: rgba(255,255,255,0.96);
            color: #111827;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.22);
        }

        .route-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 14px;
        }

        .ride-info {
            line-height: 1.9;
            font-size: 16px;
            margin-bottom: 18px;
        }

        .fare-box {
            display: flex;
            justify-content: space-between;
            border-top: 1px solid #ddd;
            padding-top: 14px;
            margin-top: 14px;
            font-weight: bold;
        }

        .ride-actions {
            margin-top: 18px;
        }

        .ride-actions input {
            width: 100%;
            padding: 12px;
            border-radius: 12px;
            border: 1px solid #ccc;
            margin-bottom: 12px;
        }

        .no-ride-box {
            background: rgba(255,255,255,0.96);
            color: #111827;
            padding: 28px;
            border-radius: 18px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.22);
            max-width: 650px;
        }

        .success-msg {
            background: #dcfce7;
            color: #166534;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        @media(max-width: 900px) {
            .rides-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<%@include file="navbar.jsp" %>

<div class="page-wrapper">

    <% if ("true".equals(request.getParameter("requested"))) { %>
        <div class="success-msg">
            Ride request sent successfully. Driver will see your request.
        </div>
    <% } %>

    <div class="search-summary">
        <h2>Available Rides</h2>
        <p>
            Showing rides from
            <b><%= source %></b>
            to
            <b><%= destination %></b>
        </p>
    </div>

    <% if (list.size() > 0) { %>

        <div class="rides-grid">

        <%
            for (Ride ride : list) {

                double farePerPerson = ride.getTotalFare() / ride.getTotalSeats();

                String mapLink =
                    "https://www.google.com/maps/dir/?api=1&origin="
                    + URLEncoder.encode(ride.getSource(), "UTF-8")
                    + "&destination="
                    + URLEncoder.encode(ride.getDestination(), "UTF-8");
        %>

            <div class="ride-card-new">

                <div class="route-title">
                    <%= ride.getSource() %> → <%= ride.getDestination() %>
                </div>

                <div class="ride-info">
                    <p>Date: <%= ride.getRideDate() %></p>
                    <p>Time: <%= ride.getRideTime() %></p>
                    <p>Available Seats: <%= ride.getAvailableSeats() %></p>
                    <p>Vehicle Number: <%= ride.getVehicleNumber() %></p>
                </div>

                <div class="fare-box">
                    <span>Total Fare: ₹<%= ride.getTotalFare() %></span>
                    <span>Per Seat: ₹<%= farePerPerson %></span>
                </div>

                <div class="ride-actions">

                    <a href="<%= mapLink %>"
                       target="_blank"
                       class="btn btn-secondary">
                        View Route on Map
                    </a>

                    <form action="BookRideServlet" method="post">

                        <input type="hidden"
                               name="csrfToken"
                               value="<%= session.getAttribute("csrfToken") %>">

                        <input type="hidden"
                               name="rideId"
                               value="<%= ride.getRideId() %>">

                        <input type="number"
                               name="seatsBooked"
                               placeholder="Enter seats"
                               min="1"
                               max="<%= ride.getAvailableSeats() %>"
                               required>

                        <button type="submit" class="btn btn-primary">
                            Book Ride
                        </button>

                    </form>

                </div>

            </div>

        <%
            }
        %>

        </div>

    <% } else { %>

        <div class="no-ride-box">
            <h2>No ride available</h2>
            <p>No driver has added a ride for this route yet.</p>
            <br>

            <form action="RideRequestServlet" method="post">

                <input type="hidden"
                       name="csrfToken"
                       value="<%= session.getAttribute("csrfToken") %>">

                <input type="hidden" name="source" value="<%= source %>">
                <input type="hidden" name="destination" value="<%= destination %>">

                <input type="number"
                       name="seats"
                       placeholder="Seats Required"
                       min="1"
                       required
                       style="width:100%; padding:14px; border-radius:12px; border:1px solid #ccc; margin-bottom:15px;">

                <button type="submit" class="btn btn-primary">
                    Request This Ride
                </button>

            </form>
        </div>

    <% } %>

</div>

</body>
</html>