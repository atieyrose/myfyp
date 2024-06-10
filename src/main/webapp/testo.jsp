<%-- 
    Document   : suppliersList
    Created on : 5 Jan 2024, 3:02:44 am
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
        <title>Dashboard</title>
        <!-- Bootstrap CSS -->

        <% String fname = (String) session.getAttribute("firstName"); %>
        <!-- Montserrat Font -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
        <!--        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">-->
<!--        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">-->
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
               <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Products List
                </h2>
            <hr>
            
           <% 
            if ("manager".equals(role) || "clerk".equals(role)) { 
            %>
            <a href="productsServlet?action=prodnew" class="btn btn-success float-right">Add New Product</a>
            <% } else { 
                } %>
            <br><br>
            
              <div class="container col-md-5">
            <div class="">
                <div class="card-body">

                    <c:if test="${employee != null}">
                        <form action="employeeServlet" method="post">
                            <input type="hidden" name="action" value="empupdate"><!-- comment -->

                        </c:if>

                        <c:if test="${employee == null}">
                            <form action="employeeServlet" method="post">
                                <input type="hidden" name="action" value="empinsert"><!-- comment -->

                            </c:if>

                            <h3>
                                <c:if test="${employee == null}">
                                    Add New Employee
                                </c:if>
                                <c:if test="${employee != null}">
                                    Update Employee
                                </c:if>
                            </h3>
                            <br>

                            <c:if test="${employee != null}">
                                <input type="hidden" name="ID" value="<c:out value='${employee.ID}'/>" />
                            </c:if>


                            <fieldset class="form-group">
                                <label>First Name</label>
                                <input type="text" value="<c:out value='${employee.firstName}'/>" class="form-control" name="firstName" placeholder="Enter First Name" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Last Name</label>
                                <input type="text" value="<c:out value='${employee.lastName}'/>" class="form-control" name="lastName" placeholder="Enter Last Name" required="required"><!-- comment -->
                            </fieldset>
                            
                            <fieldset class="form-group">
                                <label>Card ID</label>
                                <input type="text" value="<c:out value='${employee.cardID}'/>" class="form-control" name="cardID" placeholder="Enter Card ID"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Role</label>
                                <select class="form-control" name="role" required="required">
                                    <option value="">Select Role</option><!--  -->
                                    <c:choose>
                                        <c:when test="${employee.role eq 'clerk'}">
                                            <option value="clerk" selected>Clerk</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="clerk">Clerk</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${employee.role eq 'staff'}">
                                            <option value="staff" selected>Staff</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="staff">Staff</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>IC Number</label>
                                <input type="text" value="<c:out value='${employee.icNo}'/>" class="form-control" name="icNo" placeholder="Enter IC Number" required="required"><!-- comment -->
                            </fieldset>


                            <fieldset class="form-group">
                                <label>Date Of Birth</label>
                                <input type="date" value="<c:out value='${employee.DOB}'/>" class="form-control" name="DOB" placeholder="Enter Date Of Birth" required="required"><!-- comment -->
                            </fieldset>



                            <fieldset class="form-group">
                                <label>Phone Number</label>
                                <input type="text" value="<c:out value='${employee.phoneNo}'/>" class="form-control" name="phoneNo" placeholder="Enter Phone Number" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Email</label>
                                <input type="email" value="<c:out value='${employee.email}'/>" class="form-control" name="email" placeholder="Enter Email" required="required"><!-- comment -->
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Address</label>
                                <input type="text" value="<c:out value='${employee.address}'/>" class="form-control" name="address" placeholder="Enter Address" required="required"><!-- comment -->
                            </fieldset>

                            <c:if test="${employee != null}">
                                <input type="hidden" name="password" value="<c:out value='${employee.password}'/>" />
                            </c:if>

                            <c:if test="${employee == null}">
                                <fieldset class="form-group">
                                    <label>Password</label>
                                    <input type="password" value="<c:out value='${employee.password}'/>" class="form-control" name="password" required="required"><!-- comment -->
                                </c:if>
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
