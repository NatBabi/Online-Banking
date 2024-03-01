<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login page</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    body {
      background-color: #170c64; /* Darkblue */
    }
    
    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }
    
    .card {
      max-width: 400px;
      padding: 40px;
      background-color: white;
      border: 1px solid #00BBF0;
      border-radius: 5px;
      box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
    }
    
    img {
      width: 100px;
    }
    
    .title {
      text-align: center;
      color: #170c64;
    }
    
    .form-group label {
      color: #170c64;
      font-weight: bold;
    }
    
    .button-container {
      text-align: center;
      margin-top: 20px;
    }
    
    .button {
      background-color: #00BBF0;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 5px;
      cursor: pointer;
    }
</style>
</head>
<body>
  <div class="container">
    <div class="card">
      <h1 class="title">ASTU BANK</h1>
      <form action="LoginServlet" method="post">
        <div class="form-group">
          <label for="username">ID</label>
          <input type="text" id="username" name="userId" class="form-control" required>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" class="form-control" required>
        </div>
        <div class="button-container">
          <button type="submit" class="button">Login</button>
        </div>
        <c:if test="${not empty errorMessage}">
          <p id="errorMessage" style="color: red; text-align: center;">${errorMessage}</p>
        </c:if>
      </form>
    </div>
  </div>
  
  
  <script>
// Get a reference to the paragraph element
  var paragraph = document.getElementById("errorMessage");
  setTimeout(function() {
    paragraph.style.display = "none";
  }, 3000); 
</script>
</body>
</html>
