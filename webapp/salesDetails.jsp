<%-- 
    Document   : salesDetails
    Created on : 1 May 2024, 6:08:16 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sale Details Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            padding-top: 20px;
        }
        .table {
            background-color: #fff;
        }
        .table th, .table td {
            text-align: center;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f2f2f2;
        }
        .btn {
            margin-top: 20px;
        }
        .footer {
            background-color: #343a40;
            color: #fff;
            padding: 20px 0;
            text-align: center;
            position: fixed;
            width: 100%;
            bottom: 0;
            left: 0;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <jsp:include page="header.jsp"/>
    
    <!-- Content -->
    <div class="container">
        <% 
            String saleid = request.getParameter("saleID");
            int ID = Integer.parseInt(saleid);
            String custid = request.getParameter("custID");
            int cust = Integer.parseInt(custid);
            
            String details = "SELECT prodID, quantity, total FROM sales_items WHERE saleID = ?";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");
                PreparedStatement ps = cn.prepareStatement(details);
                ps.setInt(1, ID);
                ResultSet rs = ps.executeQuery();
        %>
        <table class="table table-striped table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th>Product ID</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getInt("prodID") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td><%= rs.getDouble("total") %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        <% 
            rs.close();
            ps.close();
            cn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } %>
        
        <!-- Update Sales Button -->
        <a href="updateSales.jsp?saleID=<%= ID %>&custID=<%= cust %>" class="btn btn-primary">Update Sales</a>
    </div>

    <!-- Footer -->
    <div class="footer">
        <jsp:include page="footer.jsp"/>
    </div>
</body>
</html>
