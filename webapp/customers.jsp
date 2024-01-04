<%-- 
    Document   : customers
    Created on : 5 Jan 2024, 1:40:34 am
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
            background-color: #f8f9fa;
        }

        .container {
            max-width: 800px;
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

        /* Optional: Add custom styling for specific elements */
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }
    </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <% String data= (String) session.getAttribute("custID"); %>
        <jsp:include page="managerNavBar.jsp"/>
        <br><br>
        <div class="container col-md-5">
            <div class="">
                <div class="card-body">

                    <c:if test="${customers != null}">
                        <form action="customersServlet" method="post">
                            <input type="hidden" name="action" value="custupdate"><!-- comment -->

                        </c:if>

                        <c:if test="${customers == null}">
                            <form action="customersServlet" method="post">
                                <input type="hidden" name="action" value="custinsert"><!-- comment -->

                            </c:if>

                            <h2>
                                <c:if test="${customers == null}">
                                    Add New Customer
                                </c:if>
                                <c:if test="${customers != null}">
                                    Update Customer
                                </c:if>
                            </h2>
                            <br><br>

                            <c:if test="${customers != null}">
                                <input type="hidden" name="ID" value="<c:out value='${customers.custID}'/>" />
                            </c:if>


                            <fieldset class="form-group">
                                <label>First Name</label>
                                <input type="text" value="<c:out value='${customers.firstName}'/>" class="form-control" name="firstName" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Last Name</label>
                                <input type="text" value="<c:out value='${customers.lastName}'/>" class="form-control" name="lastName" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Phone Number</label>
                                <input type="text" value="<c:out value='${customers.phoneNo}'/>" class="form-control" name="phoneNo" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Email</label>
                                <input type="email" value="<c:out value='${customers.email}'/>" class="form-control" name="email" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Address</label>
                                <input type="text" value="<c:out value='${customers.address}'/>" class="form-control" name="address" required="required"><!-- comment -->
                            </fieldset>

                            <c:if test="${customers != null}">
                                <input type="hidden" name="password" value="<c:out value='${customers.password}'/>" />
                            </c:if>

                            <c:if test="${customers == null}">
                                <fieldset class="form-group">
                                    <label>Password</label>
                                    <input type="password" value="<c:out value='${customers.password}'/>" class="form-control" name="password" required="required"><!-- comment -->
                                </c:if>
                            </fieldset>

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
