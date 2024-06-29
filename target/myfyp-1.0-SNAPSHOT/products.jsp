<%-- 
    Document   : products
    Created on : 5 Jan 2024, 3:09:45 am
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
        <title>Add New Product</title>
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
                <c:if test="${products == null}">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Add New Product
                </h2>
                </c:if>
                
                <c:if test="${products != null}">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Update Product
                </h2>
                </c:if>
                <hr>

               

                <div class="container col-md-5">
            <div class="card">
                <div class="card-body">

                    <c:if test="${products != null}">
                        <form action="productsServlet" method="post">
                            <input type="hidden" name="action" value="produpdate"><!-- comment -->

                        </c:if>

                        <c:if test="${products == null}">
                            <form action="productsServlet" method="post">
                                <input type="hidden" name="action" value="prodinsert"><!-- comment -->

                            </c:if>

                            <h2>
                                <c:if test="${products == null}">
                                    Add New Product
                                </c:if>
                                <c:if test="${products != null}">
                                    Update Product
                                </c:if>
                            </h2>
                            <br><br>

                            <c:if test="${products != null}">
                                <input type="hidden" name="prodID" value="<c:out value='${products.prodID}'/>" />
                            </c:if>


                            <fieldset class="form-group fieldset-spacing">
                                <label>Product Name</label>
                                <input type="text" value="<c:out value='${products.prodName}'/>" class="form-control input-size" name="prodName" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group fieldset-spacing">
                                <label>Product Description</label>
                                <input type="text" value="<c:out value='${products.prodDesc}'/>" class="form-control input-size" name="prodDesc" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group fieldset-spacing">
                                <label>Product Price</label>
                                <input type="text" value="<c:out value='${products.price}'/>" class="form-control input-size" name="price" required="required"><!-- comment -->
                            </fieldset>


                            <button type="submit" class="btn btn-success">Save</button>
                        </form>
                </div>
            </div>
        </div>
            </main>

            <br>
          

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="js/scripts.js"></script>
    </body>
</html>

