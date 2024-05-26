<%-- 
    Document   : staffNavBar
    Created on : 23 Jan 2024, 12:25:04 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manager Nav Bar</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <jsp:include page="bootstrap.jsp"/>
        <% String fname= (String) session.getAttribute("firstName"); %>
    </head>
    <body>

        
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <!-- Add a Navbar Brand -->
            <h3 style="color: white"><a href="userDetails.jsp" style="color: white">Staff</a>, <%= fname %></h3>
            <!-- Add a Navbar Toggler   -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto"> <!-- Change to ml-auto for right alignment on larger screens -->
                    <li class="nav-item <%= (request.getRequestURI().endsWith("managerDashboard.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="staffDashboard.jsp">Dashboard <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item <%= (request.getRequestURI().endsWith("attendancesListStaff.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="attendancesListStaff.jsp">Attendances <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="loginPage.jsp">Log Out</a>
                    </li>
                </ul>
            </div>
        </nav>


        <!-- Bootstrap JavaScript and jQuery -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>

