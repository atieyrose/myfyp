<%-- 
    Document   : suppliersList
    Created on : 5 Jan 2024, 3:02:44 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Employee List Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm">
        <jsp:include page="bootstrap.jsp"/>
        <style>
            body {
                background-color: #f8f9fa;
            }

            .container {
                max-width: 1100px;
                background-color: #ffffff;
                padding: 20px;
                margin: 20px auto;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
                border-radius: 10px;
            }

            h3 {
                text-align: center;
            }

            .table {
                background-color: #ffffff;
                border: 1px solid #dee2e6;
            }

            .table th {
                background-color: #999999;
                color: #ffffff;
            }

            .table td, .table th {
                border: 1px solid #dee2e6;
                padding: 12px;
                text-align: center;
            }

            .table a {
                text-decoration: none;
                margin-right: 10px;
            }

            .table a:hover {
                text-decoration: underline;
            }

            .add-customer-link {
                text-align: right;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="managerNavBar.jsp"/>
        <br><br>
        <div class="row">
            <div class="container">
                <h3 class="text-center">Suppliers List</h3><!-- comment -->
                <hr><!-- comment -->
                <br><!-- comment -->
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Supplier ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Phone Number</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>


                        <c:forEach var="suppliers" items="${listsuppliers}">
                            <tr>
                                <td>
                                    <c:out value="${suppliers.supID}" />
                                </td>
                                <td>
                                    <c:out value="${suppliers.firstName}" />
                                </td>
                                <td>
                                    <c:out value="${suppliers.lastName}" />
                                </td>
                                <td>
                                    <c:out value="${suppliers.phoneNo}" />
                                </td>
                                <td>
                                    <c:out value="${suppliers.email}" />
                                </td>
                                <td>
                                    <c:out value="${suppliers.address}" />
                                </td>
                                <td>
                                    <a href="suppliersServlet?action=supedit&supID=<c:out value='${suppliers.supID}' />">Edit</a>
                                    <a href="suppliersServlet?action=supdelete&supID=<c:out value='${suppliers.supID}' />">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <a href="customersServlet?action=supnew" class="nav-link">Add New Supplier</a>
        <jsp:include page="footer.jsp" />
    </body>
</html>
