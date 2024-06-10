<%-- 
    Document   : managerDashboard
    Created on : 22 Dec 2023, 8:47:36 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <span class="text-primary font-weight-bold">249</span>
                    </div>
                    <div class="card">
                        <div class="card-inner">
                            <p class="text-primary">PURCHASE ORDERS</p>
                            <span class="material-icons-outlined text-orange">add_shopping_cart</span>
                        </div>
                        <span class="text-primary font-weight-bold">83</span>
                    </div>
                    <div class="card">
                        <div class="card-inner">
                            <p class="text-primary">SALES ORDERS</p>
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
                        <p class="chart-title">Top 5 Products</p>
                        <div id="bar-chart"></div>
                    </div>
                    <div class="charts-card">
                        <p class="chart-title">Purchase and Sales Orders</p>
                        <div id="area-chart"></div>
                    </div>
                </div>
            </main>
            <!-- End Main -->
        </div>
        <!-- Scripts -->
        <!-- ApexCharts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.35.3/apexcharts.min.js"></script>
        <!-- Custom JS -->
        <script src="js/scripts.js"></script>
    </body>
</html>
