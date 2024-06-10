<%-- 
    Document   : managerNavBar
    Created on : 22 Dec 2023, 8:47:36 pm
    Author     : A S U S
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String fname = (String) session.getAttribute("firstName"); %>
<aside id="sidebar">
    <div class="sidebar-title">
        <div class="sidebar-brand">
            <a href="userDetails.jsp" style="color: #999999">
                <span class="material-icons-outlined">person</span> Manager</a>, <%= fname %>
        </div>
        <span class="material-icons-outlined" onclick="closeSidebar()">close</span>
    </div>
    <ul class="sidebar-list">
        <li class="sidebar-list-item">
            <a href="managerDashboard.jsp">
                <span class="material-icons-outlined">dashboard</span> Dashboard
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="employeeServlet?action=emplist">
                <span class="material-icons-outlined">person</span> Employee
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="attendancesList.jsp">
                <span class="material-icons-outlined">calendar_month</span> Attendances
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="customersServlet?action=custlist">
                <span class="material-icons-outlined">groups</span> Customers
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="processSales.jsp">
                <span class="material-icons-outlined">shopping_bag</span> Sales
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="suppliersServlet?action=suplist">
                <span class="material-icons-outlined">groups</span> Suppliers
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="expensesList.jsp">
                <span class="material-icons-outlined">shopping_cart</span> Expenses
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="productsServlet?action=prodlist">
                <span class="material-icons-outlined">inventory_2</span> Product
            </a>
        </li>
        <li class="sidebar-list-item">
            <a href="loginPage.jsp">
                <span class="material-icons-outlined">logout</span> Log Out
            </a>
        </li>
    </ul>
</aside>
