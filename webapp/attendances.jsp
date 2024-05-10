<%-- 
    Document   : attendances
    Created on : 8 May 2024, 9:37:42 pm
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendances</title>
</head>
<body>
    <%
        // Retrieve the UID parameter from the request
        String uid = request.getParameter("UID");

        // Process the UID as needed
        if (uid != null) {
            // Do something with the UID
            System.out.println("Received UID: " + uid);
            // Here, you can save the UID to a database, perform some actions, etc.
        } else {
            // Handle case where no UID is provided
            System.out.println("No UID received");
        }

    
                Connection c = null;
                PreparedStatement p = null;
                ResultSet r = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                    // Debug statement to check if the database connection is successful
                    if (c != null) {
                        out.println("<p> Database connection successful! </p>");
                    } else {
                        out.println("<p> Database connection failed! </p>");
                    }
                    
                    String att = "INSERT INTO attendances (UID) VALUES (?)";
                    p = c.prepareStatement(att);
                    p.setInt(1, Integer.parseInt(uid));
                    int result = p.executeUpdate();
                    
                    if (result > 0 ) {
                    %>
        <p class="success-message">Record successfully added !</p>
        <!-- Display record details -->
        <%
        } else {
        %>
        <p class="error-message">Error: No !</p>
        <%
            }

        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (c != null) {
                try { c.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
                %>
                
    <h1>Update Sensor</h1>
    <p>Received UID: <%= uid != null ? uid : "No UID received" %></p>
    

</body>
</html>

