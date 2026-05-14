<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>Search Ride | Commuto</title>

    <link rel="stylesheet"
          href="assets/css/style.css">

</head>

<body>

    <%@include file="navbar.jsp" %>

    <div class="form-container">

        <div class="form-card">

            <h2>Find Your Ride</h2>

            <p class="tagline">
                Search rides and travel smarter
            </p>

            <form action="availableRides.jsp"
                  method="get">

                <input type="text"
                       name="source"
                       placeholder="Enter Source"
                       required>

                <input type="text"
                       name="destination"
                       placeholder="Enter Destination"
                       required>

                <button type="submit"
                        class="btn btn-primary">

                    Search Ride

                </button>

            </form>

        </div>

    </div>

</body>
</html>