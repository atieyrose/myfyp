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
        String role= (String) session.getAttribute("role");
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
            <% 
            if ("manager".equals(role) || "clerk".equals(role)) { 
            %>
            <a href="newjsp1.jsp" class="btn btn-success float-right">Add New Sales</a>
            <% } else { 
                } %>
                <br><br>
      

            <%

                Connection c = null;
                PreparedStatement pSales = null;
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
                    String display = "SELECT * FROM sales LIMIT ?, ?";
                    pSales = c.prepareStatement(display);
                    pSales.setInt(1, offset);
                    pSales.setInt(2, rowsPerPage);
                    rSales = pSales.executeQuery();

            %>

            <div class="center-table">
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
                    <%
                        while (rSales.next()) {
                            int saleid = rSales.getInt("saleID");
                            int custid = rSales.getInt("custID");
                            double total = rSales.getDouble("total");
                            Date date = rSales.getDate("date");
                    %>
                    <tbody>
                        <tr>
                            <td><%= saleid %></td>
                            <td><%= custid %></td>
                            <td><%= total %></td>
                            <td><%= date %></td>
                            <td><a href="salesDetails.jsp?saleID=<%= saleid %>&custID=<%= custid %>">Details</a></td>


                        </tr>
                    </tbody>

                    <%
                        }
                    %>
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
                        <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                            <a class="page-link" href="?page=<%= currentPage + 1 %>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

            <%
                } catch (Exception e) {
                    // Handle any exceptions
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources in the finally block
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