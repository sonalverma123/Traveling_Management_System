package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpSession; // Import HttpSession class

import java.text.ParseException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	
    	// Check if the user is logged in
    	HttpSession session = request.getSession();
    	//if (session.getAttribute("email") == null || session.getAttribute("user_id") == null) {
    	    // User is not logged in or user_id is not set in the session, redirect to the login page
    	  //  response.sendRedirect("contact.jsp");
    	   // return;
    	//}

        
  

        String email = (String) session.getAttribute("email");
        String name = (String) session.getAttribute("name"); // Get the user's name from the session

        // Get user input from the form
        String origin = request.getParameter("origin");
        String destination = request.getParameter("destination");
        String departureDateStr = request.getParameter("departureDate");
        String returnDateStr = request.getParameter("returnDate");
        int numberOfTravelers = Integer.parseInt(request.getParameter("numberOfTravelers"));
        String preferredAirline = request.getParameter("preferredAirline");
        String hotelType = request.getParameter("hotelType");
        String carRentalType = request.getParameter("carRentalType");
        
		PrintWriter out = response.getWriter();
        try {
            SimpleDateFormat sdfForm = new SimpleDateFormat("MM/dd/yyyy");
            Date departureDate = (Date) sdfForm.parse(departureDateStr);
            Date returnDate = (Date) sdfForm.parse(returnDateStr);
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/travel_management_system";
            String dbUser = "root";
            String dbPassword = "root";
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            
            
            
         // Convert the java.util.Date to java.sql.Date
            java.sql.Date sqlDepartureDate = new java.sql.Date(departureDate.getTime());
            java.sql.Date sqlReturnDate = new java.sql.Date(returnDate.getTime());

            // Insert the trip details into the 'trips' table, including 'name' and 'email'
            String sql = "INSERT INTO trips (email, name, origin, destination, departure_date, return_date, number_of_travelers, preferred_airline, hotel_type, car_rental_type) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, email); // Set the 'email' obtained from the session
            pstmt.setString(2, name); // Set the 'name' obtained from the session
            pstmt.setString(3, origin);
            pstmt.setString(4, destination);
            pstmt.setDate(5, sqlDepartureDate);
            pstmt.setDate(6, sqlReturnDate);
            pstmt.setInt(7, numberOfTravelers);
            pstmt.setString(8, preferredAirline);
            pstmt.setString(9, hotelType);
            pstmt.setString(10, carRentalType);
            pstmt.executeUpdate();

            conn.close();
            out.println("<script type=\"text/javascript\">");
            out.println("alert('Trip Booked Successfully')");
            out.println("location='user_dashboard.jsp';");
            out.println("</script>"); // Redirect to contact page after successful sign up
        
        } catch (ParseException e) {
            e.printStackTrace();
            // Handle the ParseException appropriately
            response.sendRedirect("index.jsp"); // Redirect to an error page
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            // Handle other exceptions related to database connectivity or queries
            response.sendRedirect("index.jsp"); // Redirect to an error page
        } catch (Exception ex) {
            ex.printStackTrace();
            // Handle other general exceptions
            response.sendRedirect("error.jsp"); // Redirect to an error page
        }
    }
}


