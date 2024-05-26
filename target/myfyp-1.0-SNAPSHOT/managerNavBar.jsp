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
        <title>Manager Nav Bar</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <jsp:include page="bootstrap.jsp"/>
        <% String fname= (String) session.getAttribute("firstName"); %>

        <style>
            /* Custom Navbar Styles */
            .custom-navbar {
                background-color: #333333; /* Dark Black Background Color */
                height: 80px;
            }

            /* White text color for small screens */
            @media (max-width: 576px) {
                .custom-navbar h3 {
                    color: white;
                }
            </style>
        </head>
        <body>


            <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
                <!-- Add a Navbar Brand -->
                <h3 style="color: white"><a href="userDetails.jsp" style="color: white">Manager</a>, <%= fname %></h3>
                <!-- Add a Navbar Toggler   -->
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto"> <!-- Change to ml-auto for right alignment on larger screens -->
                        <li class="nav-item <%= (request.getRequestURI().endsWith("managerDashboard.jsp")) ? "active" : "" %>">
                            <a class="nav-link" href="managerDashboard.jsp">Dashboard <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item <%= (request.getRequestURI().endsWith("employeeServlet?action=emplist")) ? "active" : "" %>">
                            <a class="nav-link" href="employeeServlet?action=emplist">Employee <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item <%= (request.getRequestURI().endsWith("attendancesList.jsp")) ? "active" : "" %>">
                            <a class="nav-link" href="attendancesList.jsp">Attendances <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item <%= (request.getRequestURI().endsWith("customersServlet?action=custlist")) ? "active" : "" %>">
                            <a class="nav-link" href="customersServlet?action=custlist">Customers <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item <%= (request.getRequestURI().endsWith("salesList.jsp")) ? "active" : "" %>">
                            <a class="nav-link" href="processSales.jsp">Sales <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item <%= (request.getRequestURI().endsWith("suppliersServlet?action=suplist")) ? "active" : "" %>">
                            <a class="nav-link" href="suppliersServlet?action=suplist">Suppliers <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item <%= (request.getRequestURI().endsWith("expensesList.jsp")) ? "active" : "" %>">
                            <a class="nav-link" href="expensesList.jsp">Expenses <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item <%= (request.getRequestURI().endsWith("productsServlet?action=prodlist")) ? "active" : "" %>">
                            <a class="nav-link" href="productsServlet?action=prodlist">Products <span class="sr-only">(current)</span></a>
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
