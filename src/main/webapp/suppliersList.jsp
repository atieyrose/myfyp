<%-- 
    Document   : suppliersList
    Created on : 5 Jan 2024, 3:02:44 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Suppliers List</title>
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
            .enhanced-button {
                display: inline-block;
                padding: 15px 30px;
                font-size: 16px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #fff;
                background: #28a745;
                border: none;
                border-radius: 25px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                cursor: pointer;
                transition: all 0.3s ease;
                outline: none;
            }

            .enhanced-button:hover {
                background: #218838;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
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
            <% } else { %>
            <jsp:include page="clerkNavBar.jsp"/>
            <% } %>
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Suppliers List
                </h2>
                <hr>

                <% 
                    if ("manager".equals(role) || "clerk".equals(role)) { 
                %>
                <button class="enhanced-button" onclick="window.location.href = 'suppliersServlet?action=supnew'">Add New Supplier</button>
                <% } else { 
                } %>
                <br><br>

                <table class="table table-striped table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Supplier ID</th>
                            <th>Supplier Name</th>
                            <th>Phone Number</th>
                            <th>Email</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="suppliers" items="${listsuppliers}">
                            <tr>
                                <td><c:out value="${suppliers.supID}" /></td>
                                <td><c:out value="${suppliers.supName}" /></td>
                                <td><c:out value="${suppliers.phoneNo}" /></td>
                                <td><c:out value="${suppliers.email}" /></td>
                                <td>
                                    <button class="btn btn-warning" style="margin-bottom: 4px; height: 40px; width: 72px"><a style="color: white" href="suppliersServlet?action=supedit&supID=<c:out value='${suppliers.supID}' />" >Edit</a></button>
                                    <button class="deleteButton btn btn-danger" style="margin-bottom: 4px; height: 40px; width: 72px" data-sup-id="<c:out value='${suppliers.supID}' />">Delete</button>
                                    <!--<a href="employeeServlet?action=empdelete&ID=<c:out value='${customers.custID}' />" class="btn btn-danger">Delete</a>-->
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </main>
        </div>


        <!-- Custom JS -->
        <script>
            // Function to show a confirmation message when a Delete button is clicked
            document.querySelectorAll(".deleteButton").forEach(function (button) {
                button.addEventListener("click", function () {
                    var supID = this.getAttribute("data-sup-id");

                    // Use the built-in `confirm` dialog
                    var confirmation = confirm("Are you sure you want to delete this item?");

                    // Check if the user clicked "OK" in the confirmation dialog
                    if (confirmation) {
                        // If "OK" is clicked, navigate to the specified link with the employeeID
                        window.location.href = "suppliersServlet?action=supdelete&supID=" + supID;
                    } else {
                        // Cancelled, no action needed
                        alert("Delete operation cancelled.");
                    }
                });
            });
        </script>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>
