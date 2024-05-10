<%-- 
    Document   : save_sales
    Created on : 28 Apr 2024, 11:31:02 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page session="true" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <!-- Add this in the <head> section of your HTML file -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <jsp:include page="bootstrap.jsp"/>

        <style>
            body {
                background-color: #f8f9fa;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 20px;
                background-color: #ffffff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
            }

            h2 {
                text-align: center;
            }

            label {
                font-weight: bold;
            }

            .form-group {
                margin-bottom: 20px;
            }

            input[type="text"],
            input[type="password"],
            input[type="email"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                font-size: 16px;
                background-color: #f8f9fa;
            }

            .btn-success {
                background-color: #007bff;
                color: #ffffff;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
            }

            .btn-success:hover {
                background-color: #0056b3;
            }

            /* Additional styling for form elements */
            .card {
                border: none;
                box-shadow: none;
                border-radius: 0;
            }

            .card-body {
                padding: 30px;
            }
            .h2-title {
                text-align: center;
            }

            /* Optional: Add custom styling for specific elements */

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <br><br>
        <div class="container col-md-10">
            <div class="">
                <div class="card-body">
                    <br><br>
                    <%
                        Connection cn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        String url = "jdbc:mysql://localhost:3306/fyp";
                        String user = "root";
                        String pass = "admin";

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            cn = DriverManager.getConnection(url, user, pass);

                            String customerQuery = "SELECT custID, firstName, lastName FROM customers";
                            ps = cn.prepareStatement(customerQuery);
                            rs = ps.executeQuery();
                    %>
                    <form id="salesForm" action="processsales2.jsp" method="POST">
                        <label for="customerDropdown">Select a Customer:</label>
                        <select name="customerDropdown" id="customerDropdown">
                            <option value="">-- Select a Customer --</option>
                            <% while (rs.next()) { %>
                            <option value="<%= rs.getInt("custID") %>">
                                <%= rs.getString("firstName") %> <%= rs.getString("lastName") %>
                            </option>
                            <% } %>
                        </select>
                        <br>

                        <%
                            } catch (SQLException | ClassNotFoundException e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) {
                                    try {
                                        rs.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (ps != null) {
                                    try {
                                        ps.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (cn != null) {
                                    try {
                                        cn.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        %>

                        <%
                            try {
                                cn = DriverManager.getConnection(url, user, pass);
                                String p = "SELECT prodID, prodName, price FROM products";
                                ps = cn.prepareStatement(p);
                                rs = ps.executeQuery();
                        %>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <h2 class="h2-title">Add Item</h2>

                                    <div class="form-group">
                                        <label for="item" class="mb-2">Item:</label>
                                        <select name="item" id="item" class="form-control" required>
                                            <option value="">-- Select an Item --</option>
                                            <% while (rs.next()) { %>
                                            <option value="<%= rs.getInt("prodID") %>" data-price="<%= rs.getDouble("price") %>">
                                                <%= rs.getString("prodName") %>
                                            </option>
                                            <% } %>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label for="price" class="mb-2">Price:</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">$</span>
                                            </div>
                                            <input type="number" id="price" name="price" class="form-control" step="0.01" required readonly>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="quantity" class="mb-2">Quantity:</label>
                                        <input type="number" id="quantity" name="quantity" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="amount" class="mb-2">Amount:</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">$</span>
                                            </div>
                                            <input type="number" id="amount" name="amount" class="form-control" step="0.01" required readonly>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <input type="submit" value="Add Sale" class="btn btn-block btn-primary">
                                        <input type="submit" value="Submit" class="btn btn-success">
                                    </div>
                                    </form> <!-- Closing form tag here -->
                                </div>
                                <%
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        if (rs != null) {
                                            try {
                                                rs.close();
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            }
                                        }
                                        if (ps != null) {
                                            try {
                                                ps.close();
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            }
                                        }
                                        if (cn != null) {
                                            try {
                                                cn.close();
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            }
                                        }
                                    }
                                %>


                                <div class="col-md-6">
                                    <h2 class="h2-title">Sale Details</h2>
                                    <table id="saleTable" class="table">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>Item</th>
                                                <th>ID</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>Amount</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="saleList"></tbody>
                                    </table>                                   
                                    <div class="text-center">
                                        <!--<button type="button" id="saveSales" class="btn btn-success">Save Sales</button>-->
                                        <button type="button" id="saveSalesBtn"> Save Sales </button>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <script>

                            document.getElementById('item').addEventListener('change', function () {
                                const selectedItem = this.options[this.selectedIndex];
                                const price = selectedItem.getAttribute('data-price');
                                document.getElementById('price').value = price;
                            });

                            document.getElementById('quantity').addEventListener('input', function () {
                                const price = parseFloat(document.getElementById('price').value);
                                const quantity = parseInt(this.value);
                                const amount = price * quantity;
                                document.getElementById('amount').value = amount.toFixed(2);
                            });


                        </script>




                        </body>
                        </html>
