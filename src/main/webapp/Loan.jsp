<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            </ul>
          </div>
        </nav>
      </div>
    </header>
    <!-- end header section -->
  </div>

  <!-- team section -->
	<section class="team_section layout_padding">
	  <div class="apply-area pt-150 pb-150" style="background-color: #00204A;">
	    <div class="container">
	      <div class="row justify-content-center">
	        <div class="col-lg-8">
	          <div class="apply-wrapper">
	            <div class="hero-area2 slider-height2 hero-overly2 d-flex align-items-center">
	              <div class="container">
	                <div class="row">
	                  <div class="col-xl-12">
	                    <div class="hero-cap text-center pt-50" style="color: #007BFF;">
	                      <h2>Loan Request</h2>
	                      <br>
	                    </div>
	                  </div>
	                </div>
	              </div>
	            </div>
	            <div class="row g-4">
	              <div class="col-md-6 wow fadeIn" data-wow-delay="0.2s" style="background-color: #00204A; align: justify; border-width:5px;  border-radius: 10px;  padding: 20px; text-align: justify; ">
	                 <p style="text-align: center"><strong>LOAN INFO</strong></p>
	                <p style="text-align: justify;">
	                  To request a loan, please ensure that you meet the following criteria:
	                </p>
	                <ul style="list-style-type: disc; padding-left: 20px; text-align: justify;">
	                  <li>You must have more than or equal to 4 deposit transactions in your transaction history.</li>
	                  <li>For Day Loans (100Br - 5000Br), repayment must be made within 24 hours.</li>
	                  <li>For Week Loans (5005Br - 10000Br), repayment must be made within 7 days.</li>
	                  <li>For Month Loans (10005Br - 50000Br), repayment must be made within 4 weeks.</li>
	                </ul>
	                <p style="text-align: justify;">
	                  Please note that the interest rate for all types of loans is 6%. Failure to repay the loan after the specified period will result in additional penalties.
	                </p>
	              </div>
	              <!-- Loan Info -->
	              <div class="col-md-6 wow fadeIn" data-wow-delay="0.1s">
	              <form action="loanRequest" method="POST">
	                  <div class="row">
	                    <div class="col-lg-12">
	                      <div class="form-group">
	                      <br>
	                      <br>
	                        <label for="loanType">* LOAN TYPE</label>
	                        <select class="form-control" name="loanType" id="loanType">
	                          <option value="dayLoan">In A Day (100Br - 5000Br)</option>
	                          <option value="weekLoan">In A Week (5,0005Br - 10,000Br)</option>
	                          <option value="monthLoan">In A Month (10,005Br - 50,000Br)</option>
	                        </select>
	                      </div>
	                    </div>
	                    <div class="col-lg-12">
	                      <div class="form-group">
	                      <br>
	                        <label for="loanAmount" >* LOAN AMOUNT (Birr)</label>
	                        <input type="text" class="form-control" name="loanAmount" placeholder="Enter loan amount" id="loanAmount">
	                       <br>
	                      </div>
	                    </div>
	                    <div class="col-lg-12">
	                      <div class="form-group">
	                        <label for="loanReason">* LOAN REASON</label>
	                        <input type="text" class="form-control" name="loanReason" placeholder="Enter reason for loan" id="loanReason">
	                        <br>
	                      </div>
	                    </div>
	                    <div class="col-lg-12">
	             
	                      <button type="submit" class="btn btn-primary apply-btn mt-30">APPLY NOW</button>
	                    </div>
	                  </div>
	                  <br>
	                  <c:if test="${not empty loanErrorMessage}">
	                    <p id="loanErrorMessage" class="alert alert-danger text-center">${loanErrorMessage}</p>
	                  </c:if>
	                  <c:if test="${not empty loanSuccessMessage}">
	                    <p id="loanSuccessMessage" class="alert alert-success text-center">${loanSuccessMessage}</p>
	                  </c:if>
	                </form>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	</section>

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
	var paragraph = document.getElementById("loanErrorMessage");
	setTimeout(function() {
	    paragraph.style.display = "none";
	}, 3000); // 300 seconds = 300,000 milliseconds
	
	var paragraphtwo = document.getElementById("loanSuccessMessage");
	setTimeout(function() {
	    paragraphtwo.style.display = "none";
	}, 3000);
	</script>

</body>

</html>