<%-- 
    Document   : processManagerInsert
    Created on : 15 Jan 2024, 3:42:13 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String dobParameter = request.getParameter("DOB");
        System.out.println("DOB Parameter: " + dobParameter); // Debugging output

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDOB = null;
        Connection cn = null;
        PreparedStatement ps = null;

        String url = "jdbc:mysql://localhost:3306/fyp";
        String user = "root";
        String pass = "admin";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, user, pass);

            String query = "INSERT INTO manager (firstName, lastName, role, DOB, icNo, phoneNo, email, address, password) VALUES (?,?,?,?,?,?,?,?,?)";
            ps = cn.prepareStatement(query);

            java.util.Date dob = sdf.parse(dobParameter);
            formattedDOB = sdf.format(dob);
            ps.setString(1, request.getParameter("firstName"));
            ps.setString(2, request.getParameter("lastName"));
            ps.setString(3, request.getParameter("role"));
            ps.setString(4, formattedDOB);
            ps.setString(5, request.getParameter("icno"));
            ps.setString(6, request.getParameter("phoneNo"));
            ps.setString(7, request.getParameter("email"));
            ps.setString(8, request.getParameter("address"));
            ps.setString(9, request.getParameter("password"));

            int result = ps.executeUpdate();

            if (result > 0) {
        %>
        <p class="success-message">Record successfully added into the Coordinator table!</p>
        <!-- Display record details -->
        <%
            } else {
        %>
        <p class="error-message">Error: ManagerID already taken!</p>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (cn != null) {
                try { cn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        %>
    </body>
</html>

