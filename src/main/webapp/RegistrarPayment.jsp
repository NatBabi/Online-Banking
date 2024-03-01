<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="">

  <title> ASTU BANK </title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!-- fonts style -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">

  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />

  <!-- font awesome style -->
  <link href="css/font-awesome.min.css" rel="stylesheet" />

  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />

</head>

<body class="sub_page">
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //HTTP 1.1
		response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		response.setHeader("Expires", "0"); // Proxies
	
		
	 	if(session.getAttribute("userid") == null){
	 		response.sendRedirect("BankLogin.jsp");
	 	}
	%>

  <div class="hero_area">

    <div class="hero_bg_box">
      <div class="bg_img_box">
        <img src="images/hero-bg.png" alt="">
      </div>
    </div>

    <!-- header section strats -->
    <header class="header_section">
      <div class="container-fluid">
        <nav class="navbar navbar-expand-lg custom_nav-container ">
          <a class="navbar-brand" href="StudentDashboard.jsp">
            <span>
              ASTU BANK
            </span>
          </a>

          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class=""> </span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav  ">
              <li class="nav-item ">
                <a class="nav-link" href="StudentDashboard.jsp">Home </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="UserTransfer.jsp"> Transfer</a>
              </li>
              
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: #170c64;">
                  Payment <span class="sr-only">(current)</span></a>
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                  <a class="dropdown-item" href="RegistrarPayment.jsp">Registrar</a>
                  <a class="dropdown-item" href="OtherPaymentService.jsp">Other Services</a>
                </div>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="Transaction.jsp">Transaction</a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: #170c64;">
                  Loan
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                  <a class="dropdown-item" href="Loan.jsp">Loan Request</a>
                  <a class="dropdown-item" href="RepayLoan.jsp">Loan Repayment</a>
                  <a class="dropdown-item" href="LoanHistory.jsp">Loan History</a>
                </div>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="BankLogin.jsp"> <i class="fa fa-user" aria-hidden="true"></i> Logout </a>
              </li>         
            </ul>
          </div>
        </nav>
      </div>
    </header>
    <!-- end header section -->
  </div>


  <!-- service section -->

  <section class="service_section layout_padding">
  <div class="service_container">
    <div class="container">
      <div class="heading_container heading_center">
        <h2>
          Student <span>Support Hub</span>
        </h2>
      </div>
      <div class="row justify-content-center">
        <div class="col-md-4">
          <div class="box">
            <div class="img-box">
              <img src="images/s1.png" alt="">
            </div>
            <div class="detail-box form-select">
               <h5>
	             Academic <span>Registrar</span>
	           </h5>
	            <p>
			      An Academic Registrar takes care of student records, academic rules, and helps with 
			      course registration at school.These services typically include: Transcript Request,
			      Withdrawal from Campus,Lost ID Card Replacement,etc...
			    </p>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="box">
           
            <div class="box">
            <div class="detail-box">
              <div class="d-flex flex-column align-items-center">
                
            <% 
			    String sql = "SELECT service_name FROM services WHERE service_type = 'registrar' AND service_status = 'active';";
			    String url = "jdbc:mysql://localhost:3306/astubankingdb";
			    try {
			        Class.forName("com.mysql.cj.jdbc.Driver");
			        Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
			        PreparedStatement preparedStatement = conn.prepareStatement(sql);
			        ResultSet resultSet = preparedStatement.executeQuery();
			        
			        List<String> serviceNames = new ArrayList<>();
			        while (resultSet.next()) {
			            String serviceName = resultSet.getString("service_name");
			            serviceNames.add(serviceName);
			        }
			        for (String serviceName : serviceNames){
			        	System.out.println(serviceName);
			        }
			        
			%>
			
			<div class="mb-3">
			    <h5>Academic <span>Registrar</span></h5>
			    <br>
			    <form id="paymentForm" action="registrarPaymentServlet" method="post">
			        <select class="form-select form-control" aria-label="Select service" name="serviceName" id="serviceName">
			            <% for (String serviceName : serviceNames) { %>
			                <option value="<%= serviceName %>"><%= serviceName %></option>
			            <% } %>
			        </select>
			        <br>
			        <div class="mb-3">
			            <input type="text" name="paymentAmount" class="form-control" placeholder="Enter the money">
			        </div>
			        <div class="mb-3">
			            <button type="submit" class="btn btn-primary">Send</button>
			        </div>
			    </form>
			</div>
			
			<%
			        conn.close(); // Close the database connection
			    } catch (ClassNotFoundException | SQLException e) {
			        e.printStackTrace();
			    }
			%>

              </div>
            </div>
          </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
  <!-- footer section -->

  <!-- jQery -->
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>

	</script>

  
  <!-- popper js -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <!-- bootstrap js -->
  <script type="text/javascript" src="js/bootstrap.js"></script>
  <!-- owl slider -->
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <!-- custom js -->
  <script type="text/javascript" src="js/custom.js"></script>
  <!-- Google Map -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCh39n5U-4IoWpsVGUHWdqB6puEkhRLdmI&callback=myMap">
  </script>
  <!-- End Google Map -->

</body>

</html>