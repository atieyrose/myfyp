<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Employee List</title>
        <!-- Bootstrap CSS -->
        <% String fname = (String) session.getAttribute("firstName"); %>
        <!-- Montserrat Font -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
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
            
            <!-- End Sidebar -->
            <%
        String role= (String) session.getAttribute("role");
        %>
             <% if ("manager".equals(role)) { %>
    <jsp:include page="managerNavBar.jsp"/>
    <% } else { %>
    <jsp:include page="clerkNavBar.jsp"/>
    <% } %>

            <!-- Main -->
            <main class="main-container">
          
                    <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                        Employee List
                    </h2>
                    <hr>
                    
                    <% 
                if ("manager".equals(role) || "clerk".equals(role)) { 
                %>
                <a href="employeeServlet?action=empnew" class="btn btn-success float-right">Add New Employee</a>
                <% } else { 
                } %>

                    <table class="table table-striped table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th>ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Card ID</th>
                                <th>Role</th>
                                <th>IC Number</th>
                                <th>Date Of Birth</th>
                                <th>Phone Number</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="employee" items="${listemployee}">
                                <tr>
                                    <td><c:out value="${employee.ID}" /></td>
                                    <td><c:out value="${employee.firstName}" /></td>
                                    <td><c:out value="${employee.lastName}" /></td>
                                    <td><c:out value="${employee.cardID}" /></td>
                                    <td><c:out value="${employee.role}" /></td>
                                    <td><c:out value="${employee.icNo}" /></td>
                                    <td><c:out value="${employee.DOB}" /></td>
                                    <td><c:out value="${employee.phoneNo}" /></td>
                                    <td><c:out value="${employee.email}" /></td>
                                    <td><c:out value="${employee.address}" /></td>
                                    <td>
                                        <button class="btn btn-warning" style="margin-bottom: 4px;"><a style="color: white" href="employeeServlet?action=empedit&ID=<c:out value='${employee.ID}' />" >Edit</a></button>
                                        <button class="deleteButton btn btn-danger" style="margin-bottom: 4px;" data-employee-id="<c:out value='${employee.ID}' />">Delete</button>
                                        <a class="btn btn-info" style="color: white;" href="attendancesStatistic.jsp?uid=<c:out value='${employee.cardID}' />">Attendances</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                
            </main>
            <!-- End Main -->
        </div>
        <!-- Scripts -->
        <script>
            // Function to show a confirmation message when a Delete button is clicked
            document.querySelectorAll(".deleteButton").forEach(function (button) {
                button.addEventListener("click", function () {
                    var employeeID = this.getAttribute("data-employee-id");

                    // Use the built-in confirm dialog
                    var confirmation = confirm("Are you sure you want to delete this item?");

                    // Check if the user clicked "OK" in the confirmation dialog
                    if (confirmation) {
                        // If "OK" is clicked, navigate to the specified link with the employeeID
                        window.location.href = "employeeServlet?action=empdelete&ID=" + employeeID;
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
