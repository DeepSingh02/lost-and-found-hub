<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String errorMessage = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lost-and-Found Hub - Sign Up</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            margin-bottom: 0; /* Changed from 2rem to 0 to remove gap */
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

        /* Rest of your CSS remains the same */
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

        footer a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        footer a:hover {
            text-decoration: underline;
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
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

        .password-strength {
            margin-top: 0.5rem;
            height: 5px;
            background-color: #e9ecef;
            border-radius: 5px;
            overflow: hidden;
        }

        .strength-meter {
            height: 100%;
            width: 0;
            transition: width 0.3s ease;
        }

        .password-hints {
            margin-top: 0.5rem;
            font-size: 0.8rem;
            color: #6c757d;
        }

        .password-hints ul {
            list-style: none;
            padding-left: 1rem;
        }

        .password-hints li {
            margin-bottom: 0.2rem;
            position: relative;
        }

        .password-hints li:before {
            content: "•";
            position: absolute;
            left: -1rem;
        }

        .password-hints li.valid {
            color: var(--success-color);
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }

            nav ul {
                gap: 1rem;
            }
        }
    </style>
</head>
<body>

    <header>
        <div class="container">
            <h1 style="margin-bottom: 0.5rem;">Join Lost-and-Found Hub</h1>
            <p style="margin-bottom: 0;">Create your account to report and find lost items in your community</p>
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
        <form id="signupForm" action="SignupServlet" method="POST" class="form-container">
            <h2>Create Your Account</h2>
            
            <div class="form-group">
                <label for="name">Full Name</label>
                <div style="position: relative;">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" id="name" name="name" required placeholder="John Doe" class="input-with-icon">
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <div style="position: relative;">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" id="email" name="email" required placeholder="your@email.com" class="input-with-icon">
                </div>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <div class="password-container">
                    <div style="position: relative;">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" required placeholder="Create a password" class="input-with-icon">
                    </div>
                    <span id="togglePassword" class="eye-icon"><i class="fas fa-eye"></i></span>
                </div>
                <div class="password-strength">
                    <div class="strength-meter" id="strengthMeter"></div>
                </div>
                <div class="password-hints">
                    <ul>
                        <li id="lengthHint">At least 8 characters</li>
                        <li id="upperHint">1 uppercase letter</li>
                        <li id="numberHint">1 number</li>
                        <li id="specialHint">1 special character</li>
                    </ul>
                </div>
            </div>

            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <div style="position: relative;">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" id="confirm-password" name="confirmPassword" required placeholder="Confirm your password" class="input-with-icon">
                </div>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <div style="position: relative;">
                    <i class="fas fa-phone input-icon"></i>
                    <input type="text" id="phone" name="phone" required placeholder="1234567890" class="input-with-icon">
                </div>
            </div>

            <button type="submit"><i class="fas fa-user-plus"></i> Sign Up</button>
            
            <div class="login-link">
                Already have an account? <a href="login.jsp">Log in here</a>
            </div>
        </form>
    </section>

    <footer>
        <p>&copy; 2024 Lost-and-Found Hub. All rights reserved.</p>
        <p>Helping communities reunite with lost items since 2024</p>
    </footer>

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

        // Password strength indicator
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthMeter = document.getElementById('strengthMeter');
            const hints = {
                length: document.getElementById('lengthHint'),
                upper: document.getElementById('upperHint'),
                number: document.getElementById('numberHint'),
                special: document.getElementById('specialHint')
            };
            
            // Reset all hints
            Object.values(hints).forEach(hint => {
                hint.classList.remove('valid');
            });
            
            let strength = 0;
            
            // Check password criteria
            const hasLength = password.length >= 8;
            const hasUpperCase = /[A-Z]/.test(password);
            const hasNumber = /[0-9]/.test(password);
            const hasSpecialChar = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password);
            
            if (hasLength) {
                strength += 25;
                hints.length.classList.add('valid');
            }
            if (hasUpperCase) {
                strength += 25;
                hints.upper.classList.add('valid');
            }
            if (hasNumber) {
                strength += 25;
                hints.number.classList.add('valid');
            }
            if (hasSpecialChar) {
                strength += 25;
                hints.special.classList.add('valid');
            }
            
            // Update strength meter
            strengthMeter.style.width = `${strength}%`;
            
            // Update color based on strength
            if (strength < 50) {
                strengthMeter.style.backgroundColor = '#f72585';
            } else if (strength < 75) {
                strengthMeter.style.backgroundColor = '#f8961e';
            } else {
                strengthMeter.style.backgroundColor = '#4cc9f0';
            }
        });

        // Form validation
        document.getElementById("signupForm").addEventListener("submit", function (event) {
            event.preventDefault();
            
            // Get form values
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const phone = document.getElementById('phone').value;
            
            // Validation flags
            let isValid = true;
            let errorTitle = '';
            let errorMessage = '';
            
            // Name validation
            if (name.trim() === '') {
                isValid = false;
                errorTitle = 'Missing Information';
                errorMessage = 'Please enter your full name';
            }
            // Email validation
            else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                isValid = false;
                errorTitle = 'Invalid Email';
                errorMessage = 'Please enter a valid email address';
            }
            // Phone validation
            else if (!/^[0-9]{10}$/.test(phone)) {
                isValid = false;
                errorTitle = 'Invalid Phone Number';
                errorMessage = 'Phone number must be exactly 10 digits';
            }
            // Password validation
            else if (password.length < 8 || !/[A-Z]/.test(password) || !/[0-9]/.test(password) || !/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)) {
                isValid = false;
                errorTitle = 'Weak Password';
                errorMessage = 'Password must contain at least 8 characters, 1 uppercase letter, 1 number, and 1 special character';
            }
            // Password match validation
            else if (password !== confirmPassword) {
                isValid = false;
                errorTitle = 'Password Mismatch';
                errorMessage = 'The passwords you entered do not match';
            }
            
            // Show error or proceed
            if (!isValid) {
                Swal.fire({
                    title: errorTitle,
                    text: errorMessage,
                    icon: 'error',
                    confirmButtonColor: '#4361ee'
                });
            } else {
                // Store form values in case we need to repopulate after error
                const formData = {
                    name: name,
                    email: email,
                    phone: phone
                };
                
                sessionStorage.setItem('formData', JSON.stringify(formData));
                
                Swal.fire({
                    title: 'Ready to Join?',
                    html: 'You\'re about to create your Lost-and-Found Hub account.<br><br>Please confirm your details:',
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#4361ee',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Yes, create my account!',
                    cancelButtonText: 'No, let me check'
                }).then((result) => {
                    if (result.isConfirmed) {
                        this.submit();
                    }
                });
            }
        });

        // Repopulate form if there was an error
        document.addEventListener('DOMContentLoaded', function() {
            const savedData = sessionStorage.getItem('formData');
            if (savedData) {
                const formData = JSON.parse(savedData);
                document.getElementById('name').value = formData.name || '';
                document.getElementById('email').value = formData.email || '';
                document.getElementById('phone').value = formData.phone || '';
                sessionStorage.removeItem('formData');
            }
            
            // Show server-side errors if any
            <% if (errorMessage != null) { %>
                let errorTitle = 'Registration Error';
                let errorText = 'An error occurred during registration. Please try again.';
                
                switch('<%= errorMessage %>') {
                    case 'emptyFields':
                        errorTitle = 'Missing Information';
                        errorText = 'All fields are required to create your account.';
                        break;
                    case 'passwordMismatch':
                        errorTitle = 'Password Mismatch';
                        errorText = 'The passwords you entered do not match.';
                        break;
                    case 'invalidPhone':
                        errorTitle = 'Invalid Phone Number';
                        errorText = 'Phone number must be exactly 10 digits.';
                        break;
                    case 'invalidEmail':
                        errorTitle = 'Invalid Email';
                        errorText = 'Please enter a valid email address.';
                        break;
                    case 'invalidPassword':
                        errorTitle = 'Weak Password';
                        errorText = 'Password must contain at least 8 characters, 1 uppercase letter, 1 number, and 1 special character.';
                        break;
                    case 'emailExists':
                        errorTitle = 'Email Already Registered';
                        errorText = 'An account with this email already exists. Please use a different email or try logging in.';
                        break;
                    case 'databaseError':
                        errorTitle = 'System Error';
                        errorText = 'We\'re experiencing technical difficulties. Please try again later.';
                        break;
                }
                
                Swal.fire({
                    title: errorTitle,
                    text: errorText,
                    icon: 'error',
                    confirmButtonColor: '#4361ee'
                });
            <% } %>
        });
    </script>
</body>
</html>