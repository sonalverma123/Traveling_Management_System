<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<head>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Logout</title>
    <script>
        window.onload = function() {
            // Redirect to the desired page after logout
            window.location.replace("contact.jsp"); // Replace "index.jsp" with the page you want to redirect to.
        };
    </script>
</head>
</head>
<%
    HttpSession session1 = request.getSession();
    session.invalidate();
    String role = (String) request.getSession().getAttribute("role");
    if (role != null) {
        if (role.equals("user")) {
            response.sendRedirect("user_dashboard.jsp");
        
        } else if (role.equals("admin")) {
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            response.sendRedirect("contact.jsp");
        }
    } else {
        response.sendRedirect("contact.jsp");
    }
%>

