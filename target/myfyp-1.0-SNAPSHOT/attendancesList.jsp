<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <%
        String role = (String) session.getAttribute("role");
        %>

        <% if ("manager".equals(role)) { %>
        <jsp:include page="managerNavBar.jsp"/>
        <% } else { %>
        <jsp:include page="clerkNavBar.jsp"/> 
        <% } %>

        <br>

        <div class="container">
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
        </div>
        <jsp:include page="footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
