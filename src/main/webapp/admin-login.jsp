<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Login - Lost-and-Found Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Include SweetAlert2 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
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

        

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--dark-color);
        }

        input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e9ecef;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }

        .password-container {
            position: relative;
        }

        .eye-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
        }

        button {
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
            margin-top: 1rem;
        }

        button:hover {
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.4);
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

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .input-with-icon {
            padding-left: 40px !important;
        }

        .error-message {
            color: var(--error-color);
            background-color: rgba(247, 37, 133, 0.1);
            padding: 0.8rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            font-weight: 500;
            display: none;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>

    <header>
        <div class="container">
            <h1 style="margin-bottom: 0.5rem;">Admin Portal</h1>
            <p style="margin-bottom: 0;">Lost-and-Found Hub Management System</p>
        </div>
    </header>
    
     <nav>
        <ul>
            <li><a href="index.html"><i class="fas fa-home"></i> Home</a></li>
            <li><a href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a></li>
            <li><a href="about-us.html"><i class="fas fa-info-circle"></i> About Us</a></li>
            <li><a href="contact-us.html"><i class="fas fa-envelope"></i> Contact</a></li>
        </ul>
    </nav>

    <section class="form-section">
        <form id="adminLoginForm" action="admin-login-action.jsp" method="POST" class="form-container">
            <h2>Admin Login</h2>
            
            
            
            <%-- Display error message if login failed --%>
            <% if(request.getParameter("error") != null) { %>
                <div class="error-message" style="display: block;">
                    <i class="fas fa-exclamation-circle"></i> Invalid admin ID or password
                </div>
            <% } %>
            
            <div class="form-group">
                <label for="username">Admin ID</label>
                <div style="position: relative;">
                    <i class="fas fa-user-shield input-icon"></i>
                    <input type="text" id="username" name="username" required placeholder="Enter admin ID" class="input-with-icon">
                </div>
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <div class="password-container">
                    <div style="position: relative;">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" required placeholder="Enter password" class="input-with-icon">
                    </div>
                    <span id="togglePassword" class="eye-icon"><i class="fas fa-eye"></i></span>
                </div>
            </div>
            
            <button type="submit"><i class="fas fa-sign-in-alt"></i> Login</button>
        </form>
    </section>

    <footer>
        <p>&copy; 2024 Lost-and-Found Hub. All rights reserved.</p>
        <p>Administrative access only</p>
    </footer>

    <!-- Include SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function () {
            const passwordField = document.getElementById('password');
            const icon = this.querySelector('i');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordField.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });

        // Validate Before Submission
        document.getElementById("adminLoginForm").addEventListener("submit", function (event) {
            event.preventDefault(); // Prevent default form submission

            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            // Username validation
            if (username.length === 0) {
                Swal.fire({
                    title: 'Admin ID Required',
                    text: 'Please enter your admin ID.',
                    icon: 'error',
                    confirmButtonColor: '#4361ee'
                });
                return;
            }

            // Password validation
            if (password.length === 0) {
                Swal.fire({
                    title: 'Password Required',
                    text: 'Please enter your password.',
                    icon: 'error',
                    confirmButtonColor: '#4361ee'
                });
                return;
            }

            // Submit the form
            this.submit();
        });

        // Show error message with SweetAlert if present
        <% if (request.getParameter("error") != null) { %>
            Swal.fire({
                title: 'Login Failed',
                text: 'Invalid admin ID or password. Please try again.',
                icon: 'error',
                confirmButtonColor: '#4361ee'
            });
        <% } %>
    </script>
</body>
</html>