<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>

<%
    // Check if the user is logged in
    String userEmail = (String) session.getAttribute("userEmail");
    if (userEmail == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }

    // Get success or error message from URL parameters
    String successMessage = request.getParameter("success");
    String errorMessage = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose Form - Lost-and-Found Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Include SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4cc9f0;
            --error-color: #f72585;
            --border-radius: 12px;
            --box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: var(--dark-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            line-height: 1.6;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2rem 0;
            text-align: center;
            margin-bottom: 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        header h1 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            font-weight: 700;
        }

        header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        nav {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        nav ul {
            display: flex;
            justify-content: center;
            list-style: none;
            gap: 2rem;
            margin: 0;
            padding: 0;
        }

        nav a {
            text-decoration: none;
            color: var(--dark-color);
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            transition: var(--transition);
        }

        nav a:hover {
            color: var(--primary-color);
            background-color: rgba(67, 97, 238, 0.1);
        }

        .form-section {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem 0;
        }

        .form-container {
            background-color: white;
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 100%;
            max-width: 500px;
            transition: var(--transition);
            text-align: center;
        }

        .form-container:hover {
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
            font-size: 1.8rem;
        }

        .form-options {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            display: inline-block;
            width: 100%;
            padding: 1rem;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            text-align: center;
        }

        .btn:hover {
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.4);
        }

        .btn i {
            margin-right: 8px;
        }

        footer {
            text-align: center;
            padding: 1.5rem 0;
            background-color: white;
            margin-top: auto;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
        }

        footer p {
            margin-bottom: 0.5rem;
        }

        footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .redirect-login {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .redirect-login:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }

            nav ul {
                gap: 1rem;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>

    <header>
        <div class="container">
            <h1 style="margin-bottom: 0.5rem;">Lost-and-Found Hub</h1>
            <p style="margin-bottom: 0;">Choose the appropriate form to report your item</p>
        </div>
    </header>

    <!-- Navigation Bar -->
    <nav>
        <ul>
            <li><a href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="about-us.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
            <li><a href="contact.jsp"><i class="fas fa-envelope"></i> Contact</a></li>
            <li><a href="privacy-policy.jsp"><i class="fas fa-shield-alt"></i> Privacy Policy</a></li>
            <li><a href="terms-and-conditions.jsp"><i class="fas fa-file-contract"></i> Terms</a></li>
            <li><a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
        </ul>
    </nav>

    <!-- Main Form Section -->
    <section class="form-section">
        <div class="form-container">
            <h2>Select the Form You Want to Fill</h2>
            <div class="form-options">
                <a href="lost-item-form.jsp" class="btn"><i class="fas fa-search"></i> Report Lost Item</a>
                <a href="found-item-form.jsp" class="btn"><i class="fas fa-hand-holding-heart"></i> Report Found Item</a>
            </div>
            <div style="margin-top: 1.5rem;">
                <p>Already reported an item? <a href="dashboard.jsp" class="redirect-login">View your reports</a></p>
            </div>
        </div>
    </section>

    <footer>
        <p>&copy; 2024 Lost-and-Found Hub. All rights reserved.</p>
        <p>Helping communities reunite with lost items since 2024</p>
    </footer>

    <!-- Include SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Show success or error messages with SweetAlert
        <% if (successMessage != null) { %>
            Swal.fire({
                title: 'Success',
                text: '<%= successMessage.replace("\"", "\\\"") %>',
                icon: 'success',
                confirmButtonColor: '#4361ee'
            });
        <% } else if (errorMessage != null) { %>
            Swal.fire({
                title: 'Error',
                text: '<%= errorMessage.replace("\"", "\\\"") %>',
                icon: 'error',
                confirmButtonColor: '#4361ee'
            });
        <% } %>

        document.addEventListener("DOMContentLoaded", function() {
            console.log("Choose Form Page Loaded");
        });
    </script>
</body>
</html>