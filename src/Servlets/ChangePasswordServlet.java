package Servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = (String) request.getSession().getAttribute("email");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
    	PrintWriter out = response.getWriter();
        try {
            // Connect to the database (same as before)
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/travel_management_system";
            String dbUser = "root";
            String dbPassword = "root";
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Check if the user exists and the current password is correct
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, currentPassword);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Update the password in the 'users' table
                sql = "UPDATE users SET password=? WHERE email=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, newPassword);
                pstmt.setString(2, email);
                pstmt.executeUpdate();

                conn.close();

                // Redirect the user back to the dashboard after changing the password
                
                
                out.println("<script type=\"text/javascript\">");
                out.println("alert('password changed successfully')");
                out.println("location='user_dashboard.jsp';");
                out.println("</script>");
                
            } else {
                conn.close();
               
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Password changed failed')");
                out.println("location='change_password.jsp?error=1;");
                out.println("</script>");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}