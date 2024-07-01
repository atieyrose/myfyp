<%-- 
    Document   : staffNavBar
    Created on : 23 Jan 2024, 12:25:04 am
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
                <span class="material-icons-outlined">person</span> Staff</a>, <%= fname %>
        </div>
        <span class="material-icons-outlined" onclick="closeSidebar()">close</span>
    </div>
    <ul class="sidebar-list">
        <a id="dashboard-link" href="staffDashboard.jsp" style="color: #999999; text-decoration: none;"> 
            <li class="sidebar-list-item">
                <span class="material-icons-outlined">dashboard</span> Dashboard
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
        "dashboard-link": ["staffDashboard.jsp", "attendancesListStaff.jsp"]
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

