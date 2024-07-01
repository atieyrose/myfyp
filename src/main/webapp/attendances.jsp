<%-- 
    Document   : attendances
    Created on : 8 May 2024, 9:37:42 pm
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.Duration" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.time.LocalDate" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Attendances</title>
        <link rel="icon" href="images/Jernih.png" type="image/x-icon">
    </head>
    <body>
        <%
             //Retrieve the UID parameter from the request
             String uid = request.getParameter("UID");
             String date = request.getParameter("date");
             String time = request.getParameter("time");
             
             
             

//            String uid= "E3 6A 4F 11";
//            String date= "2024-05-21";
//            String time= "17:50:33";

            // Process the UID as needed
            if (uid != null) {
                // Do something with the UID
                System.out.println("Received UID: " + uid);
                System.out.println("date" +date);
             System.out.println(time);
                // Here, you can save the UID to a database, perform some actions, etc.
            } else {
                // Handle case where no UID is provided
                System.out.println("No UID received");
            }
            
            // Parse the date Strign into LocalDate obj
            LocalDate d = LocalDate.parse(date);
            
            // Get the day of the week
            DayOfWeek dow = d.getDayOfWeek();
            
            String day = dow.toString();


            Connection c = null;
PreparedStatement prv = null;
ResultSet r = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fyp", "root", "admin");

    // Debug statement to check if the database connection is successful
    if (c != null) {
        out.println("<p> Database connection successful! </p>");
    } else {
        out.println("<p> Database connection failed! </p>");
    }

    String rv = "SELECT clockin FROM attendances WHERE UID = ? AND date = ? LIMIT 1";
    prv = c.prepareStatement(rv);
    prv.setString(1, uid);
    prv.setString(2, date);
    
    r = prv.executeQuery();

    String sql = "";

    if (r.next()) {
        LocalDateTime clockin = LocalDateTime.parse(date + " " + r.getTimestamp("clockin").toLocalDateTime().toLocalTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        LocalDateTime clockout = LocalDateTime.parse(date + " " + time, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        Duration duration = Duration.between(clockin, clockout);
        double durationHours = (double) duration.getSeconds() / 3600;

        sql = "UPDATE attendances SET clockout = ?, duration = ? WHERE UID = ? AND date = ?";
        prv = c.prepareStatement(sql);
        prv.setString(1, time);
        prv.setDouble(2, durationHours);
        prv.setString(3, uid);
        prv.setString(4, date);
        prv.executeUpdate();

    } else {
        sql = "INSERT INTO attendances (UID, date, day, clockin) VALUES (?, ?, ?, ?)";
        prv = c.prepareStatement(sql);
        prv.setString(1, uid);          
        prv.setString(2, date);
        prv.setString(3, day);
        prv.setString(4, time);
        prv.executeUpdate();
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (r != null) try { r.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (prv != null) try { prv.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (c != null) try { c.close(); } catch (SQLException e) { e.printStackTrace(); }
}

        %>

        <h1>Update Sensor</h1>
        <p>Received UID: <%= uid != null ? uid : "No UID received" %></p>
    </body>
</html>
