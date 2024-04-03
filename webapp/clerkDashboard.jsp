<%-- 
    Document   : clerkDashboard
    Created on : 7 Jan 2024, 11:49:06 pm
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
        <jsp:include page="bootstrap.jsp" />
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- Custom Styles -->
        <style>
            body {
                background-color: #f8f9fa;

            }

            .container {
                margin-top: 20px;
            }

            .card {
                margin-bottom: 20px;
                border: 2px solid #e2e2e2;
                border-radius: 8px;
                transition: transform 0.2s;
                cursor: pointer;
                width: 100%; /* Set width to 100% */
                height: 150px; /* Set height to your desired size */
                display: flex;
                flex-direction: column;
                justify-content: center; /* Center vertically */
            }

            .card:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .card-title {
                font-size: 18px;
                margin-bottom: 0;
                text-align: center; /* Center horizontally */
            }

            /* Custom Classes and Colors */
            .custom-color {
                background-color: whitesmoke;
            }

            .icon-center {
                font-size: 40px; /* Adjust the size as needed */
                line-height: 50px; /* Should be the same or slightly larger than font-size */
                text-align: center;
                vertical-align: middle;
                display: flex;
                align-items: center;
                justify-content: center;
                padding-top: 10px;
            }



        </style>
    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="clerkNavBar.jsp"/>

        <br>
        <div class="container">
            <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                Dashboard
            </h2>


            <br>
            <div class="row">


                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Attendances</h5>
                            <i class="fas fa-clipboard fa-lg icon-center" style="color: skyblue;"></i>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>


                <div class="col-md-3">
                    <a href="customersServlet?action=custlist" class="card" style="text-decoration: none;
                       color: black;">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Customers</h5>
                            <i class="fa fa-users fa-lg icon-center" style="color: #ff9999;"></i>
                            <!-- Expenses content goes here -->
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Sales</h5>
                            <i class="fa fa-shopping-bag fa-lg icon-center" style="color: #ffcc99;"></i>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <a href="suppliersServlet?action=suplist" class="card" style="text-decoration: none;
                       color: black;">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Suppliers</h5>
                            <i class="fa fa-truck fa-lg icon-center" style="color: slateblue;"></i>
                            <!-- Customers content goes here -->
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Expenses</h5>
                            <i class="fa fa-shopping-cart fa-lg icon-center" style="color: #cc0099;"></i>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Products</h5>
                            <i class="fa fa-cubes fa-lg icon-center" style="color: #9999ff;"></i>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>


                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Inventory</h5>
                            <i class="fas fa-archive fa-lg icon-center" style="color: #cccc00;"></i>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <br><br>

        <jsp:include page="footer.jsp"/>
        <!-- Bootstrap JS and Popper.js (required for Bootstrap JavaScript plugins) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>



