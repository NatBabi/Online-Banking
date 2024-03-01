package com.login.pack;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loanPaymentServlet")
public class loanPaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	    response.setHeader("Expires", "0"); // Proxies
    	
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userid");
        String loanId1 = (String) session.getAttribute("loanId");
        String loanId = request.getParameter("loanId");

        System.out.println("LoanId1: " + loanId1);
        System.out.println("LoanId: " + loanId);

        String url = "jdbc:mysql://localhost:3306/astubankingdb";
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create a connection to the database
            Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");

            // Check if loanId exists in LoanRequests table and status is "approved"
            String loanQuery = "SELECT COUNT(*) AS num_requests, status FROM LoanRequests WHERE loan_id = ?";
            PreparedStatement loanStatement = conn.prepareStatement(loanQuery);
            loanStatement.setString(1, loanId);
            ResultSet loanResult = loanStatement.executeQuery();

            if (loanResult.next()) {
                int numRequests = loanResult.getInt("num_requests");
                String status = loanResult.getString("status");

                if (numRequests > 0 && status.equals("approved")) {
                    // Update the status to "Provided" in LoanRequests table
                    String updateQuery = "UPDATE LoanRequests SET status = 'approved' WHERE loan_id = ?";
                    PreparedStatement updateStatement = conn.prepareStatement(updateQuery);
                    updateStatement.setString(1, loanId);
                    updateStatement.executeUpdate();

                    // Get userId and loan_amount from LoanRequests table
                    String loanDataQuery = "SELECT user_id, loan_amount FROM LoanRequests WHERE loan_id = ?";
                    PreparedStatement loanDataStatement = conn.prepareStatement(loanDataQuery);
                    loanDataStatement.setString(1, loanId);
                    ResultSet loanDataResult = loanDataStatement.executeQuery();

                    if (loanDataResult.next()) {
                        double loanAmount = loanDataResult.getDouble("loan_amount");

                        // Decrease (loan_amount * 0.06) from the user's account balance in accounts table
                        double decreaseAmount = loanAmount * 0.06;
                        String decreaseQuery = "UPDATE accounts SET account_balance = account_balance - ? WHERE user_id = ?";
                        PreparedStatement decreaseStatement = conn.prepareStatement(decreaseQuery);
                        decreaseStatement.setDouble(1, decreaseAmount);
                        decreaseStatement.setString(2, userId);
                        decreaseStatement.executeUpdate();
                        
		                session.setAttribute("userid", userId);
		                session.setAttribute("loanId", loanId);

                        request.setAttribute("loanSuccessMessage",
                                "Loan request submitted successfully. Status: ");
                        request.getRequestDispatcher("LoanPayment.jsp").forward(request, response);

                        // Rest of your code

                    } else {
                        // Loan data not found for the loanId
                        request.setAttribute("loanErrorMessage",
                                "Loan data not found for the specified loan ID");
                        request.getRequestDispatcher("LoanPayment.jsp").forward(request, response);
                    }
                } else {
                    // LoanId not found or status is not "approved"
                    request.setAttribute("loanErrorMessage", "Loan ID not found or status is not approved");
                    request.getRequestDispatcher("LoanPayment.jsp").forward(request, response);
                }
            } else {
                // LoanId not found in LoanRequests table
                request.setAttribute("loanErrorMessage", "Loan ID not found in the LoanRequests table");
                request.getRequestDispatcher("LoanPayment.jsp").forward(request, response);
            }

            // Close the database connections and statements
            loanResult.close();
            loanStatement.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("loanErrorMessage", "An error occurred while processing the loan request");
            request.getRequestDispatcher("LoanPayment.jsp").forward(request, response);
        }
    }
}