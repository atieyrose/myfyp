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
        <title>Dashboard</title>
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
    <% } else { %>
    <jsp:include page="clerkNavBar.jsp"/>
    <% } %>
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
               <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Expenses List
                </h2>
            <hr>
            
            <% 
                if ("manager".equals(role) || "clerk".equals(role)) { 
                %>
                <a href="suppliersServlet?action=supnew" class="btn btn-success float-right">Add New Supplier</a>
                <% } else { 
                } %>
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
            String countQuery = "SELECT COUNT(*) FROM expenses";
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
            String displayQuery = "SELECT * FROM expenses LIMIT ?, ?";
            pSales = c.prepareStatement(displayQuery);
            pSales.setInt(1, offset);
            pSales.setInt(2, rowsPerPage);
            rSales = pSales.executeQuery();

            // Start transaction
            c.setAutoCommit(false);

            // Debug statement to check if the database connection is successful
            if (c != null) {
                out.println("<p> Database connection successful! </p>");
            } else {
                out.println("<p> Database connection failed! </p>");
            }

            // Get JSON data from request parameter
            String jsonData = request.getParameter("expenseListJSON");
            if (jsonData != null && !jsonData.isEmpty()) {
                // Parse JSON data
                JSONArray expenseList = new JSONArray(jsonData);

                String totalAmountParam = request.getParameter("totalAmount");
                if (totalAmountParam != null) {
                    double totalAmount = Double.parseDouble(totalAmountParam);
                    out.println("Total Amount received: $" + totalAmount);

                    JSONObject firstExpenseItem = expenseList.getJSONObject(0);
                    int supplierId = firstExpenseItem.getInt("supID");
                    String cat = request.getParameter("expenseCategory");
                    double a = totalAmount;

                    out.println(supplierId);
                    // Insert sales data into the sales table
                    String insertExpense = "INSERT INTO expenses (supID, category, total, date) VALUES (?, ?, ?, CURDATE())";
                    pSales = c.prepareStatement(insertExpense, Statement.RETURN_GENERATED_KEYS);
                    pSales.setInt(1, supplierId);
                    pSales.setString(2, cat);
                    pSales.setDouble(3, a);
                    pSales.executeUpdate();

                    // Retrieve the generated sale ID
                    rSales = pSales.getGeneratedKeys();
                    int expenseID = 0;
                    if (rSales.next()) {
                        expenseID = rSales.getInt(1);
                    }

                    // Insert each sale item into the sales_items table
                    String insertExpenseItems = "INSERT INTO expenses_items (expenseID, prodID, quantity, total) VALUES (?, ?, ?, ?)";
                    pSalesItems = c.prepareStatement(insertExpenseItems);
                    for (int i = 0; i < expenseList.length(); i++) {
                        JSONObject expenseItem = expenseList.getJSONObject(i);

                        // Get sale item details
                        int productId = expenseItem.getInt("prodID");
                        int quantity = expenseItem.getInt("quantity");
                        double amount = expenseItem.getDouble("amount");

                        // Set parameters for the sales_items insert statement
                        pSalesItems.setInt(1, expenseID);
                        pSalesItems.setInt(2, productId);
                        pSalesItems.setInt(3, quantity);
                        pSalesItems.setDouble(4, amount);

                        // Execute the insert statement for sales_items
                        pSalesItems.executeUpdate();
                    }

                    // Commit the transaction
                    c.commit();
                    //out.println("<p>Sales and sale items inserted successfully!</p>");
                } else {
                    //out.println("Total Amount parameter is null.");
                }
            } else {
                //out.println("JSON data is null or empty.");
            }

        %>

        <div class="center-table">
            <%
            try {
                String display2 = "SELECT * FROM expenses LIMIT ?, ?";
                pSales = c.prepareStatement(display2);
                pSales.setInt(1, offset);
                pSales.setInt(2, rowsPerPage);
                rSales = pSales.executeQuery();
            %>

            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Expenses ID</th>
                        <th>Supplier ID</th>
                        <th>Category</th>
                        <th>Total</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    while (rSales.next()) {
                        int expid = rSales.getInt("expID");
                        int supid = rSales.getInt("supID");
                        String category = rSales.getString("category");
                        double total = rSales.getDouble("total");
                        Date date = rSales.getDate("date");
                    %>
                    <tr>
                        <td><%= expid %></td>
                        <td><%= supid %></td>
                        <td><%= category %></td>
                        <td><%= total %></td>
                        <td><%= date %></td>
                        <td><a href="expenseDetails.jsp?expenseID=<%= expid %>&supID=<%= supid %>">Details</a></td>

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


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>
