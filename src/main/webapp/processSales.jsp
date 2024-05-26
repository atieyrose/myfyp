<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Process Sales</title>
    <jsp:include page="bootstrap.jsp"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1100px;
            background-color: #ffffff;
            padding: 20px;
            margin: 20px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        h2 {
            text-align: center;
        }

        .table {
            background-color: #ffffff;
        }

        .table th {
            background-color: #999999;
            color: #ffffff;
        }

        .table td, .table th {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: center;
        }

        .table a {
            text-decoration: none;
            margin-right: 10px;
        }

        .table a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <%
    String role = (String) session.getAttribute("role");
    %>

    <% if ("manager".equals(role)) { %>
    <jsp:include page="managerNavBar.jsp"/>
    <% } else { %>
    <jsp:include page="clerkNavBar.jsp"/>
    <% } %>

    <div class="container">
        <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
            Sales List
        </h2>
        <hr>
        <% if ("manager".equals(role) || "clerk".equals(role)) { %>
        <a href="newjsp1.jsp" class="btn btn-success float-right">Add New Sales</a>
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
            String displayQuery = "SELECT * FROM sales LIMIT ?, ?";
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
            String jsonData = request.getParameter("saleListJSON");
            if (jsonData != null && !jsonData.isEmpty()) {
                // Parse JSON data
                JSONArray saleList = new JSONArray(jsonData);

                String totalAmountParam = request.getParameter("totalAmount");
                if (totalAmountParam != null) {
                    double totalAmount = Double.parseDouble(totalAmountParam);
                    out.println("Total Amount received: $" + totalAmount);

                    JSONObject firstSaleItem = saleList.getJSONObject(0);
                    int customerId = firstSaleItem.getInt("custID");
                    double a = totalAmount;

                    out.println(customerId);
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
                String display2 = "SELECT * FROM sales LIMIT ?, ?";
                pSales = c.prepareStatement(display2);
                pSales.setInt(1, offset);
                pSales.setInt(2, rowsPerPage);
                rSales = pSales.executeQuery();
            %>

            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Sale ID</th>
                        <th>Customer ID</th>
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
                        double total = rSales.getDouble("total");
                        Date date = rSales.getDate("date");
                    %>
                    <tr>
                        <td><%= saleid %></td>
                        <td><%= custid %></td>
                        <td><%= total %></td>
                        <td><%= date %></td>
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
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>
