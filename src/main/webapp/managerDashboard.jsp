<%-- 
    Document   : managerDashboard
    Created on : 22 Dec 2023, 8:47:36 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <!-- Bootstrap CSS -->

        <% String fname = (String) session.getAttribute("firstName"); %>
        <!-- Montserrat Font -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        <!--        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- Custom Styles -->
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>

        <%
            Connection c = null;
            PreparedStatement ps = null;
            Statement s = null;
            ResultSet r = null;
            int totalprod = 0;
            double salesum = 0.0;
            List<String> topProducts = new ArrayList<>();
            List<Integer> purchaseCounts = new ArrayList<>();
            
            try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");
            
            // count total products
            String prodcount = "SELECT COUNT(*) FROM products";
            s = c.createStatement();
            r = s.executeQuery(prodcount);
            if (r.next()) {
            totalprod = r.getInt(1);
            }
            
            //count sum sales
            String sumcountsale = "SELECT SUM(total) AS sumsale FROM sales";
            r = s.executeQuery(sumcountsale);
            if(r.next()) {
            salesum = r.getDouble("sumsale");
            }
            
            // find 5 top products
            String topprod = "SELECT p.prodName, COUNT(s.prodID) AS countprod FROM sales_items s "
            + "JOIN products p ON s.prodID = p.prodID "
            + "GROUP BY s.prodID "
            + "ORDER BY countprod DESC "
            + "LIMIT 2";
            r = s.executeQuery(topprod);
            while (r.next()) {
            topProducts.add(r.getString("prodName"));
            purchaseCounts.add(r.getInt("countprod"));
            }

        %>
        <div class="grid-container">
            <!-- Header -->
            <header class="header">
                <h2>JERNIH TILING ENT</h2>

            </header>
            <!-- End Header -->

            <!-- Sidebar -->
            <jsp:include page="managerNavBar.jsp" />
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Dashboard
                </h2>
                <hr>
                <div class="main-cards">
                    <div class="card">
                        <div class="card-inner">
                            <p class="text-primary">PRODUCTS</p>
                            <span class="material-icons-outlined text-blue">inventory_2</span>
                        </div>
                        <span class="text-primary font-weight-bold"><%= totalprod %></span>
                    </div>
                    <div class="card">
                        <div class="card-inner">
                            <p class="text-primary">SALES</p>
                            <span class="material-icons-outlined text-orange">shopping_bag</span>
                        </div>
                        <span class="text-primary font-weight-bold">RM<%= salesum %></span>
                    </div>
                    <div class="card">
                        <div class="card-inner">
                            <p class="text-primary">EXPENSES</p>
                            <span class="material-icons-outlined text-green">shopping_cart</span>
                        </div>
                        <span class="text-primary font-weight-bold">79</span>
                    </div>
                    <div class="card">
                        <div class="card-inner">
                            <p class="text-primary">INVENTORY ALERTS</p>
                            <span class="material-icons-outlined text-red">notification_important</span>
                        </div>
                        <span class="text-primary font-weight-bold">56</span>
                    </div>
                </div>
                <div class="charts">
                    <div class="charts-card">
                        <p class="chart-title">Top 2 Products</p>
                        <canvas id="bar-chart"></canvas>
                            <%
                                for (int i = 0; i < topProducts.size(); i++) {
                                    out.println("<p>" + topProducts.get(i) + ": " + purchaseCounts.get(i) + "</p>");
                                }
                            %>
                    </div>
                    <div class="charts-card">
                        <p class="chart-title">Area Chart for Top 2 Products</p>
                        <canvas id="area-chart"></canvas>
                    </div>
                </div>
                <br><br>
                <p>&copy; 2023 Jernih Group Ent. All rights reserved.</p>
            </main>
            <!-- End Main -->
        </div>


        <%   } catch (SQLException e) {
       e.printStackTrace();
       out.println("<p>Error occurred while displaying sales: " + e.getMessage() + "</p>");
}
        %>


        <!-- Scripts -->

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Retrieve data from server-side
            var topProducts = [<%= "'" + topProducts.get(0) + "', '" + topProducts.get(1) + "'" %>];
            var purchaseCounts = [<%= purchaseCounts.get(0) %>, <%= purchaseCounts.get(1) %>];

            // Create a bar chart
            var ctxBar = document.getElementById('bar-chart').getContext('2d');
            var barChart = new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: topProducts,
                    datasets: [{
                            label: 'Purchase Counts',
                            data: purchaseCounts,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                        // Add more colors if needed
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                        // Add more colors if needed
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            // Create an area chart
            var ctxArea = document.getElementById('area-chart').getContext('2d');
            var areaChart = new Chart(ctxArea, {
                type: 'line',
                data: {
                    labels: topProducts,
                    datasets: [{
                            label: topProducts[0],
                            data: [purchaseCounts[0]], // Assuming purchaseCounts represent sales data for topProducts[0]
                            fill: false,
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1
                        }, {
                            label: topProducts[1],
                            data: [purchaseCounts[1]], // Assuming purchaseCounts represent sales data for topProducts[1]
                            fill: false,
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>



        <!-- ApexCharts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.35.3/apexcharts.min.js"></script>

        <!-- Custom JS -->
        <script src="js/scripts.js"></script>
    </body>
</html>
