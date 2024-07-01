<%-- 
    Document   : managerNavBar
    Created on : 22 Dec 2023, 8:47:36 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String fname = (String) session.getAttribute("firstName"); %>
<style>
    .sidebar-list-item.active {
        background-color: #666666;
        color: #ffffff !important;
    }
</style>

<aside id="sidebar">
    
    <div class="sidebar-title">
        <div class="sidebar-brand">
            <a href="userDetails.jsp" style="color: #999999; text-decoration: none;">
                <span class="material-icons-outlined">person</span> Manager</a>, <%= fname %>
        </div>
        <span class="material-icons-outlined" onclick="closeSidebar()">close</span>
    </div>
  <ul class="sidebar-list">
    <a id="dashboard-link" href="managerDashboard.jsp" style="color: #999999; text-decoration: none;"> 
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">dashboard</span> Dashboard
        </li>
    </a>
    <a id="employee-link" href="employeeServlet?action=emplist" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">person</span> Employee
        </li>
    </a>
    <a id="attendances-link" href="attendancesList.jsp" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">calendar_month</span> Attendances
        </li>
    </a>
    <a id="customers-link" href="customersServlet?action=custlist" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">groups</span> Customers
        </li>
    </a>
    <a id="sales-link" href="processSales.jsp" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">shopping_bag</span> Sales
        </li>
    </a>
    <a id="suppliers-link" href="suppliersServlet?action=suplist" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">groups</span> Suppliers
        </li>
    </a>
    <a id="expenses-link" href="expensesList.jsp" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">shopping_cart</span> Expenses
        </li>
    </a>
    <a id="product-link" href="productsServlet?action=prodlist" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">inventory_2</span> Product
        </li>
    </a>
    <a id="logout-link" href="logoutPage.jsp" style="color: #999999; text-decoration: none;">
        <li class="sidebar-list-item">
            <span class="material-icons-outlined">logout</span> Log Out
        </li>
    </a>
</ul>


</aside>
        
    <script>
    // Function to get the current page with query parameters
    function getCurrentPage() {
        var pathname = window.location.pathname.split("/").pop();
        var search = window.location.search;
        return pathname + search;
    }

    // Map the current page with query parameters to the corresponding sidebar link ID
    var pageToLinkId = {
        "dashboard-link": ["managerDashboard.jsp"],
        "employee-link": ["employeeServlet?action=emplist", "employeeServlet?action=empnew", "employeeServlet?action=empedit"],
        "attendances-link": ["attendancesList.jsp"],
        "customers-link": ["customersServlet?action=custlist", "customersServlet?action=custnew", "customersServlet?action=custedit"],
        "sales-link": ["processSales.jsp", "sales.jsp", "salesDetails.jsp"],
        "suppliers-link": ["suppliersServlet?action=suplist", "suppliersServlet?action=supnew", "suppliersServlet?action=supedit"],
        "expenses-link": ["expensesList.jsp", "expenses.jsp", "expenseDetails.jsp"],
        "product-link": ["productsServlet?action=prodlist", "productsServlet?action=prodnew", "productsServlet?action=prodedit"],
        "logout-link": ["loginPage.jsp"]
    };

    // Get the current page with query parameters
    var currentPage = getCurrentPage();

    // Loop through the keys in the pageToLinkId object to find a match
    for (var linkId in pageToLinkId) {
        var urls = pageToLinkId[linkId];
        for (var i = 0; i < urls.length; i++) {
            if (currentPage.startsWith(urls[i])) {
                var activeLink = document.getElementById(linkId);

                if (activeLink) {
                    activeLink.querySelector(".sidebar-list-item").classList.add("active");
                }
                break;
            }
        }
    }
</script>


