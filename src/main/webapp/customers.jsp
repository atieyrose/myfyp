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
        <title>Add New Customer</title>
        <link rel="icon" href="images/Jernih.png" type="image/x-icon">
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

            .fieldset-spacing {
                margin-bottom: 10px; /* Adjust the value as needed */
            }

            .input-size {
                width: 1000px; /* Adjust the width as needed */
            }
            table.form-table {
                width: 30%;
                border-collapse: collapse;
            }
            table.form-table td {
                width: 20%;
                padding: 10px;
                font-size: 1em;
            }
            table.form-table input,
            table.form-table select,
            table.form-table button {
                width: 500%;
                box-sizing: border-box;
                font-size: 1em;
                height: 30px;
            }
            /* Horizontal Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
            }
            .page-item {
                margin: 0 5px;
            }
            .page-link {
                display: block;
                padding: 10px 15px;
                text-decoration: none;
                color: #333;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            .page-link:hover {
                background-color: #f1f1f1;
                color: #333;
            }
            .page-item.active .page-link {
                background-color: #333;
                color: #fff;
            }
            .page-item.disabled .page-link {
                color: #ddd;
                pointer-events: none;
            }
            .enhanced-button {
                display: inline-block;
                padding: 15px 20px;
                font-size: 15px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #fff;
                background: #28a745;
                border: none;
                border-radius: 10px;
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
                <c:if test="${customers == null}">
                    <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                        Add New Customers
                    </h2>
                </c:if>

                <c:if test="${customers != null}">
                    <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                        Update Customers
                    </h2>
                </c:if>
                <hr>

                <div class="container col-md-5">
                    <div class="card">
                        <div class="card-body">

                            <c:if test="${customers != null}">
                                <form action="customersServlet" method="post">
                                    <input type="hidden" name="action" value="custupdate"><!-- comment -->

                                </c:if>

                                <c:if test="${customers == null}">
                                    <form action="customersServlet" method="post">
                                        <input type="hidden" name="action" value="custinsert"><!-- comment -->

                                    </c:if>

                                    <h3>
                                        <c:if test="${customers == null}">
                                            Add New Customer
                                        </c:if>
                                        <c:if test="${customers != null}">
                                            Update Customer
                                        </c:if>
                                    </h3>


                                    <c:if test="${customers != null}">
                                        <input type="hidden" name="custID" value="<c:out value='${customers.custID}'/>" />
                                    </c:if>

                                    <table class="form-table">
                                        <tr>
                                            <td><label>First Name</label></td>
                                            <td><input type="text" value="<c:out value='${customers.firstName}'/>" class="form-control input-size" name="firstName" placeholder="Enter First Name" required="required"></td>
                                        </tr>

                                        <tr>
                                            <td><label>Last Name</label></td>
                                            <td><input type="text" value="<c:out value='${customers.lastName}'/>" class="form-control input-size" name="lastName" placeholder="Enter Last Name" required="required"></td>
                                        </tr>

                                        <tr>
                                            <td><label>Phone Number</label></td>
                                            <td><input type="text" value="<c:out value='${customers.phoneNo}'/>" class="form-control input-size" name="phoneNo" placeholder="Enter Phone Number" required="required"></td>
                                        </tr>

                                        <tr>
                                            <td><label>Email</label></td>
                                            <td><input type="email" value="<c:out value='${customers.email}'/>" class="form-control input-size" name="email" placeholder="Enter Email" required="required"></td>
                                        </tr>

                                        <tr>
                                            <td><label>Address</label></td>
                                            <td><input type="text" value="<c:out value='${customers.address}'/>" class="form-control input-size" name="address" placeholder="Enter Address" required="required"></td>
                                        </tr>

                                    </table>
                                    <button type="submit" class="enhanced-button">Save</button>
                                </form>

                        </div>
                    </div>
                </div>
                <p>&copy; 2023 Jernih Group Ent. All rights reserved.</p>
            </main>

            <br>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="js/scripts.js"></script>
    </body>
</html>
