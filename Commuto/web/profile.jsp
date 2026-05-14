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

    <title>My Profile</title>

    <link rel="stylesheet"
          href="assets/css/style.css">

    <style>

        .profile-container{
            min-height:85vh;
            display:flex;
            align-items:center;
            justify-content:center;
        }

        .profile-card{
            width:420px;
            background:rgba(255,255,255,0.15);
            backdrop-filter:blur(12px);
            border-radius:24px;
            padding:35px;
            color:white;
            text-align:center;
            box-shadow:0 10px 30px rgba(0,0,0,0.35);
        }

        .profile-card img{
            width:120px;
            height:120px;
            border-radius:50%;
            margin-bottom:20px;
            border:4px solid white;
        }

        .profile-card h2{
            margin-bottom:10px;
        }

        .profile-card p{
            margin-bottom:10px;
            font-size:17px;
        }

    </style>

</head>

<body>

    <%@include file="navbar.jsp" %>

    <div class="profile-container">

        <div class="profile-card">

            <img src="assets/images/profile.png"
                 alt="Profile">

            <h2>
                <%= currentUser.getFullName() %>
            </h2>

            <p>
                Email:
                <%= currentUser.getEmail() %>
            </p>

            <p>
                Phone:
                <%= currentUser.getPhone() %>
            </p>

            <p>
                Role:
                <%= currentUser.getRole() %>
            </p>

            <br>

            <a href="LogoutServlet"
               class="btn btn-primary">

                Logout

            </a>

        </div>

    </div>

</body>
</html>