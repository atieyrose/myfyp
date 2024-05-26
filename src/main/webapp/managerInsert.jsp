<%-- 
    Document   : managerInsert
    Created on : 15 Jan 2024, 2:49:57 am
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


        <jsp:include page="bootstrap.jsp" />
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <title>Login Page</title>

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
                margin-bottom: 8px;
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
        <jsp:include page="header.jsp" />
        <br>
        <div class="container">
            <div class="card-body">
                <div class="mb-4">
                    <h3>Add Manager</h3>
                </div>
                <form action="processManagerInsert.jsp" method="POST">

                    <div class="form-group">
                        <label>First Name</label>
                        <input type="text" class="form-control" name="firstName" required="required"><!-- comment -->
                    </div>

                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" class="form-control" name="lastName" required="required"><!-- comment -->
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <select class="form-control" name="role">
                            <option value="option1">Option 1</option>
                            <option value="option2">Option 2</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="icno">IC Number</label>
                        <input type="text" class="form-control" name="icno" required="required">
                    </div>

                    <div class="form-group">
                        <label>Date Of Birth</label>
                        <input type="date" class="form-control" name="DOB" required="required"><!-- comment -->
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" class="form-control" name="phoneNo" required="required"><!-- comment -->
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" class="form-control" name="email" required="required"><!-- comment -->
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <input type="text" class="form-control" name="address" required="required"><!-- comment -->
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="password" required="required"><!-- comment -->
                        </c:if>
                    </div>




                    <input type="submit" value="Save" class="btn btn-block btn-primary">

                </form>

            </div>
        </div>
        <br><br>

        <jsp:include page="footer.jsp" />

        <!-- Bootstrap JS and Popper.js (required for Bootstrap JavaScript plugins) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    </body>
</html>
