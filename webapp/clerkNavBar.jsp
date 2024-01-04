<%-- 
    Document   : managerNavBar
    Created on : 22 Dec 2023, 6:28:35 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clerk Nav Bar</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">-->
        <jsp:include page="bootstrap.jsp"/>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Manager</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("clerkDashboard.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="clerkDashboard.jsp">Dashboard <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Attendances</a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("leave.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="leave.jsp">Leave <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Customers</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Sales</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Suppliers</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Expenses</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Products</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Inventory</a>
                    </li>
                    <li class="nav-item mx-2">
                        <a class="nav-link" href="#">Cash Flow</a>
                    </li>
                </ul>

            </div>
        </nav>

   <!--     <div class="container">
            <div class="row">
                <div class="col-sm-4">
                    One of three columns
                </div>
                <div class="col-sm-4">
                    One of three columns
                </div>
                <div class="col-sm-4">
                    One of three columns
                </div>
            </div>
        </div> -->

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    </body>
</html>

