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
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Manager</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("managerDashboard.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="managerDashboard.jsp">Dashboard <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("employeeServlet?action=list")) ? "active" : "" %>">
                        <a class="nav-link" href="employeeServlet?action=emplist">Employee <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2  <%= (request.getRequestURI().endsWith("attendancesList.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="attendancesList.jsp">Attendances <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("leaveList.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="leaveList.jsp">Leave <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("customersList.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="customersList.jsp">Customers <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("salesList.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="salesList.jsp">Sales <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("suppliersList.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="suppliersList.jsp">Suppliers <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("expensesList.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="expensesList.jsp">Expenses <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("productsList.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="productsList.jsp">Products <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("inventory.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="inventory.jsp">Inventory <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item mx-2 <%= (request.getRequestURI().endsWith("cashflow.jsp")) ? "active" : "" %>">
                        <a class="nav-link" href="cashflow.jsp">Cash Flow <span class="sr-only">(current)</span></a>
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

