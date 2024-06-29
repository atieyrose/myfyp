<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add New Sale</title>
        <!-- Bootstrap CSS -->
        <% String fname = (String) session.getAttribute("firstName"); %>
        <!-- Montserrat Font -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Material Icons -->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
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

            .fieldset-spacing {
                margin-bottom: 10px; /* Adjust the value as needed */
            }

            .input-size {
                width: 1000px; /* Adjust the width as needed */
            }
            table.form-table {
                width: 45%;
                border-collapse: collapse;
            }
            table.form-table td {
                width: 33%;
                padding: 10px;
            }
            table.form-table input,
            table.form-table select,
            table.form-table button {
                width: 100%;
                box-sizing: border-box;
            }
            /* Horizontal Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                list-style: none;
                padding: 0;
            }
            .page-item {
                margin: 0 5px;
            }
            .page-link {
                display: block;
                padding: 10px 15px;
                text-decoration: none;
                color: #333;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            .page-link:hover {
                background-color: #f1f1f1;
                color: #333;
            }
            .page-item.active .page-link {
                background-color: #333;
                color: #fff;
            }
            .page-item.disabled .page-link {
                color: #ddd;
                pointer-events: none;
            }
            .enhanced-button {
                display: inline-block;
                padding: 15px 20px;
                font-size: 15px;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #fff;
                background: #28a745;
                border: none;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
                cursor: pointer;
                transition: all 0.3s ease;
                outline: none;
            }

            .enhanced-button:hover {
                background: #218838;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
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
                    Attendances Summary
                </h2>
                <hr>




                <div class="card">
                    <%
                        String uid = request.getParameter("uid");
                        String selectedMonth = request.getParameter("month");
        
                        if (selectedMonth == null || selectedMonth.isEmpty()) {
                            // Default to the current month if no month is selected
                            Calendar cal = Calendar.getInstance();
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                            selectedMonth = sdf.format(cal.getTime());
                        }
                    %>

                    <h2>Attendance Summary</h2>
                    <hr>

                    <form method="get" action="attendancesStatistic.jsp">
                        <div class="form-group">
                            <label for="month">Select Month:</label>
                            <input type="month" id="month" name="month" class="form-control" value="<%= selectedMonth %>">
                        </div>
                        <input type="hidden" name="uid" value="<%= uid %>">
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </form>
                    <hr>

                    <%
                        Connection c = null;
                        PreparedStatement ps = null;
                        ResultSet r = null;
                        int totalDays = 0;
                        int totalHours = 0;
                        int maxHoursInDay = 0;
                        List<String> dates = new ArrayList<>();
                        List<Integer> durations = new ArrayList<>();

                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                            String att = "SELECT SUM(duration) as total_hours, COUNT(*) as total_days, MAX(duration) as max_hours_in_day FROM attendances WHERE UID = ? AND DATE_FORMAT(date, '%Y-%m') = ?";
                            ps = c.prepareStatement(att);
                            ps.setString(1, uid);
                            ps.setString(2, selectedMonth);
                            r = ps.executeQuery();

                            if (r.next()) {
                                totalDays = r.getInt("total_days");
                                totalHours = r.getInt("total_hours");
                                maxHoursInDay = r.getInt("max_hours_in_day");
                            }
                
                            String showatt = "SELECT date, day, clockin, clockout, duration FROM attendances WHERE UID = ? AND DATE_FORMAT(date, '%Y-%m') = ?";
                            ps = c.prepareStatement(showatt, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                            ps.setString(1, uid);
                            ps.setString(2, selectedMonth);
                            r = ps.executeQuery();
                    %>

                    <div class="center-table">
                        <table class="table table-striped table-bordered">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Date</th>
                                    <th>Day</th>
                                    <th>Clock IN</th>
                                    <th>Clock OUT</th>
                                    <th>Duration (H)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% while (r.next()) {
                        
                                    Date dateObj = r.getDate("date");
                                    String formattedDate = "";
                                    if (dateObj != null) {
                                        SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy");
                                        formattedDate = sdf.format(dateObj);
                                    }
                            
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
                            
                                %>
                                <tr>
                                    <td><%= formattedDate %></td>
                                    <td><%= r.getString("day") %></td>
                                    <td><%= formattedClockin %></td>
                                    <td><%= formattedClockout %></td>
                                    <td><%= r.getString("duration") %></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>

                        <div class="summary">
                            <p>Total Days Worked: <%= totalDays %></p>
                            <p>Total Hours Worked: <%= totalHours %></p>
                        </div>

                        <div class="additional-stats">
                            <p>Average Hours per Day: <%= totalDays != 0 ? totalHours / totalDays : 0 %></p>
                            <p>Maximum Hours Worked in a Day: <%= maxHoursInDay %></p>
                        </div>

                        <%
                            r.close();
                            ps.close();
                            c.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p>Error occurred while retrieving attendance details: " + e.getMessage() + "</p>"); 
                        }
                        %>
                    </div>
                </div>
            </main>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
