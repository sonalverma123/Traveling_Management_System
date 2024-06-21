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


@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("userRole"); // Get the selected role from the form

        // Validate passwords match
        if (!password.equals(confirmPassword)) {
        	  out.println("<script type=\"text/javascript\">");
              out.println("alert('Passwords do not match')");
              out.println("location='contact.jsp';");
              out.println("</script>");
        }

        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/travel_management_system";
            String dbUser = "root";
            String dbPassword = "root";
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // Insert user data into the 'users' table
            String sql;
            if (role.equals("admin")) {
                sql = "INSERT INTO admins (name, email, phone, password) VALUES (?, ?, ?, ?)";
            } else {
                sql = "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)";
            }
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, phone);
            pstmt.setString(4, password);
            pstmt.executeUpdate();

            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }


  	  out.println("<script type=\"text/javascript\">");
      out.println("alert('Registration Successful')");
      out.println("location='contact.jsp';");
      out.println("</script>"); // Redirect to contact page after successful sign up
    }
}