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
               <li class="nav-item active">
                <a class="nav-link" href="UserTransfer.jsp"> Transfer<span class="sr-only">(current)</span></a>
              </li>
              
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="background-color: #170c64;">
                  Payment
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                  <a class="dropdown-item" href="RegistrarPayment.jsp">Registrar </a>
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
				  <a class="dropdown-item" href="LoanPayment.jsp">Loan Repayment</a>
                  <a class="dropdown-item" href="LoanHistory.jsp">Loan History</a>
                </div>
              </li>
              </li>
              <li class="nav-item">
              	<form action="LogoutServlet" >
              		<button class="nav-link" type="submit" style="border: none;"><i class="fa fa-user" aria-hidden="true"></i>Logout</button>
				</form>
              </li>
            </ul>
          </div>
        </nav>
      </div>
    </header>
    <!-- end header section -->
  </div>

  <!-- about section -->

  <section class="about_section layout_padding">
    <div class="apply-area pt-150 pb-150" style="background-color: #00204A;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="apply-wrapper">
                    <form id="moneyTransferForm" action="moneyTransfer" method="POST">
					    <div class="row">
					        <div class="col-lg-6">
					            <div class="form-group">
					                <label for="transferAmount">* TRANSFER AMOUNT ($)</label>
					                <input type="text" class="form-control" name="transferAmount" placeholder="Enter transfer amount" id="transferAmount">
					            </div>
					        </div>
					        <div class="col-lg-6">
					            <div class="form-group">
					                <label for="transferType">* TRANSFER TYPE</label>
					                <select class="form-control" name="transferType" id="transferType">
					                    <option value="ASTU Bank">To ASTU Bank</option>
					                    <option value="Other Bank">To Other Bank</option>
					                </select>
					            </div>
					        </div>
					        <div class="col-lg-12 other-bank" style="display: none;">
					            <div class="form-group">
					                <label for="otherBankName">* OTHER BANK NAME</label>
					                <input type="text" class="form-control" name="otherBankName" placeholder="Enter other bank name" id="otherBankName">
					            </div>
					        </div>
					        <div class="col-lg-12 transfer-to">
					            <div class="form-group">
					                <label>* TransferTo:</label>
					                <input type="text" class="form-control" name="TransferName" placeholder="Enter transfer to" id="transferTo">
					            </div>
					        </div>
					        <div class="col-lg-12 transfer-to">
					            <div class="form-group">
					                <label>* Reason:</label>
					                <input type="text" class="form-control" name="TransferReason" placeholder="Description" id="transferReason">
					            </div>
					        </div>
					    </div>
					    <br>
					    <button type="submit" class="btn btn-primary apply-btn mt-30">TRANSFER NOW</button>
					    <button type="button" class="btn btn-primary apply-btn mt-30" data-toggle="modal" data-target="#confirmModal">View Info</button>
					    <c:if test="${not empty accountErrorMessage}">
				          <p id="accountErrorMessage" style="color: white; text-align: center; background-color: #00204A">${accountErrorMessage}</p>
				        </c:if>
				         <c:if test="${not empty accountSuccessMessage}">
				          <p id="accountErrorMessage" style="color: white; text-align: center; background-color: #00204A">${accountErrorMessage}</p>
				        </c:if>
				</form>
	          </div>
            </div>
	      </div>
	    </div>
		</div>
  </section>
  <!-- Modal -->
	<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="confirmModalLabel">View Transfer</h5>
	                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                    <span aria-hidden="true">&times;</span>
	                </button>
	            </div>
	            <div class="modal-body">
	                <p>Transfer Amount: <span id="confirmTransferAmount"></span></p>
	                <p>Transfer Type: <span id="confirmTransferType"></span></p>
	                <p>Other Bank Name: <span id="confirmOtherBankName"></span></p>
	                <p>Transfer To: <span id="confirmTransferTo"></span></p>
	                <p>Reason: <span id="confirmTransferReason"></span></p>
	                <!-- Add more fields here as needed -->
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
	            </div>
	        </div>
	    </div>
	</div>

  <!-- end about section -->

  <!-- info section -->

  <section class="info_section layout_padding2">
    <div class="container">
      <div class="row">
        <div class="col-md-6 col-lg-3 info_col">
          <div class="info_contact">
            <h4>
              Address
            </h4>
            <div class="contact_link_box">
              <a href="">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>
                  Location
                </span>
              </a>
              <a href="">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  Call +01 1234567890
                </span>
              </a>
              <a href="">
                <i class="fa fa-envelope" aria-hidden="true"></i>
                <span>
                  demo@gmail.com
                </span>
              </a>
            </div>
          </div>
          <div class="info_social">
            <a href="">
              <i class="fa fa-facebook" aria-hidden="true"></i>
            </a>
            <a href="">
              <i class="fa fa-twitter" aria-hidden="true"></i>
            </a>
            <a href="">
              <i class="fa fa-linkedin" aria-hidden="true"></i>
            </a>
            <a href="">
              <i class="fa fa-instagram" aria-hidden="true"></i>
            </a>
          </div>
        </div>
        <div class="col-md-6 col-lg-3 info_col">
          <div class="info_detail">
            <h4>
              Info
            </h4>
            <p>
              necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful
            </p>
          </div>
        </div>
        <div class="col-md-6 col-lg-2 mx-auto info_col">
          <div class="info_link_box">
            <h4>
              Links
            </h4>
            <div class="info_links">
              <a class="active" href="StudentDashboard.jsp">
                Home
              </a>
              <a class="" href="Transfer.jsp">
                Transfer
              </a>
              <a class="" href="Payment.jsp">
                Payment
              </a>
              <a class="" href="Transacton.jsp">
                Transaction
              </a>
              <a class="" href="Loan.jsp">
                Loan
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
 
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
<script>
    $(document).ready(function() {
        $('#transferType').change(function() {
            if ($(this).val() === 'Other Bank') {
                $('.other-bank').show();
                $('.transfer-to').show();
            } else if ($(this).val() === 'ASTU Bank') {
                $('.other-bank').hide();
                $('.transfer-to').show();
            } else {
                $('.other-bank').hide();
                $('.transfer-to').hide();
            }
        });

        $('#confirmModal').on('show.bs.modal', function(event) {
            // Populate modal with form data when modal is shown
            $('#confirmTransferAmount').text($('#transferAmount').val());
            $('#confirmTransferType').text($('#transferType').val());
            $('#confirmTransferTo').text($('#transferTo').val()); // Use correct ID for TransferTo
            $('#confirmOtherBankName').text($('#otherBankName').val());
            $('#confirmTransferReason').text($('#transferReason').val());
        });
    });
</script>
<script>
// Get a reference to the paragraph element
  var paragraph = document.getElementById("accountErrorMessage");
  setTimeout(function() {
    paragraph.style.display = "none";
  }, 3000); 
</script>

</body>

</html>