<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Process Sales</title>
        <jsp:include page="bootstrap.jsp"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <style>
            .center-table {
                margin: 0 auto;
                width: 60%; /* Adjust the width as needed */
            }
            .table {
                background-color: #ffffff;
            }

            .table th {
                background-color: #999999;
                color: #ffffff;
            }

            .table td, .table th {
                border: 1px solid #dee2e6;
                padding: 14px;
                text-align: center;
            }

            .table a {
                text-decoration: none;
                margin-right: 10px;
            }

            .table a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <%
        String role= (String) session.getAttribute("role");
        %>

        <% if ("manager".equals(role)) { %>
        <jsp:include page="managerNavBar.jsp"/>
        <% } else { %>
        <jsp:include page="clerkNavBar.jsp"/> 
        <% } %>

        <div class="container">
            <h2>Sales List</h2>
            <a href="newjsp1.jsp" class="btn btn-success float-right">Add New Sales</a>


            <%

    
                Connection c = null;
                PreparedStatement pSales = null;
                PreparedStatement pSalesItems = null;
                ResultSet rSales = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                    // Start transaction
                    c.setAutoCommit(false);

                    // Debug statement to check if the database connection is successful
                    if (c != null) {
                        out.println("<p> Database connection successful! </p>");
                    } else {
                        out.println("<p> Database connection failed! </p>");
                    }

                    // Get JSON data from request parameter
                    String jsonData = request.getParameter("saleListJSON");

                    // Parse JSON data
                    JSONArray saleList = new JSONArray(jsonData);
                    
                                        String totalAmountParam = request.getParameter("totalAmount");
    if (totalAmountParam != null) {
        double totalAmount = Double.parseDouble(totalAmountParam);
        out.println("Total Amount received: $" + totalAmount);
    } else {
        out.println("Total Amount parameter is null.");
    }
            
                    JSONObject firstSaleItem = saleList.getJSONObject(0);
                    int customerId = firstSaleItem.getInt("custID");
                    double a = Double.parseDouble(totalAmountParam);
                    
                    out.println(customerId);
                    // Insert sales data into the sales table
                    String insertSales = "INSERT INTO sales (custID, total, date) VALUES (?, ?, CURDATE())";
                    pSales = c.prepareStatement(insertSales, Statement.RETURN_GENERATED_KEYS);
                    pSales.setInt(1, customerId);
                    pSales.setDouble(2, a);
                    pSales.executeUpdate();

                    // Retrieve the generated sale ID
                    rSales = pSales.getGeneratedKeys();
                    int saleID = 0;
                    if (rSales.next()) {
                        saleID = rSales.getInt(1);
                    }

                    // Insert each sale item into the sales_items table
                    String insertSaleItems = "INSERT INTO sales_items (saleID, prodID, quantity, total) VALUES (?, ?, ?, ?)";
                    pSalesItems = c.prepareStatement(insertSaleItems);
                    for (int i = 0; i < saleList.length(); i++) {
                        JSONObject saleItem = saleList.getJSONObject(i);

                        // Get sale item details
                        int productId = saleItem.getInt("prodID");
                        int quantity = saleItem.getInt("quantity");
                        double amount = saleItem.getDouble("amount");

                        // Set parameters for the sales_items insert statement
                        pSalesItems.setInt(1, saleID);
                        pSalesItems.setInt(2, productId);
                        pSalesItems.setInt(3, quantity);
                        pSalesItems.setDouble(4, amount);

                        // Execute the insert statement for sales_items
                        pSalesItems.executeUpdate();
                    }

                    // Commit the transaction
                    c.commit();
                    out.println("<p>Sales and sale items inserted successfully!</p>");
                } catch (Exception e) {
                    // Rollback the transaction in case of any exceptions
                    if (c != null) {
                        try {
                            c.rollback();
                        } catch (SQLException ex) {
                            ex.printStackTrace();
                        }
                    }
                    // Handle any exceptions
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources (Connection, PreparedStatement, ResultSet) in the finally block
                    if (rSales != null) {
                        try {
                            rSales.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (pSales != null) {
                        try {
                            pSales.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (pSalesItems != null) {
                        try {
                            pSalesItems.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (c != null) {
                        try {
                            c.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>

            <div class="center-table">
                <%
                    
                    String display= "SELECT * FROM sales";
                    try {
                        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(display);
                %>

                <table class="table table-striped table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Sale ID</th>
                            <th>Customer ID</th>
                            <th>Total</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <%
                        while (rs.next()) {
                            int saleid = rs.getInt("saleID");
                            int custid = rs.getInt("custID");
                            double total = rs.getDouble("total");
                            Date date = rs.getDate("date");
                    %>
                    <tbody>
                        <tr>
                            <td><%= saleid %></td>
                            <td><%= custid %></td>
                            <td><%= total %></td>
                            <td><%= date %></td>
                            <td><a href="salesDetails.jsp?saleID=<%= saleid %>&custID=<%= custid %>">Details</a></td>


                        </tr>
                    </tbody>

                    <%
                        }
                        rs.close();
                        st.close();
                        cn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    %>
                </table>
            </div>
        </div>

                
        <jsp:include page="footer.jsp"/>
    </body>
</html>
