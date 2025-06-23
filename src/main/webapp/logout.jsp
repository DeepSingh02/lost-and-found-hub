<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Logout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .logout-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .logout-card {
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
    </style>
    <script>
        // Redirect after 3 seconds
        setTimeout(function() {
            window.location.href = "login.jsp";
        }, 3000);
    </script>
</head>
<body>
    <%
        // Invalidate the session
        session.invalidate();
    %>
    
    <div class="logout-container">
        <div class="logout-card bg-white">
            <div class="mb-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="#28a745" class="bi bi-check-circle" viewBox="0 0 16 16">
                    <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                    <path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z"/>
                </svg>
            </div>
            <h3 class="mb-3">Logged Out Successfully</h3>
            <p class="text-muted">You have been securely logged out of your account.</p>
            <p class="text-muted">Redirecting to login page...</p>
            <div class="spinner-border text-success mt-3" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>
    </div>
</body>
</html>