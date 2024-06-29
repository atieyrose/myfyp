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
    <title>Expenses List</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
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
    <header class="header">
        <h2>JERNIH TILING ENT</h2>
    </header>

    <% String role= (String) session.getAttribute("role"); %>
    <% if ("manager".equals(role)) { %>
        <jsp:include page="managerNavBar.jsp"/>
    <% } else { %>
        <jsp:include page="clerkNavBar.jsp"/>
    <% } %>

    <main class="main-container">
        <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
            Expenses List
        </h2>
        <hr>

        <% if ("manager".equals(role) || "clerk".equals(role)) { %>
          <button class="enhanced-button" onclick="window.location.href = 'expenses.jsp'">Add New Expense</button>
        <% } %>
        <br><br>

        <% 
        Connection c = null;
        PreparedStatement pSales = null;
        PreparedStatement pSalesItems = null;
        ResultSet rSales = null;

        int rowsPerPage = 15; 
        int currentPage = 1; 
        int totalRows = 0; 
        int totalPages = 0; 

        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

            String countQuery = "SELECT COUNT(*) FROM expenses";
            Statement countStatement = c.createStatement();
            ResultSet countResult = countStatement.executeQuery(countQuery);
            if (countResult.next()) {
                totalRows = countResult.getInt(1);
            }

            totalPages = (int) Math.ceil((double) totalRows / rowsPerPage);

            countResult.close();
            countStatement.close();

            int offset = (currentPage - 1) * rowsPerPage; 
            String displayQuery = "SELECT * FROM expenses LIMIT ?, ?";
            pSales = c.prepareStatement(displayQuery);
            pSales.setInt(1, offset);
            pSales.setInt(2, rowsPerPage);
            rSales = pSales.executeQuery();

            c.setAutoCommit(false);

            if (c != null) {
                out.println("<p> Database connection successful! </p>");
            } else {
                out.println("<p> Database connection failed! </p>");
            }

            String jsonData = request.getParameter("expenseListJSON");
            if (jsonData != null && !jsonData.isEmpty()) {
                JSONArray expenseList = new JSONArray(jsonData);

                String totalAmountParam = request.getParameter("totalAmount");
                if (totalAmountParam != null) {
                    double totalAmount = Double.parseDouble(totalAmountParam);
                    out.println("Total Amount received: $" + totalAmount);

                    JSONObject firstExpenseItem = expenseList.getJSONObject(0);
                    int supplierId = firstExpenseItem.getInt("supID");
                    String cat = request.getParameter("expenseCategory");
                    double a = totalAmount;

                    out.println("Category: " + cat); // Debugging output

                    String insertExpense = "INSERT INTO expenses (supID, category, total, date) VALUES (?, ?, ?, CURDATE())";
                    pSales = c.prepareStatement(insertExpense, Statement.RETURN_GENERATED_KEYS);
                    pSales.setInt(1, supplierId);
                    pSales.setString(2, cat); // Set category parameter correctly
                    pSales.setDouble(3, a);
                    pSales.executeUpdate();

                    rSales = pSales.getGeneratedKeys();
                    int expenseID = 0;
                    if (rSales.next()) {
                        expenseID = rSales.getInt(1);
                    }

                    String insertExpenseItems = "INSERT INTO expenses_items (expID, prodID, quantity, total) VALUES (?, ?, ?, ?)";
                    pSalesItems = c.prepareStatement(insertExpenseItems);
                    for (int i = 0; i < expenseList.length(); i++) {
                        JSONObject expenseItem = expenseList.getJSONObject(i);

                        int productId = expenseItem.getInt("prodID");
                        int quantity = expenseItem.getInt("quantity");
                        double amount = expenseItem.getDouble("amount");

                        pSalesItems.setInt(1, expenseID);
                        pSalesItems.setInt(2, productId);
                        pSalesItems.setInt(3, quantity);
                        pSalesItems.setDouble(4, amount);

                        pSalesItems.executeUpdate();
                    }

                    c.commit();
                } 
            } 

            String display2 = "SELECT e.*, s.supName " +
                  "FROM expenses e " +
                  "JOIN suppliers s ON e.supID = s.supID " +
                  "ORDER BY e.expID DESC LIMIT ?, ?";
            pSales = c.prepareStatement(display2);
            pSales.setInt(1, offset);
            pSales.setInt(2, rowsPerPage);
            rSales = pSales.executeQuery();
        %>

        <div class="center-table">
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                 
                        <th>Supplier Name</th>
                        <th>Category</th>
                        <th>Total</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% while (rSales.next()) {
                        int expid = rSales.getInt("expID");
                        String supname = rSales.getString("supName");
                        int supid = rSales.getInt("supID");
                        String category = rSales.getString("category");
                        double total = rSales.getDouble("total");
                        Date date = rSales.getDate("date");
                    %>
                    <tr>
                    
                        <td><%= supname %></td>
                        <td><%= category %></td>
                        <td><%= total %></td>
                        <td><%= date %></td>
                        <td><a href="expenseDetails.jsp?expenseID=<%= expid %>&supID=<%= supid %>">Details</a></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

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
        } catch (Exception e) {
            if (c != null) {
                try {
                    c.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            out.println("<p>Error occurred: " + e.getMessage() + "</p>");
        } finally {
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
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>
