<%-- 
    Document   : userDetails
    Created on : 15 Jan 2024, 9:30:15 am
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
        <style>
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

        <%
        String role= (String) session.getAttribute("role");
        %>

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
        <jsp:include page="header.jsp"/>
        <jsp:include page="managerNavBar.jsp"/>
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
        <jsp:include page="header.jsp"/>
        <jsp:include page="clerkNavBar.jsp"/>
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
        <jsp:include page="header.jsp"/>
        <jsp:include page="staffNavBar.jsp"/>
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

    </body>
</html>
