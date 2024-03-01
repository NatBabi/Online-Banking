package com.login.pack;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class moneyTransfer
 */
@WebServlet("/moneyTransfer")
public class moneyTransfer extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	    response.setHeader("Expires", "0"); // Proxies
		
		response.setContentType("text/html");
//	    PrintWriter out  =  response.getWriter();
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userid");
		
		
		
		String transferAmount = request.getParameter("transferAmount");
        String transferType = request.getParameter("transferType");
        String otherBankName = request.getParameter("otherBankName");
        String transferTo = request.getParameter("TransferName");
        String transferReason = request.getParameter("TransferReason");
//        String userId = request.getParameter("userId");
        
         
//			String transferAmount = "400";
//			String transferType = "ASTU Bank";
//			String otherBankName = null;
//			String transferTo = "5556788690";
//			String userId = "U300";
		System.out.println(userId);
        System.out.println(transferType);
        
//        System.out.println(transferAmount);
//        System.out.println(otherBankName);
		
		//JDBC Connection
		String url = "jdbc:mysql://localhost:3306/astubankingdb";
		try {
			// Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create a connection to the database
            Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
            // Check user's account balance
            Statement stmt = conn.createStatement();
            String Accountquery = "SELECT * FROM AstuBankAccounts WHERE user_id = ?";
         
            PreparedStatement statement = conn.prepareStatement(Accountquery);
            statement.setString(1, userId);
            ResultSet resultSet = statement.executeQuery();
 
           
            if (resultSet.next()) {
            	
                double accountBalanceSender = resultSet.getDouble("account_balance");
                String accountNumberSender = resultSet.getString("account_number");
                // Check if the balance is sufficient for the transfer
                if (accountBalanceSender >= Double.parseDouble(transferAmount)) {
                    // Transfer to another account (handle transferType and otherBankName appropriately)
                    if (transferType.equals("ASTU Bank")) {
                        // Handle transfer to ASTU Bank
                    	String query_o = "SELECT * FROM AstuBankAccounts WHERE account_number = '"+transferTo+"'";
                    	
                    	ResultSet rs = stmt.executeQuery(query_o);
         	            if (rs.next() && !(transferTo.equals(accountNumberSender))) {
         	            	
         	            // Convert accountBalance to String
    	                	String accountBalanceStr = String.valueOf(accountBalanceSender);
         	            	
        	                session.setAttribute("userid", userId);
    		                session.setAttribute("accountBalance", accountBalanceStr);
    		                session.setAttribute("accountNumber", accountNumberSender);
         	            	
         	            	double accountBalRecever = rs.getDouble("account_balance");
         	            	String userIdR = rs.getString("user_id");
         	            	
         	            	System.out.println("Old Sender Balance: " + accountBalanceSender);
         	            	System.out.println("Old Reciever Balance: " + accountBalRecever);
         	            	
         	            	
         	            	double senderNewBalance = accountBalanceSender - Double.parseDouble(transferAmount);
         	            	double recieverNewBalance = accountBalRecever + Double.parseDouble(transferAmount);
         	            	
         	            	System.out.println("New Sender Balance: " + senderNewBalance);
         	            	System.out.println("New Reciever Balance: " + recieverNewBalance);
         	            	
         	            	//Update Sender balance
         	            	String updateQuery = "UPDATE AstuBankAccounts SET account_balance = ? WHERE user_id = ?";
                            PreparedStatement updateStatementS = conn.prepareStatement(updateQuery);
                            updateStatementS.setDouble(1, senderNewBalance);
                            updateStatementS.setString(2, userId);
                            updateStatementS.executeUpdate();
                            
                            
                            Double transferAmountInDoub = Double.valueOf(transferAmount);
                            String insertTransQuery = "INSERT INTO Transactions (user_id, account_numberFrom, account_numberTo, amount, transaction_type, description)"
                            		+ "VALUES (?, ?, ?, ?, ?, ?);";
                            PreparedStatement insertTranStatementS = conn.prepareStatement(insertTransQuery);
                            insertTranStatementS.setString(1, userId);
                            insertTranStatementS.setString(2, accountNumberSender);
                            insertTranStatementS.setString(3, transferTo);
                            insertTranStatementS.setDouble(4, transferAmountInDoub);
                            insertTranStatementS.setString(5, "withdraw");
                            insertTranStatementS.setString(6, transferReason);
                            // Execute the prepared statement
                            insertTranStatementS.executeUpdate();
                            
                            
                            
                            //Update Receiver Balance
                            String updateQueryR = "UPDATE AstuBankAccounts SET account_balance = ? WHERE user_id = ?";
                            PreparedStatement updateStatementR = conn.prepareStatement(updateQueryR);
                            updateStatementR.setDouble(1, recieverNewBalance);
                            updateStatementR.setString(2, userIdR);
                            updateStatementR.executeUpdate(); 
                            
                         
                            String insertTransQueryRe = "INSERT INTO Transactions (user_id, account_numberFrom, account_numberTo, amount, transaction_type, description)"
                            		+ "VALUES (?, ?, ?, ?, ?, ?);";
                            PreparedStatement insertTranStatementR = conn.prepareStatement(insertTransQueryRe);
                            insertTranStatementR.setString(1, userIdR);
                            insertTranStatementR.setString(2, accountNumberSender);
                            insertTranStatementR.setString(3, transferTo);
                            insertTranStatementR.setDouble(4, transferAmountInDoub);
                            insertTranStatementR.setString(5, "deposit");
                            insertTranStatementR.setString(6, transferReason);
                            // Execute the prepared statement
                            insertTranStatementR.executeUpdate();
                            
                            
                            request.setAttribute("userId", userId);
                            request.setAttribute("accountBalance", accountBalanceStr);
		                	request.setAttribute("accountNumber", accountNumberSender);
    	                	//response.sendRedirect("TransactionServlet");
                            System.out.println("Transfer Succesfully!!");
                            
                            request.setAttribute("accountSuccessMessage", "Transfer Succesfully!!");
                            request.getRequestDispatcher("UserTransfer.jsp").forward(request, response);
                           
                            
         	            } else {
         	                request.setAttribute("accountErrorMessage", "Invlaid Account Number");
         	                request.getRequestDispatcher("UserTransfer.jsp").forward(request, response);
         	            }
                    	
                    } else if (transferType.equals("Other Bank")) {
                        // Handle transfer to other bank
						String query_o = "SELECT * FROM OtherBankAccounts WHERE account_number = '"+transferTo+"' AND bank_name = '"+otherBankName+"'";
						ResultSet otherBankresultset = stmt.executeQuery(query_o);
						if (otherBankresultset.next() && !(transferTo.equals(accountNumberSender))) {
							 // Convert accountBalance to String
    	                	String accountBalanceStr = String.valueOf(accountBalanceSender);
         	            	
        	                session.setAttribute("userid", userId);
    		                session.setAttribute("accountBalance", accountBalanceStr);
    		                session.setAttribute("accountNumber", accountNumberSender);
         	            	
         	            	double accountBalRecever = otherBankresultset.getDouble("account_balance");
         	            	String userIdR = otherBankresultset.getString("user_id");
         	            	
         	            	System.out.println("Old Sender Balance: " + accountBalanceSender);
         	            	System.out.println("Old Reciever Balance: " + accountBalRecever);
         	            	
         	            	
         	            	double senderNewBalance = accountBalanceSender - Double.parseDouble(transferAmount);
         	            	double recieverNewBalance = accountBalRecever + Double.parseDouble(transferAmount);
         	            	
         	            	System.out.println("New Sender Balance: " + senderNewBalance);
         	            	System.out.println("New Reciever Balance: " + recieverNewBalance);
         	            	
         	            	//Update Sender balance
         	            	String updateQuery = "UPDATE OtherBankAccounts SET account_balance = ? WHERE user_id = ?";
                            PreparedStatement updateStatementS = conn.prepareStatement(updateQuery);
                            updateStatementS.setDouble(1, senderNewBalance);
                            updateStatementS.setString(2, userId);
                            updateStatementS.executeUpdate();
                            
                            
                            Double transferAmountInDoub = Double.valueOf(transferAmount);
                            String insertTransQuery = "INSERT INTO Transactions (user_id, account_numberFrom, account_numberTo, amount, transaction_type, description)"
                            		+ "VALUES (?, ?, ?, ?, ?, ?);";
                            PreparedStatement insertTranStatementS = conn.prepareStatement(insertTransQuery);
                            insertTranStatementS.setString(1, userId);
                            insertTranStatementS.setString(2, accountNumberSender);
                            insertTranStatementS.setString(3, transferTo);
                            insertTranStatementS.setDouble(4, transferAmountInDoub);
                            insertTranStatementS.setString(5, "withdraw");
                            insertTranStatementS.setString(6, transferReason);
                            // Execute the prepared statement
                            insertTranStatementS.executeUpdate();
                            
                            
                            
                            //Update Receiver Balance
                            String updateQueryR = "UPDATE OtherBankAccounts SET account_balance = ? WHERE otheruser_id = ?";
                            PreparedStatement updateStatementR = conn.prepareStatement(updateQueryR);
                            updateStatementR.setDouble(1, recieverNewBalance);
                            updateStatementR.setString(2, userIdR);
                            updateStatementR.executeUpdate(); 
                            
                         
                            String insertTransQueryRe = "INSERT INTO Transactions (user_id, account_numberFrom, account_numberTo, amount, transaction_type, description)"
                            		+ "VALUES (?, ?, ?, ?, ?, ?);";
                            PreparedStatement insertTranStatementR = conn.prepareStatement(insertTransQueryRe);
                            insertTranStatementR.setString(1, userIdR);
                            insertTranStatementR.setString(2, accountNumberSender);
                            insertTranStatementR.setString(3, transferTo);
                            insertTranStatementR.setDouble(4, transferAmountInDoub);
                            insertTranStatementR.setString(5, "deposit");
                            insertTranStatementR.setString(6, transferReason);
                            // Execute the prepared statement
                            insertTranStatementR.executeUpdate();
                            
                            
                            request.setAttribute("userId", userId);
                            request.setAttribute("accountBalance", accountBalanceStr);
		                	request.setAttribute("accountNumber", accountNumberSender);
    	                	//response.sendRedirect("TransactionServlet");
                            System.out.println("Transfer Succesfully!!");
                            
                            request.setAttribute("accountSuccessMessage", "Transfer Succesfully!!");
                            request.getRequestDispatcher("UserTransfer.jsp").forward(request, response);
                           
						}
                    }

//                    System.out.println("<h1>Transfer successful!</h1>");
                } else {
                    // Insufficient balance
                	request.setAttribute("errorMessage", "Insufficent Balance");
 	                request.getRequestDispatcher("UserTransfer.jsp").forward(request, response);
                    System.out.println("<h1>Insufficient Balance</h1>");
                }
            } else {
                // User not found
                System.out.println("<h1>User not found</h1>");
            }
		}catch(ClassNotFoundException | SQLException e) {
	        System.out.println("<h1>Transfer Failed! because of server exception</h1><br>");
	        e.printStackTrace();
	    }
	}

	
}
