<%-- 
    Document   : customersList
    Created on : 22 Dec 2023, 5:39:18 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customers List</title>
        <!-- Bootstrap CSS -->

        <% String fname = (String) session.getAttribute("firstName"); %>
        <!-- Montserrat Font -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        <!--        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">-->
<!--        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">-->
        <!-- Custom Styles -->
        <link rel="stylesheet" href="css/styles.css">
         <style>
            body {
                font-family: 'Montserrat', sans-serif;
            }
            .table-container {
                margin: 20px auto;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }
            .table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            .table th, .table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            .table thead th {
                background-color: #333;
                color: #fff;
                text-transform: uppercase;
            }
            .table tbody tr:hover {
                background-color: #f1f1f1;
            }
            .btn {
                display: inline-block;
                padding: 10px 15px;
                margin: 5px 0;
                text-decoration: none;
                text-align: center;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .btn-warning {
                background-color: #f0ad4e;
                color: #fff;
            }
            .btn-warning:hover {
                background-color: #ec971f;
            }
            .btn-danger {
                background-color: #d9534f;
                color: #fff;
            }
            .btn-danger:hover {
                background-color: #c9302c;
            }
            @media (max-width: 768px) {
                .table-container {
                    padding: 10px;
                }
                .table th, .table td {
                    padding: 8px;
                }
            }
        </style>
    </head>
    <body>
        <div class="grid-container">
            <!-- Header -->
            <header class="header">
                <h2>JERNIH TILING ENT</h2>
                
            </header>
            <!-- End Header -->

            <!-- Sidebar -->
            <%
        String role= (String) session.getAttribute("role");
        %>
            <% if ("manager".equals(role)) { %>
        <jsp:include page="managerNavBar.jsp"/>
        <% } else if ("clerk".equals(role)) { %>
        <jsp:include page="clerkNavBar.jsp"/>
        <% } else if ("admin".equals(role)) { %>
        <jsp:include page="adminNavBar.jsp"/>
        <% } else { %>
        <jsp:include page="staffNavBar.jsp"/>
        <% } %>
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
               <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Customer List
                </h2>
            <hr>
            
            <% 
            if ("manager".equals(role) || "clerk".equals(role)) { 
            %>
             <a href="customersServlet?action=custnew" class="btn btn-success float-right">Add New Customer</a>
            <% } else { 
                } %>
            <br><br>

          <table class="table table-striped table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Customer ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Phone Number</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="customers" items="${listcustomers}">
                            <tr>
                                <td><c:out value="${customers.custID}" /></td>
                                <td><c:out value="${customers.firstName}" /></td>
                                <td><c:out value="${customers.lastName}" /></td>
                                <td><c:out value="${customers.phoneNo}" /></td>
                                <td><c:out value="${customers.email}" /></td>
                                <td><c:out value="${customers.address}" /></td>
                                <td>
                                    <button class="btn btn-warning" style="margin-bottom: 4px; height: 40px; width: 72px"><a style="color: white" href="customersServlet?action=custedit&custID=<c:out value='${customers.custID}' />" >Edit</a></button>
                                    <button class="deleteButton btn btn-danger" style="margin-bottom: 4px; height: 40px; width: 72px" data-cust-id="<c:out value='${customers.custID}' />">Delete</button>
                                    <!--<a href="employeeServlet?action=empdelete&ID=<c:out value='${customers.custID}' />" class="btn btn-danger">Delete</a>-->
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </div>

           
            </main>
            <!-- End Main -->
        </div>
        <!-- Scripts -->
            <script>
// Function to show a confirmation message when a Delete button is clicked
            document.querySelectorAll(".deleteButton").forEach(function (button) {
                button.addEventListener("click", function () {
                    var custID = this.getAttribute("data-cust-id");

                    // Use the built-in `confirm` dialog
                    var confirmation = confirm("Are you sure you want to delete this item?");

                    // Check if the user clicked "OK" in the confirmation dialog
                    if (confirmation) {
                        // If "OK" is clicked, navigate to the specified link with the employeeID
                        window.location.href = "customersServlet?action=custdelete&custID=" + custID;
                    } else {
                        // Cancelled, no action needed
                        alert("Delete operation cancelled.");
                    }
                });
            });
        </script>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- ApexCharts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.35.3/apexcharts.min.js"></script>
        <!-- Custom JS -->
        <script src="js/scripts.js"></script>
    </body>
</html>
