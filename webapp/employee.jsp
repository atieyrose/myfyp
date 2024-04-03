<%-- 
    Document   : employee
    Created on : 22 Dec 2023, 5:37:30 pm
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">


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
        <% String fname= (String) session.getAttribute("firstName"); %>
        <jsp:include page="header.jsp"/>
        <jsp:include page="managerNavBar.jsp"/>
        <br>
        <h2>
            <% String data= (String) session.getAttribute("username");
            %>


        </h2>
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
        <br>
        <%= data %>
        <jsp:include page="footer.jsp"/>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    </body>

</html>
