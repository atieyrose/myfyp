<%-- 
    Document   : processUserUpdate
    Created on : 20 Jan 2024, 11:38:36 pm
    Author     : A S U S
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String r = (String) session.getAttribute("role");
        %>

        <% if ("manager".equals(r)) { %>

        <%
            String data = (String) session.getAttribute("username");

            Connection cn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String url = "jdbc:mysql://localhost:3306/fyp";
            String user = "root";
            String pass = "admin";

            String fname = request.getParameter("firstName");
            String lname = request.getParameter("lastName");
            String role = request.getParameter("role");
            String icno = request.getParameter("icno");
            String dob = request.getParameter("DOB");
            String phoneno = request.getParameter("phoneNo");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String password = request.getParameter("password");

            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
                cn = DriverManager.getConnection(url, user, pass);

                String myQuery = "UPDATE manager SET firstName = ?, lastName = ?, role = ?, icNo = ?, DOB = ?, phoneNo = ?, email = ?, address = ?, password = ? WHERE ID = ?";
                ps = cn.prepareStatement(myQuery);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, role);
                ps.setString(4, icno);
                ps.setString(5, dob);
                ps.setString(6, phoneno);
                ps.setString(7, email);
                ps.setString(8, address);
                ps.setString(9, password);
                ps.setString(10, data);

                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("userDetails.jsp");
                } else {
                    response.sendRedirect("userDetails.jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("userDetails.jsp");
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("userDetails.jsp");
            } finally {
                try {
                    if (ps != null) {
                        ps.close();
                    }
                    if (cn != null) {
                        cn.close();
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>

        <% } else { %>

        <%
            String data = (String) session.getAttribute("username");

            Connection cn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String url = "jdbc:mysql://localhost:3306/fyp";
            String user = "root";
            String pass = "admin";

            String fname = request.getParameter("firstName");
            String lname = request.getParameter("lastName");
            String role = request.getParameter("role");
            String icno = request.getParameter("icno");
            String dob = request.getParameter("DOB");
            String phoneno = request.getParameter("phoneNo");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String password = request.getParameter("password");

            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
                cn = DriverManager.getConnection(url, user, pass);

                String myQuery = "UPDATE employee SET firstName = ?, lastName = ?, role = ?, icNo = ?, DOB = ?, phoneNo = ?, email = ?, address = ?, password = ? WHERE ID = ?";
                ps = cn.prepareStatement(myQuery);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, role);
                ps.setString(4, icno);
                ps.setString(5, dob);
                ps.setString(6, phoneno);
                ps.setString(7, email);
                ps.setString(8, address);
                ps.setString(9, password);
                ps.setString(10, data);

                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("userDetails.jsp");
                } else {
                    response.sendRedirect("userDetails.jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("userDetails.jsp");
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("userDetails.jsp");
            } finally {
                try {
                    if (ps != null) {
                        ps.close();
                    }
                    if (cn != null) {
                        cn.close();
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>

        <% } %>
    </body>
</html>
