<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%
    // Get the trip ID from the request parameters
    int id = Integer.parseInt(request.getParameter("id"));

    try {
        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        
        // Establish the connection to the database
        String url = "jdbc:mysql://localhost:3306/travel_management_system";
        String dbUser = "root";
        String dbPassword = "root";
        Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
        
        // Prepare the SQL query to delete the trip
        String sql = "DELETE FROM users WHERE id=?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        
        // Execute the deletion
        int rowsDeleted = pstmt.executeUpdate();
        
        // Close the connection
        pstmt.close();
        conn.close();
        
        // Redirect back to the trip history page
        response.sendRedirect("admin_dashboard.jsp");
    } catch (Exception ex) {
        ex.printStackTrace();
        // Handle any errors and redirect to an error page if needed
        response.sendRedirect("error.jsp");
    }
%>
