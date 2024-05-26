<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Calendar" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Attendance Summary</title>
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
            max-width: 800px;
            background-color: #ffffff;
            padding: 20px;
            margin: 20px auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }
        h2 {
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: bold;
            font-family: 'Arial', sans-serif;
            color: #333;
        }
        .summary {
            margin: 20px 0;
            font-size: 18px;
            text-align: center;
        }
        .additional-stats {
            margin-top: 30px;
            font-size: 16px;
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
    <div class="container">
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
