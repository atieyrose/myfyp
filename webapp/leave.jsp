<%-- 
    Document   : leave
    Created on : 24 Dec 2023, 3:13:15 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page session="true" %>

<%
    String username = (String) session.getAttribute("username");
    
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Leave Application Form</title>
        
        <!-- Add this in the <head> section of your HTML file -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <jsp:include page="bootstrap.jsp"/>

        <style>
            .container {
                max-width: 800px;

            }

            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }

            form {
                max-width: 500px;
                margin: 0 auto;
            }

            label {
                display: block;
                margin-top: 10px;
            }

            input, select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                margin-bottom: 10px;
                box-sizing: border-box;
            }

            textarea {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                margin-bottom: 10px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <jsp:include page="clerkNavBar.jsp"/>
        <br><br>
        <div class="container col-md-5">
            <div class="card">
                <div class="card-body">

                    <c:if test="${leave != null}">
                        <form action="leaveServlet" method="post">
                            <input type="hidden" name="action" value="leaveupdate"><!-- comment -->

                        </c:if>

                        <c:if test="${leave == null}">
                            <form action="leaveServlet" method="post">
                                <input type="hidden" name="action" value="leaveinsert"><!-- comment -->

                            </c:if>


                            <h2>
                                <c:if test="${leave == null}">
                                    Add New Leave
                                </c:if>
                                <c:if test="${leave != null}">
                                    Update Leave
                                </c:if>
                            </h2>
                            <br><br>

                            <c:if test="${leave == null}">
                                <input type="hidden" name="empID" value="${username}" />
                            </c:if>

                            <c:if test="${leave != null}">
                                <input type="hidden" name="leaveID" value="<c:out value='${leave.leaveID}'/>" />
                                <input type="hidden" name="empID" value="${leave.empID}" />
                            </c:if>

                            <fieldset class="form-group">
                                <label>Type of Leave</label>
                                <select class="form-control" name="leaveType" required="required">
                                    <option value="">Type of Leave</option>
                                    <c:choose>
                                        <c:when test="${leave.type eq 'vacation'}">
                                            <option value="vacation" selected>Vacation</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="vacation">Vacation</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${leave.type eq 'sick'}">
                                            <option value="sick" selected>Sick Leave</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="sick">Sick Leave</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${leave.type eq 'personal'}">
                                            <option value="personal" selected>Personal Leave</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="personal">Personal Leave</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${leave.type eq 'other'}">
                                            <option value="other" selected>Other</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="other">Other</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </fieldset>
                            <fieldset class="form-group">
                                <label>Start Date</label>
                                <input type="date" value="<c:out value='${leave.start}'/>" class="form-control" name="startDate" id="start" required="required">
                            </fieldset>

                            <fieldset class="form-group">
                                <label>End Date</label>
                                <input type="date" value="<c:out value='${leave.end}'/>" class="form-control" name="endDate" id="end" required="required">
                            </fieldset>

                            <fieldset class="form-group">
                                <label>Total Days</label>
                                <input type="text" value="<c:out value='${leave.totalDay}'/>" class="form-control" name="totalDay" id="totalDay" readonly>
                            </fieldset>


                            <fieldset class="form-group">
                                <label>Leave Description</label>
                                <input type="text" value="<c:out value='${leave.leaveDesc}'/>" class="form-control" name="leaveDesc"><!-- comment -->
                            </fieldset>

                            <br>
                            <button type="submit" class="btn btn-success">Submit</button>
                        </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        
        <script>
            // Function to calculate the total days
            function calculateTotalDays() {
                var startDate = new Date(document.getElementById("start").value);
                var endDate = new Date(document.getElementById("end").value);

                // Check if both start and end dates are valid
                if (!isNaN(startDate.getTime()) && !isNaN(endDate.getTime())) {
                    // Calculate the difference in milliseconds
                    var timeDifference = endDate - startDate;

                    // Convert the difference to days
                    var totalDays = Math.ceil(timeDifference / (1000 * 60 * 60 * 24));

                    // Display the total days in the input field
                    document.getElementById("totalDay").value = totalDays;
                } else {
                    // Handle invalid dates
                    document.getElementById("totalDay").value = "";
                }
            }

            // Attach the calculateTotalDays function to the change event of start and end date inputs
            document.getElementById("start").addEventListener("change", calculateTotalDays);
            document.getElementById("end").addEventListener("change", calculateTotalDays);
        </script>


    </body>
</html>

