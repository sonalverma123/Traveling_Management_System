package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        try {
            // Connect to the database (same as before)
        	 Class.forName("com.mysql.jdbc.Driver");
             String url = "jdbc:mysql://localhost:3306/travel_management_system";
             String dbUser = "root";
             String dbPassword = "root";
             Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Update the user's profile data in the 'users' table
            String sql = "UPDATE users SET name=?, phone=? WHERE email=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, phone);
            pstmt.setString(3, email);
            pstmt.executeUpdate();

            // Update the session attributes with the new values
            request.getSession().setAttribute("name", name);
            request.getSession().setAttribute("phone", phone);

            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        // Redirect the user back to the dashboard after updating the profile
        response.sendRedirect("user_dashboard.jsp");
    }
}