<%-- 
    Document   : updateSales
    Created on : 1 May 2024, 10:32:14 pm
    Author     : A S U S
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Sales</title>
    <jsp:include page="bootstrap.jsp"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        /* Add your custom CSS styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <!-- Header -->
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
        <h2>Update Sale Details</h2>

        <% 
            // Get the saleID parameter from the request
            String saleIDParam = request.getParameter("saleID");

            // Check if saleID parameter is present
            if (saleIDParam != null) {
                // Parse saleID to an integer
                int saleID = Integer.parseInt(saleIDParam);

                // Fetch sale details from the database using saleID
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Establish database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                    // Prepare SQL query to fetch sale details including sales items
                    String sql = "SELECT s.custID, si.prodID, si.quantity " +
                                 "FROM sales s " +
                                 "JOIN sales_items si ON s.saleID = si.saleID " +
                                 "WHERE s.saleID = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, saleID);

                    // Execute query
                    rs = pstmt.executeQuery();

                    // Check if result set has data
                    if (rs.next()) {
                        // Retrieve custID from result set (it will be the same for all rows)
                        int custID = rs.getInt("custID");
        %>
        <p><%= saleID %></p>
        <form action="processUpdateSales.jsp" method="post" class="form-inline">
            <input type="hidden" name="saleID" value="<%= saleID %>">
            <div class="form-group mx-2">
                <label for="custID">Customer ID:</label>
                <input type="text" class="form-control" id="custID" name="custID" value="<%= custID %>">
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Quantity</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Loop through the sales items
                        do {
                            // Retrieve data from result set for each sales item
                            int prodID = rs.getInt("prodID");
                            int quantity = rs.getInt("quantity");
                    %>
                    <tr>
                        <td><input type="text" class="form-control" name="prodID" value="<%= prodID %>"></td>
                        <td><input type="text" class="form-control" name="quantity" value="<%= quantity %>"></td>
                    </tr>
                    <% 
                        // Close the do-while loop
                        } while (rs.next());
                    %>
                </tbody>
            </table>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
        <% 
                    } else {
                        // Sale not found
                        out.println("<p>Error: Sale ID " + saleID + " not found.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                // Sale ID parameter not provided
                out.println("<p>Error: Sale ID parameter not provided.</p>");
            }
        %>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>
