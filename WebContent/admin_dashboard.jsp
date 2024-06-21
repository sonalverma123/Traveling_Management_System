<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
         <%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">

<head>
    <meta charset="utf-8">
    <title>TRAVELER</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet"> 

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>

<body>
    <!-- Topbar Start -->
    <div class="container-fluid bg-light pt-3 d-none d-lg-block">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 text-center text-lg-left mb-2 mb-lg-0">
                    <div class="d-inline-flex align-items-center">
                        <p><i class="fa fa-envelope mr-2"></i>traveler@example.com</p>
                        <p class="text-body px-3">|</p>
                        <p><i class="fa fa-phone-alt mr-2"></i>+012 345 6789</p>
                    </div>
                </div>
                <div class="col-lg-6 text-center text-lg-right">
                    <div class="d-inline-flex align-items-center">
                        <a class="text-primary px-3" href="">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a class="text-primary px-3" href="">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a class="text-primary px-3" href="">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a class="text-primary px-3" href="">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a class="text-primary pl-3" href="">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Topbar End -->


    <!-- Navbar Start -->
    <div class="container-fluid position-relative nav-bar p-0">
        <div class="container-lg position-relative p-0 px-lg-3" style="z-index: 9;">
            <nav class="navbar navbar-expand-lg bg-light navbar-light shadow-lg py-3 py-lg-0 pl-3 pl-lg-5">
                <a href="" class="navbar-brand">
                    <h1 class="m-0 text-primary"><span class="text-dark">TRAVEL</span>ER</h1>
                </a>
                <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse justify-content-between px-3" id="navbarCollapse">
                    <div class="navbar-nav ml-auto py-0">
                        <a href="index.jsp" class="nav-item nav-link active">Home</a>
                        <a href="about.jsp" class="nav-item nav-link">About</a>
                
                                <a href="destination.jsp" class="nav-item nav-link">Destination</a>
                              
                                <a href="testimonial.jsp" class="nav-item nav-link">Testimonial</a>
                                    <a href="Logout.jsp" class="nav-item nav-link">Logout</a>
                            </div>
                       
                </div>
            </nav>
        </div>
    </div>
    <!-- Navbar End -->

<div>


<body>


        <%-- JDBC Connection setup --%>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.naming.*" %>
        <%@ page import="javax.sql.*" %>

<%
try {
    // Load the JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish the connection to the database
    String url = "jdbc:mysql://localhost:3306/travel_management_system";
    String dbUser = "root";
    String dbPassword = "root";
    Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Prepare the SQL query to retrieve trip history for the logged-in user
    String sql = "SELECT * FROM users ";
    PreparedStatement pstmt = conn.prepareStatement(sql);
  

    // Execute the query
    ResultSet rs = pstmt.executeQuery();

    // Loop through the result set and display the trip history
     // Display data in an HTML table
%>

<div class="container">
    <div class="row mt-5">
        <div class="col-md-12">
            <h1 class="text-center mb-4">User Profiles</h1>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                            <tr>
                                <td><%= rs.getInt("id")%></td>
                                <td><%= rs.getString("name")%></td>
                                <td><%= rs.getString("email")%></td>
                                <td><%= rs.getString("phone")%></td>
                                <td>
                                    <button type="button" class="btn btn-primary" onclick="toggleForm(<%= rs.getInt("id") %>)">Edit</button>
                                    <button type="button" class="btn btn-danger" onclick="deleteUser(<%= rs.getInt("id") %>)">Delete</button>
                                    <div id="form-<%= rs.getInt("id") %>" style="display: none;">
                                        <form method="post" action="UpdateUser.jsp" class="mt-2">
                                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="name" value="<%= rs.getString("name") %>">
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="email" value="<%= rs.getString("email") %>">
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="phone" value="<%= rs.getString("phone") %>">
                                            </div>
                                            <button type="submit" class="btn btn-primary">Update</button>
                                        </form>
              </div>
            </td>
            
          </tr>
<% 
    }
    rs.close();
    pstmt.close();
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
    // Handle exceptions
}
%>
  </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Your existing JavaScript or add any additional script below -->
<!-- Add the JavaScript function to handle the update -->
<script>
  function toggleForm(id) {
    var form = document.getElementById("form-" + id);
    form.style.display = form.style.display === "none" ? "block" : "none";
  }

  // Corrected function name from 'deleteUser' to 'confirmDelete'
  function deleteUser(id) {
    console.log("Confirm Delete called for ID: " + id);
    var confirmDelete = confirm("Are you sure you want to delete this User?");
    if (confirmDelete) {
      console.log("Confirmed Delete. ID: " + id);
      window.location.href = "DeleteUser.jsp?id=" + id;
    } else {
      console.log("Cancelled Delete. ID: " + id);
    }
  }
</script>


       
       
        <%-- Retrieve trip history from the database using JDBC --%>
        <%@ page import="java.sql.*" %>
        <%@ page import="javax.naming.*" %>
        <%@ page import="javax.sql.*" %>

        <%-- Get the user's email from the session --%>
        <% String email = (String) session.getAttribute("email"); 
      //Check if the user is logged in
        if (email == null) {
         // Handle the case where the user is not logged in, e.g., redirect to a login page
         response.sendRedirect("contact.jsp");
         return;
        }
        %>

       

<%
try {
    // Load the JDBC driver
    Class.forName("com.mysql.jdbc.Driver");

    // Establish the connection to the database
    String url = "jdbc:mysql://localhost:3306/travel_management_system";
    String dbUser = "root";
    String dbPassword = "root";
    Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);

    // Prepare the SQL query to retrieve trip history for the logged-in user
    String sql = "SELECT * FROM trips";
    PreparedStatement pstmt = conn.prepareStatement(sql);


    // Execute the query
    ResultSet rs = pstmt.executeQuery();

    // Loop through the result set and display the trip history
     // Display data in an HTML table
%>

<div class="container">
    <div class="row mt-5">
        <div class="col-md-12">
            <h1 class="text-center mb-4">Trip History</h1>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Trip ID</th>
                            <th>Origin</th>
                            <th>Destination</th>
                            <th>Departure Date</th>
                            <th>Return Date</th>
                            <th>Number of Travelers</th>
                            <th>Preferred Airline</th>
                            <th>Hotel Type</th>
                            <th>Car Rental Type</th>
                            <th>Trip Status</th>
                            <th>Notification Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
         <% while (rs.next()) { %>
   <tr>
         <td><%= rs.getInt("trip_id")%></td>
         <td><%= rs.getString("origin")%></td>
         <td><%=  rs.getString("destination")%></td>
         <td><%=  rs.getString("departure_date")%></td>
         <td><%= rs.getString("return_date")%></td>
         <td><%=  rs.getInt("number_of_travelers")%></td>
         <td><%= rs.getString("preferred_airline")%></td>
         <td><%=  rs.getString("hotel_type")%></td>
         <td><%=  rs.getString("car_rental_type")%></td>
         <td><%= rs.getString("trip_status") %></td>
                <td><%= rs.getString("notification_status") %></td>
                <td>
                      <%
                String tripStatus = rs.getString("trip_status");
                String notificationStatus = rs.getString("notification_status");
                boolean isPending = tripStatus.equals("pending");
                boolean isUnread = notificationStatus.equals("unread");
            %>
            <% if (isPending) { %>
                <button id="button-<%= rs.getInt("trip_id") %>" type="button" class="btn btn-success" onclick="updateTripStatus(<%= rs.getInt("trip_id") %>, 'approved')">Approve</button>
                <button id="button-<%= rs.getInt("trip_id") %>" type="button" class="btn btn-danger" onclick="updateTripStatus(<%= rs.getInt("trip_id") %>, 'cancelled')">Cancel</button>
            <% } %>
            <!-- The notification indicator below will only be displayed if the notification is unread -->
            <% if (isUnread) { %>
                <span data-trip-id="<%= rs.getInt("trip_id") %>" class="notification-indicator"></span>
            <% } %>
                </td>
                <td>
              <button type="button" class="btn btn-primary" onclick="toggleForm(<%= rs.getInt("trip_id") %>)">Edit</button>
              <div id="form-<%= rs.getInt("trip_id") %>" style="display: none;">
                <form method="post" action="UpdateTripAdmin.jsp">
                  <input type="hidden" name="trip_id" value="<%= rs.getInt("trip_id") %>">
                  <input type="text" name="origin" value="<%= rs.getString("origin") %>">
                  <input type="text" name="destination" value="<%= rs.getString("destination") %>">
                  <input type="text" name="departureDate" value="<%= rs.getString("departure_date") %>">
                  <input type="text" name="returnDate" value="<%= rs.getString("return_date") %>">
                  <input type="text" name="numberOfTravelers" value="<%= rs.getInt("number_of_travelers") %>">
                  <input type="text" name="preferredAirline" value="<%= rs.getString("preferred_airline") %>">
                  <input type="text" name="hotelType" value="<%= rs.getString("hotel_type") %>">
                    <input type="text" name="carRentalType" value="<%= rs.getString("car_rental_type") %>">
                  <button type="submit" class="btn btn-primary">Update</button>
                </form>
              </div>
            </td>
            <td>
              <button type="button" class="btn btn-danger" onclick="deleteTrip(<%= rs.getInt("trip_id") %>)">Delete</button>
              <div class="delete-confirm" style="display: none;">
                <p>Are you sure you want to delete this trip?</p>
                <button class="btn btn-danger" onclick="confirmDelete(<%= rs.getInt("trip_id") %>)">Yes</button>
                <button class="btn btn-secondary cancel-delete-btn">No</button>
              </div>
            </td>
          </tr>
          <!-- Your existing JavaScript or add any additional script below -->
<script>
function updateTripStatus(trip_id, status) {
    fetch("UpdateTripStatus.jsp?trip_id=" + trip_id + "&status=" + status)
        .then(response => response.text())
        .then(data => {
            // Update the button text to "Approved" or "Cancelled" as needed
            const button = document.getElementById("button-" + trip_id);
            button.innerText = status.charAt(0).toUpperCase() + status.slice(1);

            // Hide the notification indicator for the approved/cancelled trip
            const notificationIndicator = document.querySelector(`[data-trip-id="${trip_id}"]`);
            notificationIndicator.style.display = "none";
        })
        .catch(error => console.error(error));
}
</script>

<script>
    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }
</script>
<% 
    }
    rs.close();
    pstmt.close();
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
    // Handle exceptions
}
%>
 </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Your existing JavaScript or add any additional script below -->
<!-- Add the JavaScript function to handle the update -->
<script>
  function toggleForm(trip_id) {
    var form = document.getElementById("form-" + trip_id);
    form.style.display = form.style.display === "none" ? "block" : "none";
  }

  function deleteTrip(trip_id) {
    var confirmDelete = confirm("Are you sure you want to delete this Trip?");
    if (confirmDelete) {
      window.location.href = "DeleteTripAdmin.jsp?trip_id=" + trip_id;
    }
  }
</script>

<!-- Custom CSS styles -->
<style>
    /* Add some margin below the headers */
    .table th {
        margin-bottom: 5px;
    }

    /* Style the buttons in the table */
    .table .btn {
        margin-right: 5px;
    }

    /* Center the edit forms */
    .table form {
        margin: auto;
        width: 90%;
    }

    /* Add spacing between tables */
    hr.mb-5 {
        margin-top: 50px;
    }
</style>



<!-- Footer Start -->
    <div class="container-fluid bg-dark text-white-50 py-5 px-sm-3 px-lg-5" style="margin-top: 90px;">
        <div class="row pt-5">
            <div class="col-lg-3 col-md-6 mb-5">
                <a href="" class="navbar-brand">
                    <h1 class="text-primary"><span class="text-white">TRAVEL</span>ER</h1>
                </a>
                <p>Embark on unforgettable adventures with Traveler, your gateway to the world's most captivating destinations. Discover breathtaking landscapes, immerse yourself in diverse cultures, and create lifelong memories.</p>
                <h6 class="text-white text-uppercase mt-4 mb-3" style="letter-spacing: 5px;">Follow Us</h6>
                <div class="d-flex justify-content-start">
                    <a class="btn btn-outline-primary btn-square mr-2" href="#"><i class="fab fa-twitter"></i></a>
                    <a class="btn btn-outline-primary btn-square mr-2" href="#"><i class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-outline-primary btn-square mr-2" href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a class="btn btn-outline-primary btn-square" href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-5">
                <h5 class="text-white text-uppercase mb-4" style="letter-spacing: 5px;">Our Services</h5>
                <div class="d-flex flex-column justify-content-start">
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>About</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Destination</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Services</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Packages</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Guides</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Testimonial</a>
                    <a class="text-white-50" href="#"><i class="fa fa-angle-right mr-2"></i>Blog</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-5">
                <h5 class="text-white text-uppercase mb-4" style="letter-spacing: 5px;">Usefull Links</h5>
                <div class="d-flex flex-column justify-content-start">
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>About</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Destination</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Services</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Packages</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Guides</a>
                    <a class="text-white-50 mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Testimonial</a>
                    <a class="text-white-50" href="#"><i class="fa fa-angle-right mr-2"></i>Blog</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-5">
                <h5 class="text-white text-uppercase mb-4" style="letter-spacing: 5px;">Contact Us</h5>
                <p><i class="fa fa-map-marker-alt mr-2"></i>123 Street, New York, USA</p>
                <p><i class="fa fa-phone-alt mr-2"></i>+012 345 67890</p>
                <p><i class="fa fa-envelope mr-2"></i>traveler@gmail.com</p>
               
               
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid bg-dark text-white border-top py-4 px-sm-3 px-md-5" style="border-color: rgba(256, 256, 256, .1) !important;">
        <div class="row">
            <div class="col-lg-6 text-center text-md-left mb-3 mb-md-0">
                <p class="m-0 text-white-50">Copyright &copy; <a href="#">Domain</a>. All Rights Reserved.</a>
                </p>
            </div>
           
        </div>
    </div>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="fa fa-angle-double-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Contact Javascript File -->
    <script src="mail/jqBootstrapValidation.min.js"></script>
    <script src="mail/contact.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>