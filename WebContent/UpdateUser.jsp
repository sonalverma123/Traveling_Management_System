<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%
// Get the trip details from the request parameters
int id = Integer.parseInt(request.getParameter("id"));
String name = request.getParameter("name");
String email = request.getParameter("email");
String phone = request.getParameter("phone");


try {
    // Load the JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish the connection to the database
    String url = "jdbc:mysql://localhost:3306/travel_management_system";
    String dbUser = "root";
    String dbPassword = "root";
    Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Prepare the SQL query to update the trip details
    String sql = "UPDATE users SET name=?, email=?, phone=? WHERE id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, email);
    pstmt.setString(3, phone);
    
    pstmt.setInt(4, id);

    // Execute the update
    int rowsUpdated = pstmt.executeUpdate();
    
 // Redirect to show_appointments.jsp with success message
    if (rowsUpdated > 0) {
      response.sendRedirect("admin_dashboard.jsp?message=success");
    } else {
      response.sendRedirect("admin_dashboard.jsp?message=error");
    }

    // Close the connection
    pstmt.close();
    conn.close();

   
} catch (Exception ex) {
    ex.printStackTrace();
    
}
%>
