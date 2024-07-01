<%-- 
    Document   : userDetails
    Created on : 15 Jan 2024, 9:30:15 am
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
        <title>User Profile</title>
        <!-- Bootstrap CSS -->
        <% String fname = (String) session.getAttribute("firstName"); %>
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
            String role= (String) session.getAttribute("role");
            %>
            <% if ("manager".equals(role)) { %>
            <jsp:include page="managerNavBar.jsp"/>
            <% } else if ("clerk".equals(role)) { %>
            <jsp:include page="clerkNavBar.jsp"/>
            <% } else { %>
            <jsp:include page="staffNavBar.jsp"/>
            <% } %>
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    USER PROFILE
                </h2>
                <hr>





                <% if ("manager".equals(role)) { %>


                <% 
                    String data= (String) session.getAttribute("username");
            
                
                    Connection cn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                
            
                    String url = "jdbc:mysql://localhost:3306/fyp";
                    String user = "root";
                    String pass = "admin";
            
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    cn = DriverManager.getConnection(url, user, pass);
                
                    String myQuery = "SELECT * FROM manager WHERE ID = ?";
                    ps = cn.prepareStatement(myQuery);
                    ps.setString(1, data);
                    rs = ps.executeQuery();
                
                
                    if (rs.next()) { %>
                <br>

                <br>
                <div class="profile-card">

                    <h3><%= rs.getString(2)%> <%= rs.getString(3)%></h3>
                    <p><strong>ID:</strong> <%= data %></p>
                    <p><strong>Role:</strong> <%= rs.getString(4)%></p>
                    <p><strong>IC Number</strong> <%= rs.getString(5)%></p>
                    <p><strong>Date Of Birth</strong> <%= rs.getString(6)%></p>
                    <p><strong>Phone No:</strong> <%= rs.getString(7)%></p>
                    <p><strong>Email:</strong> <%= rs.getString(8)%></p>
                    <p><strong>Address:</strong> <%= rs.getString(9)%></p>
                    <p><strong>Password:</strong> <%= rs.getString(10)%></p>

                    <div class="action-buttons">
                        <a href="userUpdate.jsp?">Edit</a>
                    </div>
                </div>

                <%    } else { %>
                <h1> not found </h1>
                <%  }

                  cn.close();
           
            } else if ("clerk".equals(role)) {

                    String data= (String) session.getAttribute("username");
            
                
                    Connection cn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                
            
                    String url = "jdbc:mysql://localhost:3306/fyp";
                    String user = "root";
                    String pass = "admin";
            
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    cn = DriverManager.getConnection(url, user, pass);
                
                    String myQuery = "SELECT * FROM employee WHERE ID = ?";
                    ps = cn.prepareStatement(myQuery);
                    ps.setString(1, data);
                    rs = ps.executeQuery();
                
                
                    if (rs.next()) { %>
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

                    <h3><%= rs.getString(2)%> <%= rs.getString(3)%></h3>
                    <p><strong>ID:</strong> <%= data %></p>
                    <p><strong>Role:</strong> <%= rs.getString(4)%></p>
                    <p><strong>IC Number</strong> <%= rs.getString(5)%></p>
                    <p><strong>Date Of Birth</strong> <%= rs.getString(6)%></p>
                    <p><strong>Phone No:</strong> <%= rs.getString(7)%></p>
                    <p><strong>Email:</strong> <%= rs.getString(8)%></p>
                    <p><strong>Address:</strong> <%= rs.getString(9)%></p>
                    <p><strong>Password:</strong> <%= rs.getString(10)%></p>

                    <div class="action-buttons">
                        <a href="userUpdate.jsp">Edit</a>
                    </div>
                </div>
                <%
        } else { %>
                <h1> not found </h1>
                <%  }

                  cn.close(); 
            } else { String data= (String) session.getAttribute("username");
            
                
                    Connection cn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                
            
                    String url = "jdbc:mysql://localhost:3306/fyp";
                    String user = "root";
                    String pass = "admin";
            
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    cn = DriverManager.getConnection(url, user, pass);
                
                    String myQuery = "SELECT * FROM employee WHERE ID = ?";
                    ps = cn.prepareStatement(myQuery);
                    ps.setString(1, data);
                    rs = ps.executeQuery();
                
                
                    if (rs.next()) { %>
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

                    <h3><%= rs.getString(2)%> <%= rs.getString(3)%></h3>
                    <p><strong>ID:</strong> <%= data %></p>
                    <p><strong>Role:</strong> <%= rs.getString(4)%></p>
                    <p><strong>IC Number</strong> <%= rs.getString(5)%></p>
                    <p><strong>Date Of Birth</strong> <%= rs.getString(6)%></p>
                    <p><strong>Phone No:</strong> <%= rs.getString(7)%></p>
                    <p><strong>Email:</strong> <%= rs.getString(8)%></p>
                    <p><strong>Address:</strong> <%= rs.getString(9)%></p>
                    <p><strong>Password:</strong> <%= rs.getString(10)%></p>

                    <div class="action-buttons">
                        <a href="userUpdate.jsp">Edit</a>
                    </div>
                </div>
                <%
        } else { %>
                <h1> not found </h1>
                <%  }

                  cn.close(); 
    
             } %>
                <p>&copy; 2023 Jernih Group Ent. All rights reserved.</p>
            </main>

            <br>


            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="js/scripts.js"></script>
    </body>
</html>

