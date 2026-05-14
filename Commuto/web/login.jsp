<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login | Commuto</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>

<body>

<%@include file="navbar.jsp" %>

<div class="form-container">

    <div class="form-card">

        <h2>Welcome Back</h2>

        <p class="tagline">
            Login to continue your journey
        </p>

        <%
            String error = request.getParameter("error");

            if ("empty".equals(error)) {
        %>
            <p style="color:#ffd166; text-align:center; margin-bottom:15px;">
                Please enter email and password.
            </p>
        <%
            } else if ("invalid".equals(error)) {
        %>
            <p style="color:#ffd166; text-align:center; margin-bottom:15px;">
                Invalid email or password.
            </p>
        <%
            } else if ("role".equals(error)) {
        %>
            <p style="color:#ffd166; text-align:center; margin-bottom:15px;">
                Invalid user role found.
            </p>
        <%
            }
        %>

        <form action="<%=request.getContextPath()%>/LoginServlet"
              method="post">

            <input type="email"
                   name="email"
                   placeholder="Enter Email"
                   required>

            <input type="password"
                   name="password"
                   placeholder="Enter Password"
                   required>

            <button type="submit"
                    class="btn btn-primary">
                Login
            </button>

        </form>

        <br>

        <p style="text-align:center;">
            Don't have an account?
            <a href="register.jsp">Register</a>
        </p>

    </div>

</div>

</body>
</html>