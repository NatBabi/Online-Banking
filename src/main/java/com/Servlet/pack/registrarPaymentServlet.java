package com.login.pack;

import java.io.IOException;
import java.sql.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class registrarPaymentServlet
 */
@WebServlet("/registrarPaymentServlet")
public class registrarPaymentServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	    response.setHeader("Expires", "0"); // Proxies
	    
	    HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userid");
	
		String serviceName = request.getParameter("serviceName");
		double paymentAmount = Double.parseDouble(request.getParameter("paymentAmount"));
        
		System.out.println(userId);
        System.out.println(serviceName);
        
//        System.out.println(transferAmount);
//        System.out.println(otherBankName);
		
		//JDBC Connection
		String url = "jdbc:mysql://localhost:3306/astubankingdb";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
	        
            
            String serviceQuery = "SELECT * FROM Services WHERE service_name = ? AND service_status = 'active';";
            	
            	PreparedStatement serviceStatement = conn.prepareStatement(serviceQuery);
                serviceStatement.setString(1, serviceName);

                	ResultSet serviceResult = serviceStatement.executeQuery();
                    if (serviceResult.next()) {
                    	int serviceId = serviceResult.getInt("service_id");
                    	String serviceType = serviceResult.getString("service_type");
                    	
                        // Check user's balance
                        String balanceQuery = "SELECT account_balance FROM accounts WHERE user_id = ?;";

                        PreparedStatement balanceStatement = conn.prepareStatement(balanceQuery);
                        balanceStatement.setString(1, userId);

                        ResultSet balanceResult = balanceStatement.executeQuery();
                                if (balanceResult.next()) {
                                    double balance = balanceResult.getDouble("account_balance");
                                    // If balance is sufficient, process payment
                                    if (balance >= paymentAmount) {
                                        // Deduct payment amount from user's balance
                                        double newBalance = balance - paymentAmount;
                                        String updateBalanceQuery = "UPDATE accounts SET account_balance = ? WHERE user_id = ?;";
                                        try (PreparedStatement updateBalanceStatement = conn.prepareStatement(updateBalanceQuery)) {
                                            updateBalanceStatement.setDouble(1, newBalance);
                                            updateBalanceStatement.setString(2, userId);
                                            updateBalanceStatement.executeUpdate();
                                        }
                                        // Insert payment record
                                        String insertPaymentQuery = "INSERT INTO Payments (user_id, service_id, amount) VALUES (?, ?, ?);";

                                        	PreparedStatement insertPaymentStatement = conn.prepareStatement(insertPaymentQuery);
                                            insertPaymentStatement.setString(1, userId);
                                            insertPaymentStatement.setInt(2, serviceId);
                                            insertPaymentStatement.setDouble(3, paymentAmount);
                                            insertPaymentStatement.executeUpdate();

                                        
                                        if(serviceType.equals("registrar")) {
                                        	request.setAttribute("registrarSuccessMessage", "Payment successful!");
                         	                request.getRequestDispatcher("RegistrarPayment.jsp").forward(request, response);
                                        }else {
                                        	request.setAttribute("registrarSuccessMessage", "Payment successful!");
                         	                request.getRequestDispatcher("RegistrarPayment.jsp").forward(request, response);
                                        }
                                        
                                    } else {
                                        // Send insufficient balance error response
                                    	if(serviceType.equals("registrar")) {
                                        	request.setAttribute("registrarErrorMessage", "Payment Faild!! Insufficient balance!");
                         	                request.getRequestDispatcher("RegistrarPayment.jsp").forward(request, response);
                                        }else {
                                        	request.setAttribute("registrarErrorMessage", "Payment Faild!! Insufficient balance!");
                         	                request.getRequestDispatcher("OtherPaymentService.jsp").forward(request, response);
                                        }
                                    }
                                } else {
                                	request.setAttribute("registrarErrorMessage", "Payment Faild!! Balanceis Not Found");
                 	                request.getRequestDispatcher("RegistrarPayment.jsp").forward(request, response);
                 	                
                 	                request.setAttribute("registrarErrorMessage", "Payment Faild!! Balanceis Not Found");
                	                request.getRequestDispatcher("OtherPaymentService.jsp").forward(request, response);
                	                
                	             
                                }
                            }
                        }catch(ClassNotFoundException | SQLException e) {
                	        System.out.println("<h1>Transfer Failed! because of server exception</h1><br>");
                	        e.printStackTrace();
                    }
		}
	}
