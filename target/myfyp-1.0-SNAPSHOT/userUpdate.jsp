<%-- 
    Document   : userUpdate
    Created on : 18 Jan 2024, 12:02:09 am
    Author     : A S U S
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Profile</title>
        <!-- Bootstrap CSS -->
        <% String firstname = (String) session.getAttribute("firstName"); %>
        <!-- Montserrat Font -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        <!-- Custom Styles -->
        <link rel="stylesheet" href="css/styles.css">
        <style>
            body {
                font-family: 'Montserrat', sans-serif;
            }
           .profile-card {
                background-color: #f5f5f5;
                border: 1px solid #ccc;
                border-radius: 10px;
                padding: 20px;
                text-align: center;
                width: 500px;
                margin: 0 auto;
            }

            .profile-card h3 {
                font-size: 24px;
                color: #333;
            }

            .profile-card p {
                font-size: 16px;
                margin: 10px 0;
                text-align: left; /* Added this line to left-align the text in <p> elements */
            }

            .action-buttons {
                margin-top: 20px;
            }

            .action-buttons a {
                text-decoration: none;
                background-color: #007bff;
                color: #fff;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 18px;
            }
        </style>
    </head>
    <body>
        <div class="grid-container">
            <!-- Header -->
            <header class="header">
                <h2>JERNIH TILING ENT</h2>
            </header>
            <!-- End Header -->

            
            <!-- Sidebar -->
            <%
            String r= (String) session.getAttribute("role");
            %>
            <% if ("manager".equals(r)) { %>
            <jsp:include page="managerNavBar.jsp"/>
            <% } else { %>
            <jsp:include page="clerkNavBar.jsp"/>
            <% } %>
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Update Profile
                </h2>
                <hr>

               

                
         <% if ("manager".equals(r)) { %>


        <% 
            String data= (String) session.getAttribute("username");
            
                
            Connection cn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
                
            
            String url = "jdbc:mysql://localhost:3306/fyp";
            String user = "root";
            String pass = "admin";
            
            try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, user, pass);
                
            String myQuery = "SELECT * FROM manager WHERE ID = ?";
            ps = cn.prepareStatement(myQuery);
            ps.setString(1, data);
            rs = ps.executeQuery();
                
            
            if (rs.next()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String dobParameter = request.getParameter("DOB");
            
                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String role = rs.getString("role");
                String icno = rs.getString("icno");
                String dob = rs.getString("DOB");
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");
                String address = rs.getString("address");
                String password = rs.getString("password");
                
                
        %>
        <br>

        <h2 style="font-family: 'Arial', sans-serif;
            color: #333;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: bold;">
        </h2>
        <br>
        <div class="profile-card">
            <form method="POST" action="processUserUpdate.jsp">
                <h2>Update Details</h2>
                <input type="hidden" name="ID" value="<%= data %>">
                <p><strong>First Name:</strong> <input type="text" name="firstName" value="<%= fname %>"><br></p>
                <p><strong>Last Name:</strong> <input type="text" name="lastName" value="<%= lname %>"><br></p>
                <p><strong>Role:</strong> <input type="text" name="role" value="<%= role %>"><br><!-- comment --></p>
                <p><strong>IC Number:</strong> <input type="text" name="icno" value="<%= icno %>"><br><!-- comment --></p>
                <p><strong>Date Of Birth:</strong> <input type="date" name="DOB" value="<%= dob %>"><br><!-- comment --></p>
                <p><strong>Phone Number</strong> <input type="text" name="phoneNo" value="<%= phoneno%>"><br><!-- comment --></p>
                <p><strong>Email: </strong> <input type="text" name="email" value="<%= email %>"><br><!-- comment --></p>
                <p><strong>Address: </strong><input type="text" name="address" value="<%= address%>"><br></p>
                <p><strong>password: </strong> <input type="password"  name="password" value="<%= password%>"></p>

                <!-- Add other fields here -->
                <div class="action-buttons">
                    <input type="submit" class="btn btn-primary" value="Update">

                </div>
            </form>
        </div>

        <%    } else { 
            response.sendRedirect("userDetails.jsp");
        %>

        <%    }
              } catch (SQLException e) {
                  e.printStackTrace();
                  response.sendRedirect("userDetails.jsp"); 
            } finally {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (cn != null) {
            cn.close();
        }
}
           
    } else {

            String data= (String) session.getAttribute("username");
            
                
            Connection cn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
                
            
            String url = "jdbc:mysql://localhost:3306/fyp";
            String user = "root";
            String pass = "admin";
            
            try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection(url, user, pass);
                
            String myQuery = "SELECT * FROM employee WHERE ID = ?";
            ps = cn.prepareStatement(myQuery);
            ps.setString(1, data);
            rs = ps.executeQuery();
                
            
            if (rs.next()) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String dobParameter = request.getParameter("DOB");

                String fname = rs.getString("firstName");
                String lname = rs.getString("lastName");
                String role = rs.getString("role");
                String icno = rs.getString("icNo");
                String dob = rs.getString("DOB");
                String phoneno = rs.getString("phoneNo");
                String email = rs.getString("email");
                String address = rs.getString("address");
                String password = rs.getString("password");
                
                
        %>
        <br>

        <h2 style="font-family: 'Arial', sans-serif;
            color: #333;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: bold;">
            MY PROFILE
        </h2>
        <br>
        <div class="profile-card">
            <form method="POST" action="processUserUpdate.jsp">
                <h2>Update Details</h2>
                <input type="hidden" name="ID" value="<%= data %>">
                <p><strong>First Name:</strong> <input type="text" name="firstName" value="<%= fname %>"><br></p>
                <p><strong>Last Name:</strong> <input type="text" name="lastName" value="<%= lname %>"><br></p>
                <p><strong>Role:</strong> <input type="text" name="role" value="<%= role %>"><br><!-- comment --></p>
                <p><strong>IC Number:</strong> <input type="text" name="icno" value="<%= icno %>"><br><!-- comment --></p>
                <p><strong>Date Of Birth:</strong> <input type="text" name="DOB" value="<%= dob %>"><br><!-- comment --></p>
                <p><strong>Phone Number</strong> <input type="text" name="phoneNo" value="<%= phoneno%>"><br><!-- comment --></p>
                <p><strong>Email: </strong> <input type="text" name="email" value="<%= email %>"><br><!-- comment --></p>
                <p><strong>Address: </strong><input type="text" name="address" value="<%= address%>"><br></p>
                <p><strong>password: </strong> <input type="password"  name="password" value="<%= password%>"></p>

                <!-- Add other fields here -->
                <div class="action-buttons">
                    <input type="submit" class="btn btn-primary" value="Update">

                </div>
            </form>
        </div>

        <%    } else { 
            response.sendRedirect("userDetails.jsp");
        %>

        <%    }
              } catch (SQLException e) {
                  e.printStackTrace();
                  response.sendRedirect("userDetails.jsp"); 
            } finally {
        if (rs != null) {
            rs.close();
        }
        if (ps != null) {
            ps.close();
        }
        if (cn != null) {
            cn.close();
        }
}
    }%>
            </main>

            <br>
          

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="js/scripts.js"></script>
    </body>
</html>

