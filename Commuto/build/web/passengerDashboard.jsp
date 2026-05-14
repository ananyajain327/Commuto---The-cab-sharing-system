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

    <title>Passenger Dashboard</title>

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
                Search available rides,
                split your fare,
                and travel comfortably.
            </p>

            <a href="searchRide.jsp"
               class="btn btn-primary">

                Search Ride

            </a>

            <a href="myBookings.jsp"
               class="btn btn-secondary">

                My Bookings

            </a>

            <a href="LogoutServlet"
               class="btn btn-primary">

                Logout

            </a>

        </div>

    </div>

</body>
</html>