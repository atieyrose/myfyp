<%-- 
    Document   : expensesList
    Created on : 5 Jan 2024, 3:10:33 am
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
        <jsp:include page="bootstrap.jsp" />
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm">
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

            h2 {
                text-align: center;
            }

            .table {
                background-color: #ffffff;
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

            .add-employee-btn {
                background-color: #4CAF50;
                color: white;
                border-radius: 5px;
                text-decoration: none;
                font-weight: bold;
                transition: background-color 0.3s ease;
                width: 200px;
                height: 50px;
                text-align: center;
                display: inline-block;
            }

            .add-employee-btn:hover, .add-employee-btn:focus {
                background-color: #45a049;
                color: white;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%
        String role= (String) session.getAttribute("role");
        %>
        <jsp:include page="header.jsp"/>
        <% if ("manager".equals(role)) { %>
        <jsp:include page="managerNavBar.jsp"/>
        <% } else if ("clerk".equals(role)) { %>
        <jsp:include page="clerkNavBar.jsp"/>
        <% } else if ("admin".equals(role)) { %>
        <jsp:include page="adminNavBar.jsp"/>
        <% } else { %>
        <jsp:include page="staffNavBar.jsp"/>
        <% } %>
        <br>
        <div class="row">
            <div class="container">
                <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Expenses List
                </h2>
                <hr>
                <a href="employeeServlet?action=empnew" class="btn btn-success float-right">Add New Expense</a>
                <br><br>
                <table class="table table-striped table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Expense ID</th>
                            <th>Supplier Name</th>
                            <th>Supply Product</th>
                            <th>Quantity</th>
                            <th>Amount</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="employee" items="${listemployee}">
                            <tr>
                                <td><c:out value="${employee.ID}" /></td>
                                <td><c:out value="${employee.firstName}" /></td>
                                <td><c:out value="${employee.lastName}" /></td>
                                <td><c:out value="${employee.phoneNo}" /></td>
                                <td><c:out value="${employee.email}" /></td>
                                <td>
                                    <button class="btn btn-warning" style="margin-bottom: 4px; height: 40px; width: 72px"><a style="color: white"href="employeeServlet?action=empedit&ID=<c:out value='${employee.ID}' />" >Edit</a></button>
                                    <button class="deleteButton btn btn-danger" style="margin-bottom: 4px; height: 40px; width: 72px" data-employee-id="<c:out value='${employee.ID}' />">Delete</button>
                                    <!--<a href="employeeServlet?action=empdelete&ID=<c:out value='${employee.ID}' />" class="btn btn-danger">Delete</a>-->
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <br>
        <jsp:include page="footer.jsp" />

        <script>
// Function to show a confirmation message when a Delete button is clicked
            document.querySelectorAll(".deleteButton").forEach(function (button) {
                button.addEventListener("click", function () {
                    var employeeID = this.getAttribute("data-employee-id");

                    // Use the built-in `confirm` dialog
                    var confirmation = confirm("Are you sure you want to delete this item?");

                    // Check if the user clicked "OK" in the confirmation dialog
                    if (confirmation) {
                        // If "OK" is clicked, navigate to the specified link with the employeeID
                        window.location.href = "employeeServlet?action=empdelete&ID=" + employeeID;
                    } else {
                        // Cancelled, no action needed
                        alert("Delete operation cancelled.");
                    }
                });
            });
        </script>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
