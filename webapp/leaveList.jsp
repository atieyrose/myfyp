<%-- 
    Document   : employeeList
    Created on : 22 Dec 2023, 5:39:18 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            table {
                background-color: white;
                color: black;
            }
            .container {
                max-width: 1100px;
                background-color: white;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="managerNavBar.jsp"/>
        <br><br>
        <div class="row">
            <div class="container">
                <h3 class="text-center">Leave List</h3><!-- comment -->
                <hr><!-- comment -->
                <br><!-- comment -->
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>leave ID</th>
                            <th>Employee ID</th>
                            <th>Leave Type</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Total Days</th>
                            <th>Leave Description</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        

                        <c:forEach var="leave" items="${listleave}">
                            <tr>
                                <td>
                                    <c:out value="${leave.leaveID}" />
                                </td>
                                <td>
                                    <c:out value="${leave.empID}" />
                                </td>
                                <td>
                                    <c:out value="${leave.leaveType}" />
                                </td>
                                <td>
                                    <c:out value="${leave.startDate}" />
                                </td>
                                <td>
                                    <c:out value="${leave.endDate}" />
                                </td>
                                <td>
                                    <c:out value="${leave.totalDay}" />
                                </td>
                                <td>
                                    <c:out value="${leave.leaveDesc}" />
                                </td>

                                <td>
                                    <a href="leaveServlet?action=leaveedit&leaveID=<c:out value='${leave.leaveID}' />">Edit</a>
                                    <a href="leaveServlet?action=leavedelete&leaveID=<c:out value='${leave.leaveID}' />">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <a href="leaveServlet?action=leavenew" class="nav-link">Add New Leave</a>
        <jsp:include page="footer.jsp" />
    </body>
</html>
