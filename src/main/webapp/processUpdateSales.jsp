<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        /* Add any custom styles here */
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

    <!-- Content -->
    <div class="container">
        <%
            Connection conn = null;
            PreparedStatement pstmtSales = null;
            PreparedStatement pstmtSalesItems = null;

            String saleID = request.getParameter("saleID");
            String custID = request.getParameter("custID");
            String[] prodIDs = request.getParameterValues("prodID");
            String[] quantities = request.getParameterValues("quantity");
            double[] totals = new double[prodIDs.length]; // Array to store totals for each item

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                // Update sales table
                String updateSales = "UPDATE sales SET custID = ? WHERE saleID = ?";
                pstmtSales = conn.prepareStatement(updateSales);
                pstmtSales.setInt(1, Integer.parseInt(custID.trim())); // Ensure custID is not null before trimming
                pstmtSales.setInt(2, Integer.parseInt(saleID.trim())); // Ensure saleID is not null before trimming
                pstmtSales.executeUpdate();

                // Update sales_items table
                String updateSalesItems = "UPDATE sales_items SET quantity = ?, total = ? WHERE saleID = ? AND prodID = ?";
                pstmtSalesItems = conn.prepareStatement(updateSalesItems);

                // Retrieve prices and calculate totals
                for (int i = 0; i < prodIDs.length; i++) {
                    int prodID = Integer.parseInt(prodIDs[i].trim());
                    int quantity = Integer.parseInt(quantities[i].trim());

                    // Query to retrieve price of the product
                    String getPriceQuery = "SELECT price FROM products WHERE prodID = ?";
                    PreparedStatement pstmtPrice = conn.prepareStatement(getPriceQuery);
                    pstmtPrice.setInt(1, prodID);
                    ResultSet rsPrice = pstmtPrice.executeQuery();

                    if (rsPrice.next()) {
                        double price = rsPrice.getDouble("price");
                        double total = price * quantity;
                        totals[i] = total; // Store the calculated total
                        pstmtSalesItems.setInt(1, quantity);
                        pstmtSalesItems.setDouble(2, total);
                        pstmtSalesItems.setInt(3, Integer.parseInt(saleID.trim())); // Ensure saleID is not null before trimming
                        pstmtSalesItems.setInt(4, prodID);
                        pstmtSalesItems.executeUpdate();
                    }
                    rsPrice.close();
                    pstmtPrice.close();
                }
        %>
        <script>
            // JavaScript alert for success message
            window.alert("Sales updated successfully!");
            // Redirect to processSales.jsp after a short delay
            
                window.location.href = "processSales.jsp";
           
        </script>
        <% 
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <script>
            // JavaScript alert for error message
            window.alert("Error occurred: <%= e.getMessage() %>");
            // Redirect to processSales.jsp after a short delay
            
                window.location.href = "processSales.jsp";
            
        </script>
        <% 
            } finally {
                // Close resources
                try {
                    if (pstmtSales != null) pstmtSales.close();
                    if (pstmtSalesItems != null) pstmtSalesItems.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

    <!-- Footer -->
    <jsp:include page="footer.jsp"/>
</body>
</html>
