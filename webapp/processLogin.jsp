<%-- 
    Document   : processLogin
    Created on : 27 Dec 2023, 2:32:14 am
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Process Login</title>
    </head>
    <body>
        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            Connection cn = null;
            PreparedStatement ps = null;
            
            ResultSet rs = null;
            
            
            String url = "jdbc:mysql://localhost:3306/fyp";
            String user = "root";
            String pass = "admin";
            
            try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, user, pass);
            
            String query = "SELECT * FROM users WHERE user = ? AND password = ?";
            ps = cn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
            String role = rs.getString("role");
            
            if ("manager".equals(role)) {
            String fname = rs.getString("firstName");
            session.setAttribute("username", username);
            session.setAttribute("firstName", fname);
            response.sendRedirect("managerDashboard.jsp");
            
            } else if ("clerk".equals(role)) {
            String fname = rs.getString("firstName");
            session.setAttribute("username", username);
            session.setAttribute("firstName", fname);
            response.sendRedirect("clerkDashboard.jsp");
            
            } else {
            // If validation is unsuccessful for both employee and manager, redirect to login.jsp with error message
                        response.sendRedirect("loginPage.jsp?error=1");
            
            }
            }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("loginPage.jsp");
            } finally {
            try {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (cn != null) {
            cn.close();
        }
    } catch (SQLException e) {
        // Handle the exception
    }
            }
            session.setAttribute("username", request.getParameter("username"));
        %>
    </body>
</html>
