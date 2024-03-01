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

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 // Add cache-control headers
//	    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
//	    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
//	    response.setHeader("Expires", "0"); // Proxies
		
	    response.setContentType("text/html");

	    PrintWriter out  =  response.getWriter();
	    String userId = request.getParameter("userId");
		String userPwd = request.getParameter("password");
		//JDBC Connection
		String url = "jdbc:mysql://localhost:3306/astubankingdb";
		try {
	            // Load the MySQL JDBC driver
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            // Create a connection to the database
	            Connection conn = DriverManager.getConnection(url, "root", "Babitilahun");
	            Statement st = conn.createStatement();
	            
	            String query = "select * from Users where user_id = '"+userId+"' and password = '"+userPwd+"'";
	            
	            ResultSet rs = st.executeQuery(query);
	            if (rs.next()) {
	                String role = rs.getString("role");
	                String username = rs.getString("username");
	                
	                String Accountquery = "SELECT * FROM AstuBankAccounts WHERE user_id = ?";
	                
	                PreparedStatement statement = conn.prepareStatement(Accountquery);
	                statement.setString(1, userId);
	                ResultSet resultSet = statement.executeQuery();
	     
	               
	                if (resultSet.next()) {
	                    double accountBalance = resultSet.getDouble("account_balance");
	                    String accountNumber = resultSet.getString("account_number");   
	                    
	                 // Convert accountBalance to String
	                	String accountBalanceStr = String.valueOf(accountBalance);
	                	System.out.println(userId);
	                	System.out.println(accountBalanceStr);
	                	System.out.println(accountNumber);
	                    
	                    
		                HttpSession session = request.getSession();
		                session.setAttribute("userid", userId);
		                session.setAttribute("username", username);
		                session.setAttribute("accountBalance", accountBalanceStr);
		                session.setAttribute("accountNumber", accountNumber);
		                
		                if (role.equals("Student")) {
		                	request.setAttribute("userId", userId);
		                	request.setAttribute("username", username);
		                	request.setAttribute("accountBalance", accountBalance);
		                	request.setAttribute("accountNumber", accountNumber);
		                	response.sendRedirect("StudentDashboard.jsp");
		                } else {
		                	response.sendRedirect("StudentInfoServlet");
		                    response.sendRedirect("StaffDashboard.jsp");
		                }
	                }
	            } else {
	                request.setAttribute("errorMessage", "Invalid login");
	                request.getRequestDispatcher("BankLogin.jsp").forward(request, response);
	            }
	            rs.close();
	            st.close();
	            conn.close();
	    } catch (ClassNotFoundException | SQLException e) {
	        out.print("<h1>Login Failed! because of server exception</h1><br>");
	        e.printStackTrace();
	    }
	}

}
