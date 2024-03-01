<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
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
                  Payment
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
                  <a class="dropdown-item" href="Loan.jsp">Loan Request<span class="sr-only">(current)</span></a>
                  <a class="dropdown-item" href="LoanPayment.jsp">Loan Repayment</a>
                  <a class="dropdown-item" href="LoanHistory.jsp">Loan History</a>
                </div>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="BankLogin.jsp"> <i class="fa fa-user" aria-hidden="true"></i> Logout </a>
              </li>
              <form class="form-inline">
                <button class="btn  my-2 my-sm-0 nav_search-btn" type="submit">
                  <i class="fa fa-search" aria-hidden="true"></i>
                </button>
              </form>
            </ul>
          </div>
        </nav>
      </div>
    </header>
    <!-- end header section -->
  </div>

  <!-- team section -->
<section class="why_section layout_padding">
    <div class="container">
            <h2>Loan History</h2>
            <div class="table-responsive">
			  <table class="table table-bordered" style="border-color: #0BBBF0; border-width: 3px">
			  <thead>
                <tr>
                    <th scope="col">LoanID</th>
                    <th scope="col">CustomerID</th>
                    <th scope="col">Loan Type</th>
                    <th scope="col">Loan Amount</th>
                    <th scope="col">Status</th>
                    <th scope="col">Loan Reason</th>
                </tr>
            </thead>
            <tbody>
                <% 
                	String userId = (String) session.getAttribute("userid");
                    String sql = "SELECT * FROM LoanRequests WHERE user_id ='"+userId+"'";
                    String url = "jdbc:mysql://localhost:3306/astubankingdb";
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
                        PreparedStatement preparedStatement = conn.prepareStatement(sql);
                        ResultSet resultSet = preparedStatement.executeQuery();
                        while (resultSet.next()) {
                            int loanId = resultSet.getInt("loan_id");
                            String loasType = resultSet.getString("loan_type");
                            String loanStatus = resultSet.getString("status");
                            Double loanAmount = resultSet.getDouble("loan_amount");
                            String loanReason = resultSet.getString("loan_reason");
                %>
                <tr>
                    <td><%=loanId %></td>
                    <td><%=userId %></td>
                    <td><%=loasType %></td>
                    <td><%=loanAmount %></td>
                    <td><%=loanStatus %></td>
                    <td><%=loanReason %></td>
                </tr>
                <% 
                        }
                        conn.close(); // Close the database connection
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
			  </table>
    </div>
  </section>
  <!-- end team section -->

  <!-- info section -->

  
  <!-- end info section -->

  <!-- footer section -->
  
  <!-- footer section -->
  


  <!-- jQery -->
  <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
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
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <!-- End Google Map -->
  
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    // Capture form values and set modal content on View button click
    $('.apply-btn[data-target="#viewModal"]').click(function() {
      var loanType = $('#loanType').val();
      var loanAmount = $('#loanAmount').val();
      var loanReason = $('#loanReason').val();

      $('#loanTypeDisplay').text("Loan Type: " + loanType);
      $('#loanAmountDisplay').text("Loan Amount: " + loanAmount);
      $('#loanReasonDisplay').text("Loan Reason: " + loanReason);
    });
  });
</script>
<script>
// Get a reference to the paragraph element
	var paragraph = document.getElementById("loanErrorMessage");
	setTimeout(function() {
		paragraph.style.display = "none";
	}, 50);
	var paragraphtwo = document.getElementById("loanSuccessMessage");
	setTimeout(function() {
		paragraph.style.display = "none";
	}, 50);
</script>

</body>

</html>