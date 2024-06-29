<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Sale</title>
    <% String fname = (String) session.getAttribute("firstName"); %>
    <!-- Montserrat Font -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <!-- Custom Styles -->
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* Your existing styles here */
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
    <% String role= (String) session.getAttribute("role"); %>
    <% if ("manager".equals(role)) { %>
        <jsp:include page="managerNavBar.jsp"/>
    <% } else { %>
        <jsp:include page="clerkNavBar.jsp"/>
    <% } %>
    <!-- End Sidebar -->

    <!-- Main -->
    <main class="main-container">
        <h2 style="font-family: 'Arial', sans-serif; color: #333; text-align: center; text-transform: uppercase; letter-spacing: 2px; font-weight: bold;">
            Add New Sale
        </h2>
        <hr>

        <div class="container col-md-5">
            <div class="card">
                <div class="card-body">
                    <%-- Select Category Form --%>
                    <form id="expensesForm" method="post">
                        <table class="form-table">
                            <tr>
                                <td><label style="font-size: 1em;" for="expensesCategory">Select expense category:</label></td>
                                <td><select name="expenseCategory" id="expensesCategory" style="font-size: 1em; height: 30px;" onchange="showForm(this.value)">
                                        <option value="">Select Category</option>
                                        <option value="raw_materials">Raw Materials</option>
                                        <option value="utilities">Utilities</option>
                                        <option value="services">Services</option>
                                    </select></td>
                            </tr>
                        </table>
                    </form>

                    <%-- Form A: Raw Materials --%>
                    <div id="formA" style="display: none;">
                        <form id="formARawMaterials">
                            <!-- Raw Materials specific fields -->
                            <!-- Example: -->
                            <label for="rawMaterialField">Raw Material Field:</label>
                            <input type="text" id="rawMaterialField" name="rawMaterialField">
                        </form>
                    </div>

                    <%-- Form B: Utilities --%>
                    <div id="formB" style="display: none;">
                        <form id="formBUtilities">
                            <!-- Utilities specific fields -->
                            <!-- Example: -->
                            <label for="utilitiesField">Utilities Field:</label>
                            <input type="text" id="utilitiesField" name="utilitiesField">
                        </form>
                    </div>

                    <%-- Form C: Services --%>
                    <div id="formC" style="display: none;">
                        <form id="formCServices">
                            <!-- Services specific fields -->
                            <!-- Example: -->
                            <label for="servicesField">Services Field:</label>
                            <input type="text" id="servicesField" name="servicesField">
                        </form>
                    </div>

                    <!-- Existing JavaScript and sale details table -->
                </div>
            </div>
        </div>
    </main>
</div>

<script>
    // Function to show the selected form based on category
    function showForm(category) {
        // Hide all forms first
        document.getElementById('formA').style.display = 'none';
        document.getElementById('formB').style.display = 'none';
        document.getElementById('formC').style.display = 'none';

        // Show the selected form
        if (category === 'raw_materials') {
            document.getElementById('formA').style.display = 'block';
        } else if (category === 'utilities') {
            document.getElementById('formB').style.display = 'block';
        } else if (category === 'services') {
            document.getElementById('formC').style.display = 'block';
        }
    }

    // Existing JavaScript for sale details and functionalities
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/scripts.js"></script>
</body>
</html>
