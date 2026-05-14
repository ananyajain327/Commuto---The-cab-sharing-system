<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    User currentUser =
            (User) session.getAttribute("currentUser");

    if (currentUser == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>

<html>
<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>Driver Dashboard</title>

    <link rel="stylesheet"
          href="assets/css/style.css">

</head>

<body>

    <%@include file="navbar.jsp" %>

    <div class="hero">

        <div class="hero-box">

            <h1>
                Welcome,
                <%= currentUser.getFullName()%>
            </h1>

            <p>
                Manage your rides, offer seats,
                and help passengers travel smarter.
            </p>

            <a href="addRide.jsp"
               class="btn btn-primary">

                Add New Ride

            </a>

            <a href="bookingHistory.jsp"
               class="btn btn-secondary">

                View Bookings
                
                <a href="rideRequests.jsp"
                class="btn btn-secondary">
                 Passenger Requests
                </a>

            </a>

            <a href="LogoutServlet"
               class="btn btn-primary">

                Logout

            </a>

        </div>

    </div>

</body>
</html>