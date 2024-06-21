package Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/travel_management_system";
            String dbUser = "root";
            String dbPassword = "root";
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Check if user with given email and password exists in the 'users' table
            String role = null; // Initialize role variable
            int userId = 0; // Initialize userId variable
            
            

            // Check if user with given email and password exists in the 'users' table
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                role = "user";
           //   userId = rs.getInt("user_id"); // Retrieve the user_id from the 'users' table
                // Store the user's email and user_id in the session
                
                request.getSession().setAttribute("email", email);
        //    request.getSession().setAttribute("userId", userId);
            request.getSession().setAttribute("role", role);
                request.getSession().setAttribute("name", rs.getString("name"));
                request.getSession().setAttribute("phone", rs.getString("phone")); // Assuming you have a 'phone' field in the users table
            } else {
                // Check if user with given email and password exists in the 'admins' table
                sql = "SELECT * FROM admins WHERE email=? AND password=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, email);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    role = "admin";
                    request.getSession().setAttribute("email", email);
                }
            }

            if (role != null) {
                if (role.equals("admin")) {
                    // Redirect to admin dashboard
                	  PrintWriter out = response.getWriter();
                      out.println("<script type=\"text/javascript\">");
                     
                      out.println("location='admin_dashboard.jsp';");
                      out.println("</script>");
                } else {
                    // Redirect to user dashboard
                	  PrintWriter out = response.getWriter();
                      out.println("<script type=\"text/javascript\">");
                    
                      out.println("location='user_dashboard.jsp';");
                      out.println("</script>");
                }
            } else {
                PrintWriter out = response.getWriter();
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Invalid email or password');");
                out.println("location='contact.jsp';");
                out.println("</script>");
            
            }

            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}