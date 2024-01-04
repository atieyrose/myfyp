<%-- 
    Document   : loginPage
    Created on : 23 Dec 2023, 8:35:58 pm
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
        <jsp:include page="bootstrap.jsp" />
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <title>Login Page</title>
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <br><br>
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <img src="images/Jernih.png" alt="Image" class="img-fluid">
                    </div>

                    <div class="col-md-6 contents">
                        <br><br>
                        <div class="row justify-content-center">
                            <div class="col-md-8">
                                <div class="mb-4">
                                    <h3>Log In</h3>
                                </div>
                                <form action="" method="POST">
                                    <div class="form-group first">
                                        <label for="username">Username</label>
                                        <input type="text" class="form-control" id="username" name="username">

                                    </div>
                                    <div class="form-group last mb-4">
                                        <label for="password">Password</label>
                                        <input type="password" class="form-control" id="password" name="password">

                                    </div>
                                    <%
                                        if (request.getMethod().equalsIgnoreCase("POST")) {
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
                                        
                                        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
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
                                        cn.close();
                                        } catch (ClassNotFoundException | SQLException e) {
                                        e.printStackTrace();
                                        response.sendRedirect("loginPage.jsp");
                                        } 
                                        }
                                        
                                        session.setAttribute("username", request.getParameter("username"));
                                    %>

                                    <div class="d-flex mb-5 align-items-center">
                                        <label class="control control--checkbox mb-0"><span class="caption">Remember me</span>
                                            <input type="checkbox" checked="checked"/>
                                            <div class="control__indicator"></div>
                                        </label>
                                        <span class="ml-auto"><a href="#" class="forgot-pass">Forgot Password</a></span> 
                                    </div>

                                    <input type="submit" value="Log In" class="btn btn-block btn-primary">

                                </form>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <br><br>

        <jsp:include page="footer.jsp" />

        <!-- Bootstrap JS and Popper.js (required for Bootstrap JavaScript plugins) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>
