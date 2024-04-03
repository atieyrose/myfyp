<%-- 
    Document   : sales
    Created on : 5 Jan 2024, 3:10:10 am
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                    <form action="processSales.jsp" method="post">
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
                    </form>
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
                                <form id="saleForm">
                                    <div class="form-group">
                                        <label for="item" class="mb-2">Item:</label>
                                        <select id="item" class="form-control" required>
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
                                            <input type="number" id="price" class="form-control" step="0.01" required readonly>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="quantity" class="mb-2">Quantity:</label>
                                        <input type="number" id="quantity" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="amount" class="mb-2">Amount:</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">$</span>
                                            </div>
                                            <input type="number" id="amount" class="form-control" step="0.01" required readonly>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <button type="button" id="addSale" class="btn btn-primary">Add Sale</button>
                                    </div>
                                </form>
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
                        });



                        document.getElementById('saveSalesBtn').addEventListener('click', function () {
                            saveSales();
                        });


                        function saveSales() {
                            var saleItems = [];

                            // Iterate through table rows
                            var rows = document.querySelectorAll('#saleTable tbody tr');
                            rows.forEach(function (row) {
                                var cells = row.cells;
                                var prodID = parseInt(cells[2].textContent); // Correct index for prodID
                                var item = cells[1].innerText;
                                var price = parseFloat(cells[3].innerText.replace('$', ''));
                                var quantity = parseInt(cells[4].innerText);
                                var amount = parseFloat(cells[5].innerText.replace('$', ''));

                                // Retrieve custID from the sale entry itself, not from the dropdown
                                var custID = cells[2].textContent;

                                var saleItem = {
                                    custID: custID,
                                    prodID: prodID,
                                    item: item,
                                    price: price,
                                    quantity: quantity,
                                    amount: amount
                                };

                                saleItems.push(saleItem);
                            });

                            console.log("Sale Items:", saleItems); // Debugging output

                            // Submit the form with sale items
                            var form = document.createElement("form");
                            form.method = "POST";
                            form.action = "processSales.jsp";

                            saleItems.forEach(function (item, index) {
                                var custIDInput = document.createElement("input");
                                custIDInput.type = "hidden";
                                custIDInput.name = "custID_" + index;
                                custIDInput.value = item.custID;

                                var prodIDInput = document.createElement("input");
                                prodIDInput.type = "hidden";
                                prodIDInput.name = "prodID_" + index;
                                prodIDInput.value = item.prodID;

                                var quantityInput = document.createElement("input");
                                quantityInput.type = "hidden";
                                quantityInput.name = "quantity_" + index;
                                quantityInput.value = item.quantity;

                                var amountInput = document.createElement("input");
                                amountInput.type = "hidden";
                                amountInput.name = "amount_" + index;
                                amountInput.value = item.amount;

                                form.appendChild(custIDInput);
                                form.appendChild(prodIDInput);
                                form.appendChild(quantityInput);
                                form.appendChild(amountInput);
                            });

                            // Append form to the document body and then submit
                            document.body.appendChild(form);
                            form.submit();
                        }








                    </script>

                </div>
            </div>
        </div>

        <h2>Sale Details</h2>
        <ul id="saleList"></ul>
    </body>
</html>
