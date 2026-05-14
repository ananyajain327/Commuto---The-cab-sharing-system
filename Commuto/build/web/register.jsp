<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

    <meta charset="UTF-8">

    <title>Register | Commuto</title>

    <link rel="stylesheet"
          href="assets/css/style.css">

</head>

<body>

<%@include file="navbar.jsp" %>

<div class="form-container">

    <div class="form-card">

        <h2>Create Account</h2>

        <p class="tagline">
            Join Commuto and share your rides
        </p>

        <%
            String error = request.getParameter("error");

            if("empty".equals(error)){
        %>

        <p style="color:#ffd166;
                  text-align:center;
                  margin-bottom:15px;">

            All fields are required

        </p>

        <%
            }

            if("failed".equals(error)){
        %>

        <p style="color:#ffd166;
                  text-align:center;
                  margin-bottom:15px;">

            Registration Failed

        </p>

        <%
            }
        %>

        <form action="<%=request.getContextPath()%>/RegisterServlet"
              method="post">

            <input type="text"
                   name="fullName"
                   placeholder="Enter Full Name"
                   required>

            <input type="email"
                   name="email"
                   placeholder="Enter Email"
                   required>

            <input type="password"
                   name="password"
                   placeholder="Create Password"
                   required>

            <input type="text"
                   name="phone"
                   placeholder="Enter Phone Number"
                   required>

            <select name="role" required>

                <option value="">
                    Select Role
                </option>

                <option value="PASSENGER">
                    Passenger
                </option>

                <option value="DRIVER">
                    Driver
                </option>

            </select>

            <button type="submit"
                    class="btn btn-primary">

                Register

            </button>

        </form>

        <br>

        <p style="text-align:center;">

            Already have an account?

            <a href="login.jsp">
                Login
            </a>

        </p>

    </div>

</div>

</body>
</html>