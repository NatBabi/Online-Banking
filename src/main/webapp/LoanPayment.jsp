<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
          <a class="navbar-brand" href="BankDashboard.jsp">
            <span>
              ASTU BANK
            </span>
          </a>

          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class=""> </span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav  ">
			  <li class="nav-item">
                <a class="nav-link" href="StudentDashboard.jsp">Home <span class="sr-only">(current)</span></a>
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
                <a class="nav-link" href="Transaction.jsp"> Transaction <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: #170c64;">
                  Loan <span class="sr-only">(current)</span>
                </a>
                <div class="dropdown-menu active" aria-labelledby="navbarDropdown">
                  <a class="dropdown-item" href="Loan.jsp">Loan Request</a>
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

  <!-- why section -->

  <section class="why_section layout_padding">
    <div class="container">
            <h2>Loan Repayment</h2>

	            <table class="table table-striped">
            <thead>
                <tr>
            		<th scope="col">Loan ID</th>
		            <th scope="col">Loan Amount</th>
		            <th scope="col">Repay Amount</th>
		            <th scope="col">Reason</th>
		            <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                	String userId = (String) session.getAttribute("userid");
                	String loanIdw = (String) session.getAttribute("loanId");
                	
                	
	                String loansql = "SELECT * FROM LoanRequests WHERE user_id = ? AND status = 'provided'";
	                String url = "jdbc:mysql://localhost:3306/astubankingdb";
	                System.out.println(userId);
	                
	                try {
	                    Class.forName("com.mysql.cj.jdbc.Driver");
	                    Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
	                    PreparedStatement preparedStatement = conn.prepareStatement(loansql);
	                    preparedStatement.setString(1, userId);
	                    ResultSet resultSet = preparedStatement.executeQuery();
                        while (resultSet.next()) {
                        	
                        	System.out.println("it works!");
                        	int loanId = resultSet.getInt("loan_id");
                            String loanType = resultSet.getString("loan_type");
                            String loanDate = resultSet.getString("application_date"); 
                            Double loanAmount = resultSet.getDouble("loan_amount");
                            String loanReason = resultSet.getString("loan_reason");
                            
                            
                         // Calculate interest (6%) and repay amount
                            double interest = 6.0; // Default interest rate
                            double repayAmount = loanAmount * (1 + interest / 100);
                            
                            System.out.println(loanType);
                            System.out.println(loanAmount);
                            System.out.println(loanReason);
                            
                %>
                <tr>
                    <td class="loanId"><%=loanId %></td>
		            <td class="loanAmount"><%=loanAmount %></td>
		            <td class="repayAmount"><%=repayAmount %></td>
		            <td class="loanReason"><%=loanReason %></td>
		            <td>
		                <div class="row">
				            <div class="col">
				                <button type="button" class="btn btn-primary info-btn mb-2" data-toggle="modal" data-target="#loanInfoModal">Info</button>
				            </div>
				            <div class="col">
				                <form id="loanPaymentForm" action="loanPaymentServlet" method="post">
				                    <input type="hidden" name="<%=loanId %>" value="loanId" class="form-control">
				                    <button type="submit" class="btn btn-danger">Pay</button>
				                </form>
				            </div>
				        </div>

		            </td>
                </tr>
               
            </tbody>
        </table>
    </div>
  </section>
  <!-- Modal structure -->
<div class="modal fade" id="loanInfoModal" tabindex="-1" role="dialog" aria-labelledby="loanInfoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loanInfoModalLabel">Loan Detail</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Loan ID: <%=loanId %></p>
                <p>Loan Type: <%=loanType %></p>
                <p>Loan Date: <%=loanDate %></span></p>
                <p>Loan Amount: <%=loanAmount %> Birr</p>
                <p>Interest (%): <%=interest %>(%)</p>
                <p>Repay Amount: <%=repayAmount %>Birr</p>
                <p>Loan Reason: <%=loanReason%></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

  <script>
    function payLoan(loanId) {
        // AJAX request to the servlet
        $.ajax({
            type: "POST",
            url: "loanPaymentServlet", // Replace with the actual URL of your servlet
            data: { loanId: loanId }, // Send the loanId as data
            success: function(response) {
                // Handle the success response (if needed)
                console.log("Payment successful!");
                // You can redirect the user to another page if needed
                window.location.href = "payment-success-page.jsp";
            },
            error: function(xhr, status, error) {
                // Handle errors (if any)
                console.error("Error:", error);
            }
        });
    }
</script>
		<% 
                       }
                        conn.close(); // Close the database connection
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    }
           %>
  
  <!-- end why section -->

  
<!-- Add this JavaScript code at the bottom of your HTML body or in a separate <script> tag -->



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
  <!-- End Google Map -->
</body>
</html>