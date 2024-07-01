<%-- 
    Document   : logoutPage
    Created on : 1 Jul 2024, 10:00:58 pm
    Author     : A S U S
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // Invalidate session
    HttpSession s = request.getSession(false);
    if (s != null) {
        s.invalidate();
    }
%>
<script type="text/javascript">
    // Redirect to login page immediately
    window.location.href = "loginPage.jsp";
</script>


