<%-- 
    Document   : addUsers
    Created on : 23 Jan 2024, 12:44:29 am
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            Connection cn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String url = "jdbc:mysql://localhost:3306/fyp";
            String user = "root";
            String pass = "admin";

            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, user, pass);

            String select = "SELECT ID, firstName, role, password FROM employee";
            ps = cn.prepareStatement(select);
            rs = ps.executeQuery();

            String insert = "INSERT INTO users (username, firstName, role, password) VALUES (?,?,?,?)";
    
            while (rs.next()) {
                String username = rs.getString("ID"); // You can use any column from the employee table as the username.
                String firstName = rs.getString("firstName");
                String role = rs.getString("role");
                String password = rs.getString("password");

                // Create a new PreparedStatement for inserting data into the users table
                PreparedStatement insertPS = cn.prepareStatement(insert);
                insertPS.setString(1, username);
                insertPS.setString(2, firstName);
                insertPS.setString(3, role);
                insertPS.setString(4, password);

                // Execute the insert statement
                insertPS.executeUpdate();
        
                // Close the insert PreparedStatement
                insertPS.close();
            }

            // Close the ResultSet, PreparedStatement, and Connection
            rs.close();
            ps.close();
            cn.close();
        %>

    </body>
</html>
