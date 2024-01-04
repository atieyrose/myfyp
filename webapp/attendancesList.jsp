<%-- 
    Document   : attendancesList
    Created on : 4 Jan 2024, 2:09:34 am
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attendances List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
            }

            h2 {
                text-align: center;
                color: #333;
            }

            form {
                margin: 20px auto;
                width: 300px;
                padding: 20px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            label, input {
                display: block;
                width: 100%;
                margin-bottom: 10px;
            }

            input[type="date"] {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            input[type="submit"] {
                background-color: #5cb85c;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #4cae4c;
            }

            table {
                margin: 20px auto;
                width: 80%;
                border-collapse: collapse;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f0f0f0;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <h2>Attendance Search</h2>
        <form action="/search_attendance" method="get">
            <label for="searchDate">Enter Date:</label>
            <input type="date" id="searchDate" name="date">
            <input type="submit" value="Search">
        </form>

        <h2>Attendance List</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Employee Name</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Attendance Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>12345</td>
                    <td>John Doe</td>
                    <td>2024-01-04</td>
                    <td>09:00 AM</td>
                    <td>Present</td>
                </tr>
                <!-- Rows will be dynamically generated -->
            </tbody>
        </table>
    </body>
</html>
