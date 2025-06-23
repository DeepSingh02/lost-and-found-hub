<%@ page import="java.sql.*" %>
<%@ page import="com.myproject.lostandfoundhub.utils.DatabaseConnection" %>
<%@ page session="true" %>
<%
    // Ensure session is active
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get first letter of email and capitalize it
    String firstLetter = "";
    if (userEmail != null && !userEmail.isEmpty()) {
        firstLetter = String.valueOf(userEmail.charAt(0)).toUpperCase();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard | Lost & Found Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --danger-color: #f72585;
            --success-color: #4cc9f0;
            --warning-color: #ffc107;
            --light-bg: #f8f9fa;
        }
        
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2rem 0;
            border-radius: 0 0 20px 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .user-avatar {
            width: 80px;
            height: 80px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: var(--primary-color);
            font-size: 2rem;
            font-weight: bold;
        }
        
        .card-feature {
            border: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            height: 100%;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            cursor: pointer;
            border: 2px solid transparent;
            background: white;
            opacity: 0;
            transform: translateY(20px);
        }
        
        .card-feature:hover {
            transform: translateY(-5px) !important;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border-color: var(--primary-color);
        }
        
        .feature-link:hover {
            text-decoration: none;
        }
        
        main.container {
            padding-bottom: 100px;
        }
        
        .notification-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        
        .card-feature i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .btn-logout {
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
        }
        
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            padding: 1rem;
        }
        
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .stats-value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        /* Specific icon colors */
        .feature-lost i {
            color: var(--danger-color);
        }
        
        .feature-found i {
            color: var(--success-color);
        }
        
        .feature-reports i {
            color: var(--warning-color);
        }
        
        .feature-notifications i {
            color: #6c757d;
        }
        
        .feature-browse i {
            color: var(--accent-color);
        }
    </style>
</head>
<body>
    <!-- Header Section -->
    <header class="dashboard-header text-center">
        <div class="container">
            <div class="user-avatar">
                <%= firstLetter %>
            </div>
            <h1 class="h3">Welcome back, <%= userEmail %>!</h1>
            <p class="mb-0">What would you like to do today?</p>
        </div>
    </header>

    <main class="container mb-5">
        <!-- Quick Stats Section -->
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <div class="stats-card text-center">
                    <i class="bi bi-search text-danger"></i>
                    <h5>Lost Items</h5>
                    <div class="stats-value">12</div>
                    <small class="text-muted">Reported this month</small>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stats-card text-center">
                    <i class="bi bi-check-circle text-success"></i>
                    <h5>Found Items</h5>
                    <div class="stats-value">8</div>
                    <small class="text-muted">Reported this month</small>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stats-card text-center">
                    <i class="bi bi-arrow-left-right text-primary"></i>
                    <h5>Matches</h5>
                    <div class="stats-value">3</div>
                    <small class="text-muted">Potential matches found</small>
                </div>
            </div>
        </div>

        <!-- Main Features Grid -->
        <div class="feature-grid">
            <!-- Report Lost Item -->
            <a href="lost-item-form.jsp" class="feature-link">
                <div class="card card-feature text-center p-4 feature-lost">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <h4>Report Lost Item</h4>
                    <p class="text-muted">Can't find something? Let us help you.</p>
                    <div class="mt-2">
                        <span class="badge bg-danger">New</span>
                    </div>
                </div>
            </a>
            
            <!-- Report Found Item -->
            <a href="found-item-form.jsp" class="feature-link">
                <div class="card card-feature text-center p-4 feature-found">
                    <i class="bi bi-check-circle-fill"></i>
                    <h4>Report Found Item</h4>
                    <p class="text-muted">Found someone's belongings? Report it here.</p>
                </div>
            </a>
            
            <!-- View Lost Reports -->
            <a href="view-lost-reports.jsp" class="feature-link">
                <div class="card card-feature text-center p-4 feature-browse">
                    <i class="bi bi-search-heart"></i>
                    <h4>Lost Item Reports</h4>
                    <p class="text-muted">Browse items reported as lost by others.</p>
                </div>
            </a>
            
            <!-- View Found Reports -->
            <a href="view-found-reports.jsp" class="feature-link">
                <div class="card card-feature text-center p-4 feature-browse">
                    <i class="bi bi-box-seam"></i>
                    <h4>Found Item Reports</h4>
                    <p class="text-muted">Check items that have been found.</p>
                </div>
            </a>
            
            <!-- My Reports -->
            <a href="my-reports.jsp" class="feature-link">
                <div class="card card-feature text-center p-4 feature-reports">
                    <i class="bi bi-list-ul"></i>
                    <h4>My Reports</h4>
                    <p class="text-muted">View and manage your submitted reports.</p>
                </div>
            </a>
            
            

    <!-- Footer with Logout -->
    <footer class="fixed-bottom bg-white py-3 border-top">
        <div class="container text-center">
            <a href="logout.jsp" class="btn btn-outline-danger btn-logout">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
            <a href="index.html" class="btn btn-outline-primary btn-logout me-2">
    <i class="bi bi-house-door"></i> Home
</a>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Enhanced animation and interaction for cards
        document.addEventListener('DOMContentLoaded', function() {
            // Animate cards on page load
            const cards = document.querySelectorAll('.card-feature');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 150 * index);
            });
            
            // Add click effect to feature links
            const featureLinks = document.querySelectorAll('.feature-link');
            featureLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    if (this.getAttribute('href') === '#') {
                        e.preventDefault();
                        return;
                    }
                    
                    const card = this.querySelector('.card-feature');
                    if (card) {
                        card.style.transform = 'scale(0.95)';
                        card.style.boxShadow = '0 2px 5px rgba(0,0,0,0.1)';
                        
                        setTimeout(() => {
                            window.location.href = this.getAttribute('href');
                        }, 200);
                    }
                });
            });
            
            // Enhanced hover effects
            cards.forEach(card => {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-5px)';
                    this.style.boxShadow = '0 15px 30px rgba(0,0,0,0.1)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                    this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.05)';
                });
            });
        });
    </script>
</body>
</html>