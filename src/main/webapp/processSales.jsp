<%-- 
    Document   : salesList
    Created on : 22 Dec 2023, 5:39:18 pm
    Author     : A S U S
--%>

<%-- 
    Document   : salesList
    Created on : 22 Dec 2023, 5:39:18 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import= "java.text.ParseException" %>
<%@ page import= "java.util.Date" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sales List</title>
        <link rel="icon" href="images/Jernih.png" type="image/x-icon">
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
                    Sales List
                </h2>
                <hr>

                <% 
                if ("manager".equals(role) || "clerk".equals(role)) { 
                %>
                <button class="enhanced-button" onclick="window.location.href = 'sales.jsp'">Add New Sale</button>
                <% } %>
                <br><br>

                <%
                Connection c = null;
                PreparedStatement pSales = null;
                PreparedStatement pSalesItems = null;
                ResultSet rSales = null;

                int rowsPerPage = 15; // Number of rows per page
                int currentPage = 1; // Default current page
                int totalRows = 0; // Total number of rows
                int totalPages = 0; // Total number of pages

                // Get current page from request parameter
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    currentPage = Integer.parseInt(pageStr);
                }

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                    // Count total number of rows
                    String countQuery = "SELECT COUNT(*) FROM sales";
                    Statement countStatement = c.createStatement();
                    ResultSet countResult = countStatement.executeQuery(countQuery);
                    if (countResult.next()) {
                        totalRows = countResult.getInt(1);
                    }

                    // Calculate total number of pages
                    totalPages = (int) Math.ceil((double) totalRows / rowsPerPage);

                    // Close resources
                    countResult.close();
                    countStatement.close();

                    // Pagination logic
                    int offset = (currentPage - 1) * rowsPerPage; // Offset for current page
                    String displayQuery = "SELECT s.saleID, s.custID, s.total, s.date, c.firstName, c.lastName FROM sales s JOIN customers c ON s.custID = c.custID ORDER BY s.saleID DESC LIMIT ?, ?";
                    pSales = c.prepareStatement(displayQuery);
                    pSales.setInt(1, offset);
                    pSales.setInt(2, rowsPerPage);
                    rSales = pSales.executeQuery();

                    // Start transaction
                    c.setAutoCommit(false);

                    // Debug statement to check if the database connection is successful
//                    if (c != null) {
//                        out.println("<p> Database connection successful! </p>");
//                    } else {
//                        out.println("<p> Database connection failed! </p>");
//                    }

                    // Get JSON data from request parameter
                    String jsonData = request.getParameter("saleListJSON");
                    if (jsonData != null && !jsonData.isEmpty()) {
                        // Parse JSON data
                        JSONArray saleList = new JSONArray(jsonData);

                        String totalAmountParam = request.getParameter("totalAmount");
                        if (totalAmountParam != null) {
                            double totalAmount = Double.parseDouble(totalAmountParam);
//                            out.println("Total Amount received: $" + totalAmount);

                            JSONObject firstSaleItem = saleList.getJSONObject(0);
                            int customerId = firstSaleItem.getInt("custID");
                            double a = totalAmount;

//                            out.println(customerId);
                            // Insert sales data into the sales table
                            String insertSales = "INSERT INTO sales (custID, total, date) VALUES (?, ?, CURDATE())";
                            pSales = c.prepareStatement(insertSales, Statement.RETURN_GENERATED_KEYS);
                            pSales.setInt(1, customerId);
                            pSales.setDouble(2, a);
                            pSales.executeUpdate();

                            // Retrieve the generated sale ID
                            rSales = pSales.getGeneratedKeys();
                            int saleID = 0;
                            if (rSales.next()) {
                                saleID = rSales.getInt(1);
                            }

                            // Insert each sale item into the sales_items table
                            String insertSaleItems = "INSERT INTO sales_items (saleID, prodID, quantity, total) VALUES (?, ?, ?, ?)";
                            pSalesItems = c.prepareStatement(insertSaleItems);
                            for (int i = 0; i < saleList.length(); i++) {
                                JSONObject saleItem = saleList.getJSONObject(i);

                                // Get sale item details
                                int productId = saleItem.getInt("prodID");
                                int quantity = saleItem.getInt("quantity");
                                double amount = saleItem.getDouble("amount");

                                // Set parameters for the sales_items insert statement
                                pSalesItems.setInt(1, saleID);
                                pSalesItems.setInt(2, productId);
                                pSalesItems.setInt(3, quantity);
                                pSalesItems.setDouble(4, amount);

                                // Execute the insert statement for sales_items
                                pSalesItems.executeUpdate();
                            }

                            // Commit the transaction
                            c.commit();
                        }
                    }

                %>
                <div class="center-table">
                    <%
                    try {
                       String display2 = "SELECT s.saleID, s.custID, s.total, s.date, c.firstName, c.lastName FROM sales s JOIN customers c ON s.custID = c.custID ORDER BY s.date DESC LIMIT ?, ?";

                        pSales = c.prepareStatement(display2);
                        pSales.setInt(1, offset);
                        pSales.setInt(2, rowsPerPage);
                        rSales = pSales.executeQuery();
                    %>

                    <table class="table table-striped table-bordered">
                        <thead class="thead-dark">
                            <tr>

                                <th>Customer Name</th>
                                <th>Total</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            while (rSales.next()) {
                                int saleid = rSales.getInt("saleID");
                                int custid = rSales.getInt("custID");
                                String custName = rSales.getString("firstName");
                                String custLast = rSales.getString("lastName");
                                double total = rSales.getDouble("total");
                                Date date = rSales.getDate("date");
                              

                            // Define the new format
                            SimpleDateFormat newFormat = new SimpleDateFormat("dd-MM-yyyy");

                            // Format the Date object to the new format
                            String newDateStr = newFormat.format(date);
                            %>
                            <tr>

                                <td><%= custName %> <%= custLast %></td>
                                <td>RM<%= total %></td>
                                <td><%= newDateStr %></td>
                                <td><a href="salesDetails.jsp?saleID=<%= saleid %>&custID=<%= custid %>">Details</a></td>

                            </tr>
                            <% } %>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                                <a class="page-link" href="?page=<%= currentPage - 1 %>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <% for (int i = 1; i <= totalPages; i++) { %>
                            <li class="page-item <%= currentPage == i ? "active" : "" %>">
                                <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                            </li>
                            <% } %>
                            <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                                <a class="page-link" href="?page=<%= currentPage + 1 %>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
                <% 
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p>Error occurred while displaying sales: " + e.getMessage() + "</p>");
                    }
                %>

                <% 
                } catch (Exception e) {
                    // Rollback the transaction in case of any exceptions
                    if (c != null) {
                        try {
                            c.rollback();
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                    // Handle any exceptions
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources (Connection, PreparedStatement, ResultSet) in the finally block
                    if (rSales != null) {
                        try {
                            rSales.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (pSales != null) {
                        try {
                            pSales.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (pSalesItems != null) {
                        try {
                            pSalesItems.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (c != null) {
                        try {
                            c.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
                %>
                <p>&copy; 2023 Jernih Group Ent. All rights reserved.</p>
            </main>
        </div>

        <!-- Custom JS -->
        <script src="js/scripts.js"></script>
    </body>
</html>
