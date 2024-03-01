package com.login.pack;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/StudentInfoServlet")
public class StudentInfoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
	    response.setHeader("Expires", "0"); // Proxies
    	
    	response.setContentType("text/html");

	    PrintWriter out  =  response.getWriter();
	    String userId = request.getParameter("userId");
	    
	    System.out.println(userId);	    
		//JDBC Connection
		String url = "jdbc:mysql://localhost:3306/astubankingdb";

        // Retrieve account information from the database
        try{
        	// Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Create a connection to the database
            Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
 
            String query = "SELECT account_number, account_balance, created_at FROM accounts WHERE user_id = ?";
            PreparedStatement statement = conn.prepareStatement(query);
            statement.setString(1, userId);
            
            ResultSet rs = statement.executeQuery(query);
            if (rs.next()) {
            	String accountNumber = rs.getString("account_number");
            	Double accountBalance = rs.getDouble("account_balance");
            	String createdAt = rs.getString("created_at");
	                 
	            // Convert accountBalance to String
            	String accountBalanceString = String.valueOf(accountBalance);
	
		       // Store the account information in request attributes
            	request.setAttribute("accountNumber", accountNumber);
            	request.setAttribute("accountBalance", accountBalanceString);
            	request.setAttribute("createdAt", createdAt);

            } else {
                request.setAttribute("errorMessage", "Invalid login");
                request.getRequestDispatcher("BankLogin.jsp").forward(request, response);
            }
            rs.close();
            statement.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        // Forward the request to the StudentDashboard.jsp page
        request.getRequestDispatcher("/StudentDashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}