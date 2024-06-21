package Servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TripHistoryServlet")
public class TripHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the user's email from the session
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");

        // Connect to the database
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Trip> tripHistory = new ArrayList<>();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/travel_management_system";
            String dbUser = "root";
            String dbPassword = "root";
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Query to retrieve trip history based on the user's email
         // Update the SQL query to join the 'trips' table with the 'users' table
            String sql = "SELECT t.* FROM trips t JOIN users u ON t.user_id = u.id WHERE u.email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            // Loop through the result set and add trip details to the list
            while (rs.next()) {
                Trip trip = new Trip();
                trip.setTripId(rs.getInt("trip_id"));
                trip.setOrigin(rs.getString("origin"));
                trip.setDestination(rs.getString("destination"));
                // ... Set other trip details ...
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date departureDate = sdf.parse(rs.getString("departure_date"));
                trip.setDepartureDate(departureDate);
                Date returnDate = sdf.parse(rs.getString("return_date"));
                trip.setReturnDate(returnDate);
                trip.setNumberOfTravelers(rs.getInt("number_of_travelers"));
                trip.setPreferredAirline(rs.getString("preferred_airline"));
                trip.setHotelType(rs.getString("hotel_type"));
                trip.setCarRentalType(rs.getString("car_rental_type"));
                tripHistory.add(trip);
            }

            // Set the tripHistory list as a session attribute
            session.setAttribute("tripHistory", tripHistory);

            // Redirect to the trip_history.jsp page to display trip history
            response.sendRedirect("trip_history.jsp");
        } catch (ClassNotFoundException | SQLException | ParseException e) {
            e.printStackTrace();
            // Handle exceptions
            response.sendRedirect("error.jsp"); // Redirect to an error page
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
