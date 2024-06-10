<%-- 
    Document   : attendancesList
    Created on : 22 Dec 2023, 8:47:36 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
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
            <jsp:include page="managerNavBar.jsp" />
            <!-- End Sidebar -->

            <!-- Main -->
            <main class="main-container">
               <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                    Attendances List
                </h2>
            <hr>
            <br><br>

            <%
                Connection c = null;
                PreparedStatement p = null;
                ResultSet r = null;

                int rowsPerPage = 15; // Number of rows per page
                int currentPage = 1; // Default current page
                int totalRows = 0; // Total number of rows
                int totalPages = 0; // Total number of pages

                // Get current page from request parameter
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    currentPage = Integer.parseInt(pageStr);
                }

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                    // select id, firstName of employee
                    String emp = "SELECT cardID, firstName FROM employee";
                    p = c.prepareStatement(emp);
                    r = p.executeQuery();
            %>
            <form method="GET" action="attendancesList.jsp">
                <label for ="emp">Select an employee:</label>
                <select name="selectedEmployee" id="selectedEmployee">
                    <option value="">--Select employee--</option>
                    <% while (r.next()) { %>
                    <option value="<%= r.getString("cardID")%>">
                        <%= r.getString("firstName") %>
                    </option>
                    <% } %>
                </select>
                <button type="submit">Show Attendances</button>
            </form>

            <!-- Add a date picker input field -->
            <form method="GET" action="attendancesList.jsp">
                <label for="datepicker">Choose a date:</label>
                <input type="date" id="datepicker" name="selectedDate" value="<%= request.getParameter("selectedDate") %>">
                <button type="submit">Show Attendances</button>
            </form>
            <%
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                } finally {
                    if (r != null) {
                        try {
                            r.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (p != null) {
                        try {
                            p.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>

            <%
                try {
                    c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");
                    String selectedEmployee = request.getParameter("selectedEmployee");
                    String selectedDate = request.getParameter("selectedDate");

                    // Get today's date
                    java.util.Date today = new java.util.Date();
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    String todayDate = dateFormat.format(today);

                    // Default to today's date if no date is selected
                    if (selectedDate == null || selectedDate.isEmpty()) {
                        selectedDate = todayDate;
                    }

                    // Determine if we're filtering by employee or date
                    String query;
                    if (selectedEmployee != null && !selectedEmployee.isEmpty()) {
                        query = "SELECT COUNT(*) FROM attendances WHERE UID = ?";
                        p = c.prepareStatement(query);
                        p.setString(1, selectedEmployee);
                    } else {
                        query = "SELECT COUNT(*) FROM attendances WHERE date = ?";
                        p = c.prepareStatement(query);
                        p.setString(1, selectedDate);
                    }

                    // Count total number of rows
                    ResultSet countResult = p.executeQuery();
                    if (countResult.next()) {
                        totalRows = countResult.getInt(1);
                    }
                    countResult.close();
                    p.close();

                    // Calculate total number of pages
                    totalPages = (int) Math.ceil((double) totalRows / rowsPerPage);

                    // Pagination logic
                    int offset = (currentPage - 1) * rowsPerPage; // Offset for current page
                    if (selectedEmployee != null && !selectedEmployee.isEmpty()) {
                        query = "SELECT a.attendID, a.UID, a.date, a.day, a.clockin, a.clockout, a.duration, e.firstName, e.ID " +
                                "FROM attendances a JOIN employee e ON a.UID = e.cardID " +
                                "WHERE a.UID = ? LIMIT ?, ?";
                        p = c.prepareStatement(query);
                        p.setString(1, selectedEmployee);
                    } else {
                        query = "SELECT a.attendID, a.UID, a.date, a.day, a.clockin, a.clockout, a.duration, e.firstName, e.ID " +
                                "FROM attendances a JOIN employee e ON a.UID = e.cardID " +
                                "WHERE a.date = ? LIMIT ?, ?";
                        p = c.prepareStatement(query);
                        p.setString(1, selectedDate);
                    }
                    p.setInt(2, offset);
                    p.setInt(3, rowsPerPage);

                    r = p.executeQuery();
            %>

            <h2>Date: <%= selectedDate %> </h2>
            <div class="center-table">
                <table class="table table-striped table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Employee ID</th>
                            <th>Employee Name</th>
                            <th>Date</th>
                            <th>Day</th>
                            <th>Clock IN</th>
                            <th>Clock OUT</th>
                            <th>Duration (H)</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        while (r.next()) {
                            String uid = r.getString("UID");
                            String employeeName = r.getString("firstName");
                            int employeeID = r.getInt("ID");

                            // Check if date is null
                            Date dateObj = r.getDate("date");
                            String formattedDate = "";
                            if (dateObj != null) {
                                SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy");
                                formattedDate = sdf.format(dateObj);
                            }

                            String day = r.getString("day");

                            // Format clock-in time
                            Time clockinTime = r.getTime("clockin");
                            SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
                            String formattedClockin = "";
                            if (clockinTime != null) {
                                formattedClockin = timeFormat.format(clockinTime);
                            }

                            // Format clock-out time
                            Time clockoutTime = r.getTime("clockout");
                            String formattedClockout = "";
                            if (clockoutTime != null) {
                                formattedClockout = timeFormat.format(clockoutTime);
                            }

                            String duration = r.getString("duration");
                            if (duration == null) {
                                duration = "-";
                            }
                    %>
                        <tr>
                            <td><%= employeeID %></td>
                            <td><%= employeeName %></td>
                            <td><%= formattedDate %></td>
                            <td><%= day %></td>
                            <td><%= formattedClockin %></td>
                            <td><%= formattedClockout %></td>
                            <td><%= duration %></td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>

                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item <%= currentPage == 1 ? "disabled" : "" %>">
                            <a class="page-link" href="?page=<%= currentPage - 1 %>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <li class="page-item <%= currentPage == i ? "active" : "" %>">
                            <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                        </li>
                        <% } %>
                        <li class="page-item <%= currentPage == totalPages ? "disabled" : "" %>">
                            <a class="page-link" href="?page=<%= currentPage + 1 %>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

            <%
                } catch (Exception e) {
                    // Handle any exceptions
                    e.printStackTrace();
                    out.println("<p>Error occurred: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources in the finally block
                    if (r != null) {
                        try {
                            r.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (p != null) {
                        try {
                            p.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (c != null) {
                        try {
                            c.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>

            </main>
            <!-- End Main -->
        </div>
        <!-- Scripts -->
        <!-- ApexCharts -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.35.3/apexcharts.min.js"></script>
        <!-- Custom JS -->
        <script src="js/scripts.js"></script>
    </body>
</html>
