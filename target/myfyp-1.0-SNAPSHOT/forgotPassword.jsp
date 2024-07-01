<%-- 
    Document   : forgotPassword
    Created on : 22 Jan 2024, 4:47:54 pm
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
    <jsp:include page="bootstrap.jsp" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <title>Login Page</title>
    <link rel="icon" href="images/Jernih.png" type="image/x-icon">
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
                                <h3>Forgot Password</h3>
                            </div>
                            <form action="" method="POST">
                                <div class="form-group first">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter username">
                                </div>
                                <div class="form-group last mb-4">
                                    <label for="password">New Password</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter new password">
                                </div>
                                <div class="form-group last mb-4">
                                    <label for="password">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirm" name="confirm" placeholder="Confirm new password">
                                </div>

                                <%
                                // Retrieve form data
                                String username = request.getParameter("username");
                                String password = request.getParameter("password");
                                String confirm = request.getParameter("confirm");

                                // Database connection variables
                                Connection cn = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;

                                String url = "jdbc:mysql://localhost:3306/fyp";
                                String user = "root";
                                String pass = "admin";

                                // Check if password and confirm password are not null and match
                                if (password != null && confirm != null && password.equals(confirm)) {
                                    try {
                                        // Load the MySQL JDBC driver
                                        Class.forName("com.mysql.cj.jdbc.Driver");

                                        // Establish the database connection
                                        cn = DriverManager.getConnection(url, user, pass);

                                        // Update password in the users table
                                        String updateUserQuery = "UPDATE users SET password = ? WHERE username = ?";
                                        ps = cn.prepareStatement(updateUserQuery);
                                        ps.setString(1, password);
                                        ps.setString(2, username);
                                        int rowsAffectedUsers = ps.executeUpdate();

                                        // Update password in the employee table
                                        String updateEmployeeQuery = "UPDATE employee SET password = ? WHERE ID = ?";
                                        ps = cn.prepareStatement(updateEmployeeQuery);
                                        ps.setString(1, password);
                                        ps.setString(2, username);  // Assuming username maps to ID in employee table
                                        int rowsAffectedEmployee = ps.executeUpdate();

                                        // Check if any rows were affected
                                        if (rowsAffectedUsers > 0 || rowsAffectedEmployee > 0) {
                                            out.println("Password updated successfully for user: " + username);
                                        } else {
                                            out.println("Failed to update password for user: " + username);
                                        }
                                    } catch (ClassNotFoundException | SQLException e) {
                                        out.println("Exception occurred: " + e.getMessage());
                                    } finally {
                                        // Close resources
                                        try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                                        try { if (ps != null) ps.close(); } catch (SQLException e) { /* ignored */ }
                                        try { if (cn != null) cn.close(); } catch (SQLException e) { /* ignored */ }
                                    }
                                } else {
                                   
                                }
                                %>
                                
                                <div class="d-flex mb-5 align-items-center">
                                    <span class="ml-auto"><a href="loginPage.jsp">Login Page</a></span>
                                </div>

                                <input type="submit" value="Confirm" class="btn btn-block btn-primary">

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

