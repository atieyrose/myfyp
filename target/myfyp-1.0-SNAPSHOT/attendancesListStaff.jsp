<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attendance List</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
        String uid = (String) session.getAttribute("uid");

        if ("manager".equals(role)) { 
        %>
        <jsp:include page="managerNavBar.jsp"/>
        <% 
        } else if ("clerk".equals(role)) { 
        %>
        <jsp:include page="clerkNavBar.jsp"/> 
        <% 
        } else { 
        %>
        <jsp:include page="staffNavBar.jsp"/>
        <% 
        } 
        %>

        <br>
        
        <div class="container">
            <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
                Attendances List
            </h2>
            <hr>
            <br><br><!-- comment -->
            
            <%
            Connection c = null;
            PreparedStatement ps = null;
            ResultSet r = null;
            
            int rowsPerPage = 15; // Number of rows per page
            int currentPage = 1; // Default current page

            // Get current page from request parameter
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
            }
            int startRow = (currentPage - 1) * rowsPerPage;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

                String attshow = "SELECT a.attendID, a.UID, a.date, a.day, a.clockin, a.clockout, a.duration, e.firstName, e.ID " +
                                 "FROM attendances a JOIN employee e ON a.UID = e.cardID " +
                                 "WHERE a.UID = ? LIMIT ?, ?";
                ps = c.prepareStatement(attshow);
                ps.setString(1, uid);
                ps.setInt(2, startRow);
                ps.setInt(3, rowsPerPage);
                r = ps.executeQuery();
            %>
            <div class="center-table">
                <table class="table table-striped table-bordered">
                    <thead class="thead-dark">
                        <tr>
                            <th>Employee ID</th>
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
                        Date dateObj = r.getDate("date");
                        String formattedDate = (dateObj != null) ? new SimpleDateFormat("d MMM yyyy").format(dateObj) : "";

                        String day = r.getString("day");

                        Time clockinTime = r.getTime("clockin");
                        String formattedClockin = (clockinTime != null) ? new SimpleDateFormat("h:mm a").format(clockinTime) : "";

                        Time clockoutTime = r.getTime("clockout");
                        String formattedClockout = (clockoutTime != null) ? new SimpleDateFormat("h:mm a").format(clockoutTime) : "";

                        String duration = r.getString("duration");
                        if (duration == null) {
                            duration = "-";
                        }
                    %>
                        <tr>
                            <td><%= uid %></td>
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
                <nav>
                    <ul class="pagination justify-content-center">
                        <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                            <a class="page-link" href="?page=<%= currentPage - 1 %>">Previous</a>
                        </li>
                        <li class="page-item <%= (r.next()) ? "" : "disabled" %>">
                            <a class="page-link" href="?page=<%= currentPage + 1 %>">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
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
                if (ps != null) {
                    try {
                        ps.close();
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
    </body>
</html>
