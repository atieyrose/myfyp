<%-- 
    Document   : userUpdate
    Created on : 18 Jan 2024, 12:02:09 am
    Author     : A S U S
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
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

            .action-buttons a:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <%
        String r= (String) session.getAttribute("role");
        %>

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
    </body>
</html>
