<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<%
// Get the trip details from the request parameters
int tripId = Integer.parseInt(request.getParameter("trip_id"));
String origin = request.getParameter("origin");
String destination = request.getParameter("destination");
String departureDate = request.getParameter("departureDate");
String returnDate = request.getParameter("returnDate");
String numberOfTravelersParam = request.getParameter("numberOfTravelers");
int numberOfTravelers = 0; // Default value or any other value you prefer

if (numberOfTravelersParam != null && !numberOfTravelersParam.isEmpty()) {
    numberOfTravelers = Integer.parseInt(numberOfTravelersParam);
}

String preferredAirline = request.getParameter("preferredAirline");
String hotelType = request.getParameter("hotelType");
String carRentalType = request.getParameter("carRentalType");

try {
    // Load the JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish the connection to the database
    String url = "jdbc:mysql://localhost:3306/travel_management_system";
    String dbUser = "root";
    String dbPassword = "root";
    Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Prepare the SQL query to update the trip details
    String sql = "UPDATE trips SET origin=?, destination=?, departure_date=?, return_date=?, number_of_travelers=?, preferred_airline=?, hotel_type=?, car_rental_type=? WHERE trip_id=?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, origin);
    pstmt.setString(2, destination);
    pstmt.setString(3, departureDate);
    pstmt.setString(4, returnDate);
    pstmt.setInt(5, numberOfTravelers);
    pstmt.setString(6, preferredAirline);
    pstmt.setString(7, hotelType);
    pstmt.setString(8, carRentalType);
    pstmt.setInt(9, tripId);

    // Execute the update
    int rowsUpdated = pstmt.executeUpdate();
    
 // Redirect to show_appointments.jsp with success message
    if (rowsUpdated > 0) {
      response.sendRedirect("trip_history.jsp?message=success");
    } else {
      response.sendRedirect("trip_history.jsp?message=error");
    }

    // Close the connection
    pstmt.close();
    conn.close();

   
} catch (Exception ex) {
    ex.printStackTrace();
    
}
%>
