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
 * Servlet implementation class loanRequest
 */
@WebServlet("/loanRequest")
public class loanRequest extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	    response.setHeader("Expires", "0"); // Proxies
	    
		response.setContentType("text/html");
//	    PrintWriter out  =  response.getWriter();
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userid");
		
		
		
		String reqLoanAmount = request.getParameter("loanAmount");
        String reqLoanType = request.getParameter("loanType");
        String reqLoanReason = request.getParameter("loanReason");
        
//        System.out.println(reqLoanAmount);
//        System.out.println(reqLoanType);
//        System.out.println(reqLoanReason);
        
        String url = "jdbc:mysql://localhost:3306/astubankingdb";
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create a connection to the database
            Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
         // Check user's account balance
            Statement stmt = conn.createStatement();
            String loanQuery = "SELECT COUNT(*) AS num_requests FROM Transactions WHERE user_id = ? AND transaction_type = 'deposit'";
            PreparedStatement statement = conn.prepareStatement(loanQuery);
            statement.setString(1, userId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int numRequests = resultSet.getInt("num_requests");
                if (numRequests <= 3) {
                    // User has less than 4 deposit transactions
                    request.setAttribute("loanErrorMessage", "You are not eligible for a loan request. Please have at least 4 deposit transactions.");
                    request.getRequestDispatcher("Loan.jsp").forward(request, response);
                } else {
                    double reqAmount = Double.parseDouble(reqLoanAmount);
                    String insertLoanQuery = "INSERT INTO LoanRequests (user_id, loan_amount, loan_type, status, loan_reason) VALUES (?, ?, ?, ?, ?);";
                    PreparedStatement insertLoanStatement = conn.prepareStatement(insertLoanQuery);

                    if (reqLoanType.equals("dayLoan")) {
                        if (reqAmount >= 100.00 && reqAmount <= 5000.00) {
                            insertLoanStatement.setString(1, userId);
                            insertLoanStatement.setDouble(2, reqAmount);
                            insertLoanStatement.setString(3, "day");
                            insertLoanStatement.setString(4, "approved");
                            insertLoanStatement.setString(5, reqLoanReason);
                            // Execute the prepared statement
                            insertLoanStatement.executeUpdate();
                            String accountQuery = "SELECT * FROM accounts WHERE account_number = '" + userId + "'";
                            ResultSet rs = stmt.executeQuery(accountQuery);
                            if (rs.next()) {
                                double currentBalance = rs.getDouble("account_balance");
                                double updatedBalance = currentBalance + reqAmount;

                                // Update the user's balance in the accounts table
                                String updateBalanceQuery = "UPDATE accounts SET account_balance = ? WHERE account_number = ?";
                                PreparedStatement updateBalanceStatement = conn.prepareStatement(updateBalanceQuery);
                                updateBalanceStatement.setDouble(1, updatedBalance);
                                updateBalanceStatement.setString(2, userId);
                                updateBalanceStatement.executeUpdate();

                                request.setAttribute("balanceUpdtaeSuccessMessage", "Loan request submitted successfully. Status: Approved");
                                request.getRequestDispatcher("Loan.jsp").forward(request, response);
                            } else {
                                // Account not found for the user
                                request.setAttribute("loanErrorMessage", "Account not found for the specified user");
                                request.getRequestDispatcher("Loan.jsp").forward(request, response);
                            }
                        } else {
                            request.setAttribute("loanErrorMessage", "Invalid loan amount for 'In A Day' loan type. Please Try Again!!");
                            request.getRequestDispatcher("Loan.jsp").forward(request, response);
                        }
                    } else if (reqLoanType.equals("weekLoan")) {
                        if (reqAmount >= 5000.05 && reqAmount <= 10000.00) {
                            insertLoanStatement.setString(1, userId);
                            insertLoanStatement.setDouble(2, reqAmount);
                            insertLoanStatement.setString(3, "week");
                            insertLoanStatement.setString(4, "approved");
                            insertLoanStatement.setString(5, reqLoanReason);
                            // Execute the prepared statement
                            insertLoanStatement.executeUpdate();

                            String accountQuery = "SELECT * FROM accounts WHERE account_number = '" + userId + "'";
                            ResultSet rs = stmt.executeQuery(accountQuery);
                            if (rs.next()) {
                                double currentBalance = rs.getDouble("account_balance");
                                double updatedBalance = currentBalance + reqAmount;

                                // Update the user's balance in the accounts table
                                String updateBalanceQuery = "UPDATE accounts SET account_balance = ? WHERE account_number = ?";
                                PreparedStatement updateBalanceStatement = conn.prepareStatement(updateBalanceQuery);
                                updateBalanceStatement.setDouble(1, updatedBalance);
                                updateBalanceStatement.setString(2, userId);
                                updateBalanceStatement.executeUpdate();

                                request.setAttribute("balanceUpdtaeSuccessMessage", "Loan request submitted successfully. Status: Approved");
                                request.getRequestDispatcher("Loan.jsp").forward(request, response);
                            } else {
                                // Account not found for the user
                                request.setAttribute("loanErrorMessage", "Account not found for the specified user");
                                request.getRequestDispatcher("Loan.jsp").forward(request, response);
                            }
                        } else {
                            request.setAttribute("loanErrorMessage", "Invalid loan amount for 'In A Week' loan type. Please Try Again!!");
                            request.getRequestDispatcher("Loan.jsp").forward(request, response);
                        }
                    } else if (reqLoanType.equals("monthLoan")) {
                        if (reqAmount >= 10000.50 && reqAmount <= 50000.00) {
                            insertLoanStatement.setString(1, userId);
                            insertLoanStatement.setDouble(2, reqAmount);
                            insertLoanStatement.setString(3, "month");
                            insertLoanStatement.setString(4, "approved");
                            insertLoanStatement.setString(5, reqLoanReason);
                            // Execute the prepared statement
                            insertLoanStatement.executeUpdate();
                            String accountQuery = "SELECT * FROM accounts WHEREaccount_number = '" + userId + "'";
                            ResultSet rs = stmt.executeQuery(accountQuery);
                            if (rs.next()) {
                                double currentBalance = rs.getDouble("account_balance");
                                double updatedBalance = currentBalance + reqAmount;

                                // Update the user's balance in the accounts table
                                String updateBalanceQuery = "UPDATE accounts SET account_balance = ? WHERE account_number = ?";
                                PreparedStatement updateBalanceStatement = conn.prepareStatement(updateBalanceQuery);
                                updateBalanceStatement.setDouble(1, updatedBalance);
                                updateBalanceStatement.setString(2, userId);
                                updateBalanceStatement.executeUpdate();

                                request.setAttribute("balanceUpdtaeSuccessMessage", "Loan request submitted successfully. Status: Approved");
                                request.getRequestDispatcher("Loan.jsp").forward(request, response);
                            } else {
                                // Account not found for the user
                                request.setAttribute("loanErrorMessage", "Account not found for the specified user");
                                request.getRequestDispatcher("Loan.jsp").forward(request, response);
                            }
                        } else {
                            request.setAttribute("loanErrorMessage", "Invalid loan amount for 'In A Month' loan type. Please Try Again!!");
                            request.getRequestDispatcher("Loan.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("loanErrorMessage", "Invalid loan type.");
                        request.getRequestDispatcher("Loan.jsp").forward(request, response);
                    }
                }
            } else {
                // User not found
                System.out.println("<h1>User not found</h1>");
            }
        } catch (ClassNotFoundException | SQLException e) {
	        System.out.println("<h1>Transfer Failed! because of server exception</h1><br>");
	        e.printStackTrace();
	    }
	}

}
