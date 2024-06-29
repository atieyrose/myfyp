<%-- 
    Document   : sales
    Created on : 5 Jan 2024, 3:10:10 am
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
        <title>Add New Sale</title>
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
            .table-container {
                margin: 20px auto;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }
            .table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            .table th, .table td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            .table thead th {
                background-color: #333;
                color: #fff;
                text-transform: uppercase;
            }
            .table tbody tr:hover {
                background-color: #f1f1f1;
            }
            .btn {
                display: inline-block;
                padding: 10px 15px;
                margin: 5px 0;
                text-decoration: none;
                text-align: center;
                border-radius: 5px;
                transition: background-color 0.3s;
            }
            .btn-warning {
                background-color: #f0ad4e;
                color: #fff;
            }
            .btn-warning:hover {
                background-color: #ec971f;
            }
            .btn-danger {
                background-color: #d9534f;
                color: #fff;
            }
            .btn-danger:hover {
                background-color: #c9302c;
            }
            @media (max-width: 768px) {
                .table-container {
                    padding: 10px;
                }
                .table th, .table td {
                    padding: 8px;
                }
            }

            .fieldset-spacing {
                margin-bottom: 10px; /* Adjust the value as needed */
            }

            .input-size {
                width: 1000px; /* Adjust the width as needed */
            }
            table.form-table {
                width: 45%;
                border-collapse: collapse;
            }
            table.form-table td {
                width: 33%;
                padding: 10px;
            }
            table.form-table input,
            table.form-table select,
            table.form-table button {
                width: 100%;
                box-sizing: border-box;
            }
            /* Horizontal Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
            }
            .page-item {
                margin: 0 5px;
            }
            .page-link {
                display: block;
                padding: 10px 15px;
                text-decoration: none;
                color: #333;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            .page-link:hover {
                background-color: #f1f1f1;
                color: #333;
            }
            .page-item.active .page-link {
                background-color: #333;
                color: #fff;
            }
            .page-item.disabled .page-link {
                color: #ddd;
                pointer-events: none;
            }
            .enhanced-button {
                display: inline-block;
                padding: 15px 20px;
                font-size: 15px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #fff;
                background: #28a745;
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                cursor: pointer;
                transition: all 0.3s ease;
                outline: none;
            }

            .enhanced-button:hover {
                background: #218838;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
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
            <% } else { %>
            <jsp:include page="clerkNavBar.jsp"/>
            <% } %>
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Add New Sale
                </h2>
                <hr>



                
                    <div class="card">
                       

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
                            <form id="salesForm"  method="post">
                                <table class="form-table">
                                    <tr>
                                        <td><label for="customerDropdown" style="font-size: 1em;">Select a Customer:</label></td>
                                        <td>
                                            <select name="customerDropdown" id="customerDropdown" style="font-size: 1em; height: 30px;">
                                                <option value="">-- Select a Customer --</option>
                                                <% while (rs.next()) { %>
                                                <option value="<%= rs.getInt("custID") %>">
                                                    <%= rs.getString("firstName") %> <%= rs.getString("lastName") %>
                                                </option>
                                                <% } %>
                                            </select> 
                                        </td><!-- comment -->
                                    </tr>



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



                                    <tr>
                                        <td><label for="item" style="font-size: 1em;">Item:</label></td>
                                        <td><select id="item" style="font-size: 1em; height: 30px;" required>
                                                <option value="">-- Select an Item --</option>
                                                <% while (rs.next()) { %>
                                                <option value="<%= rs.getInt("prodID") %>" data-price="<%= rs.getDouble("price") %>">
                                                    <%= rs.getString("prodName") %>
                                                </option>
                                                <% } %>
                                            </select></td>
                                    </tr>


                                    <tr>
                                        <td><label for="price" style="font-size: 1em;">Price:</label>
                                            <span class="input-group-text">$</span></td>
                                        <td><input type="number" id="price" class="form-control" step="0.01" style="font-size: 1em; height: 30px;" required readonly></td>
                                    </tr>

                                    <tr>

                                        <td><label for="quantity" style="font-size: 1em;">Quantity:</label></td>
                                        <td><input type="number" id="quantity" class="form-control" style="font-size: 1em; height: 30px;" required></td>
                                    </tr>
                                    <tr>
                                        <td><label for="amount" style="font-size: 1em;">Amount:</label>
                                            <span class="input-group-text">$</span></td>
                                        <td><input type="number" id="amount" class="form-control" step="0.01" style="font-size: 1em; height: 30px;" required readonly></td>
                                    </tr>
                                    <tr>
                                        <td><button class="enhanced-button" type="button" id="addSale">Add Sale</button></td>
                                    </tr>
                                </table>
                            </form>

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
                                        </tr>
                                    </thead>
                                    <tbody id="saleList"></tbody>
                                </table>
                                <div class="text-center">
                                    <!--<button type="button" id="saveSales" class="btn btn-success">Save Sales</button>-->
<!--                                    <button id="calculateButton">Calculate Total</button>-->
                                    <div id="totalAmountDisplay"></div>
                                    <br>

                                    <button class="enhanced-button" type="button" id="saveSalesBtn"> Save Sales </button>

                                </div>
                            </div>
                        </div>
                 
             
            </main>
        </div>


        <br>
        <script>
            const saleArray = []; // Declare saleArray outside the event listener

            const saleList = document.getElementById('saleList');
            const saleTable = document.getElementById('saleTable');

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

            let itemNo = 1;
            document.getElementById('addSale').addEventListener('click', function () {
                const itemSelect = document.getElementById('item');
                const itemOption = itemSelect.options[itemSelect.selectedIndex];
                const item = itemOption.text; // Get the text of the selected option
                const prodID = itemOption.value; // Get the product ID
                const price = parseFloat(document.getElementById('price').value);
                const quantity = parseInt(document.getElementById('quantity').value);
                const amount = parseFloat(document.getElementById('amount').value);
                const custID = document.getElementById("customerDropdown").value; // Retrieve the selected customer ID

                const newRow = saleTable.insertRow();
                const cell1 = newRow.insertCell(0);
                const cell2 = newRow.insertCell(1);
                const cell3 = newRow.insertCell(2);
                const cell4 = newRow.insertCell(3);
                const cell5 = newRow.insertCell(4);
                const cell6 = newRow.insertCell(5); // Add new cell for prodID

                cell1.textContent = itemNo++;
                cell2.textContent = item;
                cell3.textContent = prodID; // Display prodID
                cell4.textContent = '$' + price.toFixed(2);
                cell5.textContent = quantity;
                cell6.textContent = '$' + amount.toFixed(2);

                // Clear the form fields
                document.getElementById('item').selectedIndex = 0; // Reset item selection
                document.getElementById('price').value = '';
                document.getElementById('quantity').value = '';
                document.getElementById('amount').value = '';

                const saleItem = {
                    custID: custID,
                    prodID: prodID,
                    item: item,
                    price: price,
                    quantity: quantity,
                    amount: amount
                };

                // Add saleItem to the saleArray
                saleArray.push(saleItem);
                calculateTotal();

            });

            //calculate the total amount of sales
            function calculateTotal() {
                // Calculate total amount
                let totalAmount = 0;
                saleArray.forEach(function (saleItem) {
                    totalAmount += saleItem.amount;
                });

                // Display total amount
                const totalAmountDisplay = document.getElementById('totalAmountDisplay');
                totalAmountDisplay.textContent = 'Total Amount: $' + totalAmount.toFixed(2);

                // Store totalAmount in session storage
                sessionStorage.setItem('totalAmount', totalAmount);
            }



            document.getElementById('saveSalesBtn').addEventListener('click', function () {
                saveSales();
            });

            function saveSales() {
                // Calculate total amount
                let totalAmount = 0;
                saleArray.forEach(function (saleItem) {
                    totalAmount += saleItem.amount;
                });

                const jsonData = JSON.stringify(saleArray);

                // Create a hidden input to hold the JSON data
                const jsonInput = document.createElement("input");
                jsonInput.type = "hidden";
                jsonInput.name = "saleListJSON";
                jsonInput.value = jsonData;

                // Create a hidden input to hold the totalAmount
                const totalAmountInput = document.createElement("input");
                totalAmountInput.type = "hidden";
                totalAmountInput.name = "totalAmount";
                totalAmountInput.value = totalAmount;

                // Create a form and append the inputs
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "processSales.jsp";
                form.appendChild(jsonInput);
                form.appendChild(totalAmountInput);

                // Append form to the document body and then submit
                document.body.appendChild(form);
                form.submit();
            }

        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>

