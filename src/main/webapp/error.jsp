<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6e6;
            text-align: center;
            padding: 50px;
        }
        .container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        h2 {
            color: #dc3545;
        }
        .btn-container {
            margin-top: 20px;
        }
        .btn {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #c82333;
        }
        .btn-home {
            background-color: #007bff;
        }
        .btn-home:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: #721c24;
            background: #f8d7da;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Submission Failed!</h2>
        <p>Something went wrong. Please try again.</p>

        <%-- Display detailed error message (if available) --%>
        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
            <div class="error-message">
                <strong>Error Details:</strong> <%= errorMessage %>
            </div>
        <% } %>

        <div class="btn-container">
            <button class="btn" onclick="window.location.href='lost-item-form.jsp'">Retry</button>
            <button class="btn btn-home" onclick="window.location.href='index.jsp'">Go to Home</button>
        </div>
    </div>
</body>
</html>
