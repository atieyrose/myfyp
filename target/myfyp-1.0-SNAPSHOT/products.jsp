<%-- 
    Document   : products
    Created on : 5 Jan 2024, 3:09:45 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 600px; /* Reduced width */
                margin: 20px auto; /* Reduced margin */
                background-color: #fff;
                padding: 10px; /* Reduced padding */
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h3 {
                font-size: 1.5rem; /* Smaller heading */
                text-align: center;
                margin-bottom: 15px;
            }

            .form-group {
                margin-bottom: 10px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                font-size: 0.9rem; /* Smaller font size */
            }

            input[type="text"],
            input[type="email"],
            input[type="password"],
            select {
                width: 100%;
                padding: 5px; /* Reduced padding */
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 0.9rem; /* Smaller font size */
            }

            input[type="submit"] {
                padding: 8px 15px; /* Reduced padding */
                font-size: 0.9rem; /* Smaller font size */
                background-color: #9b9bdc;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
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
        <br><br>
        <div class="container col-md-5">
            <div class="">
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


                            <div class="form-group">
                                <label>Product Name</label>
                                <input type="text" value="<c:out value='${products.prodName}'/>" class="form-control" name="prodName" required="required"><!-- comment -->
                            </div>

                            <div class="form-group">
                                <label>Product Description</label>
                                <input type="text" value="<c:out value='${products.prodDesc}'/>" class="form-control" name="prodDesc" required="required"><!-- comment -->
                            </div>

                            <div class="form-group">
                                <label>Product Price</label>
                                <input type="text" value="<c:out value='${products.price}'/>" class="form-control" name="price" required="required"><!-- comment -->
                            </div>


                            <button type="submit" class="btn btn-success">Save</button>
                        </form>
                </div>
            </div>
        </div>
        <br><!-- <br> --><br>
        <jsp:include page="footer.jsp"/>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    </body>

</html>