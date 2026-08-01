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
    <title>Add Ride | Commuto</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>

<body>

<%@include file="navbar.jsp" %>

<div class="form-container">
    <div class="form-card">

        <h2>Offer a Ride</h2>
        <p class="tagline">Add ride manually or use your live location</p>

        <form action="<%=request.getContextPath()%>/AddRideServlet" method="post">

            <input type="hidden"
                   name="csrfToken"
                   value="<%= session.getAttribute("csrfToken") %>">

            <input type="text"
                   id="source"
                   name="source"
                   placeholder="Enter Source manually"
                   required>

            <button type="button"
                    class="btn btn-secondary"
                    onclick="getLocation()">
                Use My Current Location
            </button>

            <input type="hidden" id="sourceLat" name="sourceLat">
            <input type="hidden" id="sourceLng" name="sourceLng">

            <br><br>

            <input type="text"
                   name="destination"
                   placeholder="Enter Destination"
                   required>

            <input type="text"
                    name="vehicleNumber"
                    placeholder="Enter Vehicle Number"
                    required>

            <input type="number"
                   name="totalSeats"
                   placeholder="Total Seats"
                   min="1"
                   required>

            <input type="number"
                   step="0.01"
                   name="totalFare"
                   placeholder="Total Cab Fare"
                   min="1"
                   required>

            <button type="submit" class="btn btn-primary">
                Add Ride
            </button>

        </form>

    </div>
</div>

<script>

function getLocation() {

    if (navigator.geolocation) {

        navigator.geolocation.getCurrentPosition(

            async function(position) {

                let lat = position.coords.latitude;
                let lng = position.coords.longitude;

                document.getElementById("sourceLat").value = lat;
                document.getElementById("sourceLng").value = lng;

                try {

                    let response = await fetch(
                        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat="
                        + lat + "&lon=" + lng
                    );

                    let data = await response.json();

                    if(data.display_name){

                        document.getElementById("source").value =
                                data.display_name;

                    }else{

                        document.getElementById("source").value =
                                lat + ", " + lng;
                    }

                } catch(error){

                    document.getElementById("source").value =
                            lat + ", " + lng;
                }

            },

            function(error) {

                alert("Location permission denied.");

            }
        );

    } else {

        alert("Geolocation not supported.");

    }
}

</script>

</body>
</html>