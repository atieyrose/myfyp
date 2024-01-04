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
        <jsp:include page="bootstrap.jsp" />
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">

        <!-- Custom Styles -->
        <style>
            body {
                background-color: #f8f9fa;
            }

            .container {
                margin-top: 50px;
            }

            .card {
                margin-bottom: 20px;
                border: 1px solid #e2e2e2;
                border-radius: 8px;
                transition: box-shadow 0.4s ease;
                cursor: pointer;
                width: 100%; /* Set width to 100% */
                height: 150px; /* Set height to your desired size */
                display: flex;
                flex-direction: column;
                justify-content: center; /* Center vertically */
            }

            .card:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card-title {
                font-size: 18px;
                margin-bottom: 0;
                text-align: center; /* Center horizontally */
            }

            /* Custom Classes and Colors */
            .custom-color {
                background-color: #6a9292;
            }

        </style>
    </head>

    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="clerkNavBar.jsp"/>

        <div class="container mx-auto">
            <div class="row">
                
                <div class="col-md-1">
                    
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Attendances</h5>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Leave</h5>
                            <!-- Sales content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Customers</h5>
                            <!-- Expenses content goes here -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                
                 <div class="col-md-1">
                    
                </div>
                
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Sales</h5>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Suppliers</h5>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Expenses</h5>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                
                 <div class="col-md-1">
                    
                </div>
                
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Products</h5>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Inventory</h5>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card">
                        <div class="card-body custom-color">
                            <h5 class="card-title">Cash Flow</h5>
                            <!-- Customers content goes here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />

        <!-- Bootstrap JS and Popper.js (required for Bootstrap JavaScript plugins) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>


