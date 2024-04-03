<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Process Sales</title>
        <jsp:include page="bootstrap.jsp"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <style>
            /* Add any custom styles here */
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container">
            <h2>Processing Sales</h2>

            <%
              // Retrieve data from the request
              String[] custIDs = request.getParameterValues("custID");
              String[] prodIDs = request.getParameterValues("prodID");
              String[] quantities = request.getParameterValues("quantity");
              String[] amounts = request.getParameterValues("amount");
    
              // Print custIDs for debugging
              out.println("<p>custIDs: " + java.util.Arrays.toString(custIDs) + "</p>");

              String url = "jdbc:mysql://localhost:3306/fyp";
              String user = "root";
              String pass = "admin";

              Connection conn = null;
              PreparedStatement pstmt = null;

              try {
                  // Connect to the database
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  conn = DriverManager.getConnection(url, user, pass);

                  // Prepare SQL statement for inserting sales data
                  String sql = "INSERT INTO sales (custID, prodID, quantity, amount) VALUES (?, ?, ?, ?)";
                  pstmt = conn.prepareStatement(sql);

                  // Iterate over the arrays and insert data into the database
                // Iterate over the arrays and insert data into the database
          if (custIDs != null) {
              for (int i = 0; i < custIDs.length; i++) {
                  pstmt.setInt(1, Integer.parseInt(custIDs[i]));
                  pstmt.setInt(2, Integer.parseInt(prodIDs[i]));
                  pstmt.setInt(3, Integer.parseInt(quantities[i]));
                  pstmt.setDouble(4, Double.parseDouble(amounts[i]));
                  pstmt.executeUpdate(); // Execute the insert statement
              }
              out.println("<p>Sales processed successfully.</p>");
          }



                      
                  } catch (ClassNotFoundException | SQLException e) {
                      out.println("<p>Error processing sales: " + e.getMessage() + "</p>");
                  } finally {
                      // Close the database resources
                      if (pstmt != null) {
                          try {
                              pstmt.close();
                          } catch (SQLException e) {
                              e.printStackTrace();
                          }
                      }
                      if (conn != null) {
                          try {
                              conn.close();
                          } catch (SQLException e) {
                              e.printStackTrace();
                          }
                      }
                  }
            %>

        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
