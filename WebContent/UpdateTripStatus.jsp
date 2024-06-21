<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%
// Get the trip ID and status from the request parameters
int tripId = Integer.parseInt(request.getParameter("trip_id"));
String status = request.getParameter("status");

try {
    // Load the JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish the connection to the database
    String url = "jdbc:mysql://localhost:3306/travel_management_system";
    String dbUser = "root";
    String dbPassword = "root";
    Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Prepare the SQL query to update the trip status and notification status
    String sql = "UPDATE trips SET trip_status=?, notification_status='read' WHERE trip_id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, status);
    pstmt.setInt(2, tripId);

    // Execute the update
    int rowsUpdated = pstmt.executeUpdate();

    // Close the connection
    pstmt.close();
    conn.close();

    // Send a response back to the JavaScript function
    response.getWriter().write("Trip status updated to " + status);
} catch (Exception ex) {
    ex.printStackTrace();
    // Handle any errors and send an error response back to the JavaScript function
    response.getWriter().write("Error updating trip status");
}
%>
