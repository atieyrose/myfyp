<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Process Sales</title>
    <jsp:include page="bootstrap.jsp"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        /* Add any custom styles here */
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <h2>Processing Sales</h2>

    <%
        Connection c= null;
        PreparedStatement p=null;
        ResultSet r=null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

            // Debug statement to check if the database connection is successful
            if (c != null) {
    %> <p> Database connection successful! </p><!-- comment -->
    <p>hello <%= request.getParameter("customerDropdown") %> </p>
    <%
        } else {
    %> 
    %> <p> Database connection failed! </p><!-- comment -->
    <%
        }

            // Get parameters from the form
            String[] itemIds = request.getParameterValues("itemId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] amounts = request.getParameterValues("amount[]");
            int customerId = Integer.parseInt(request.getParameter("customerDropdown"));

            // Insert each item into the database
            for (int i = 0; i < itemIds.length; i++) {
                String insert = "INSERT INTO sales (custID, prodID, quantity, total, date) VALUES (?, ?, ?, ?, CURDATE())";
                p = c.prepareStatement(insert);
                p.setInt(1, customerId);
                p.setInt(2, Integer.parseInt(itemIds[i]));
                p.setInt(3, Integer.parseInt(quantities[i]));
                p.setDouble(4, Double.parseDouble(amounts[i]));

                int rr = p.executeUpdate();
            }
        } catch (Exception e) {
            // Handle any exceptions
            e.printStackTrace();
        } finally {
            // Close resources (Connection, PreparedStatement, ResultSet) in the finally block
            // This ensures that resources are closed even if an exception occurs
            // Close PreparedStatement
            if (p != null) {
                try {
                    p.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            // Close Connection
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
