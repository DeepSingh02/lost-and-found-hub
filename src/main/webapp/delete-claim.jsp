<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Check if admin is logged in
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin-login.jsp");
        return;
    }

    String claimId = request.getParameter("claim_id");
    if (claimId == null || claimId.isEmpty()) {
        response.sendRedirect("admin-claims.jsp?error=invalid_params");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Confirm Claim Deletion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --danger-color: #dc3545;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: var(--dark-color);
        }
        
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: none;
        }
        
        .card-header {
            background-color: var(--danger-color);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.5rem;
        }
        
        .claim-details {
            background-color: white;
            border-radius: 8px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .detail-row {
            display: flex;
            margin-bottom: 0.8rem;
            padding-bottom: 0.8rem;
            border-bottom: 1px solid #eee;
        }
        
        .detail-label {
            font-weight: 600;
            color: #6c757d;
            min-width: 150px;
        }
        
        .detail-value {
            flex: 1;
        }
        
        .btn-delete {
            background-color: var(--danger-color);
            border-color: var(--danger-color);
            padding: 10px 25px;
            font-weight: 500;
        }
        
        .btn-delete:hover {
            background-color: #c82333;
            border-color: #bd2130;
        }
        
        .btn-cancel {
            background-color: #6c757d;
            border-color: #6c757d;
            padding: 10px 25px;
            font-weight: 500;
        }
        
        .warning-section {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header text-center">
                        <h3><i class="fas fa-exclamation-triangle me-2"></i>Confirm Claim Deletion</h3>
                    </div>
                    <div class="card-body">
                        <%
                            String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
                            String dbUser = "root";
                            String dbPassword = "1234";
                            
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection(url, dbUser, dbPassword);
                                
                                String sql = "SELECT c.*, u.name, u.email, u.phone " +
                                            "FROM claims c " +
                                            "JOIN users u ON c.user_id = u.user_id " +
                                            "WHERE c.claim_id = ?";
                                PreparedStatement stmt = con.prepareStatement(sql);
                                stmt.setInt(1, Integer.parseInt(claimId));
                                ResultSet rs = stmt.executeQuery();
                                
                                if (rs.next()) {
                                    String status = rs.getString("status");
                                    String statusClass = "text-" + 
                                        (status.equalsIgnoreCase("Approved") ? "success" : 
                                         status.equalsIgnoreCase("Rejected") ? "danger" : "warning");
                        %>
                        <div class="warning-section">
                            <h5><i class="fas fa-exclamation-circle me-2"></i>Warning</h5>
                            <p class="mb-0">You are about to permanently delete this claim record. This action cannot be undone.</p>
                        </div>
                        
                        <div class="claim-details">
                            <h5 class="mb-4">Claim Details</h5>
                            
                            <div class="detail-row">
                                <span class="detail-label">Claim ID:</span>
                                <span class="detail-value"><%= rs.getInt("claim_id") %></span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">User:</span>
                                <span class="detail-value">
                                    <strong><%= rs.getString("name") %></strong><br>
                                    <%= rs.getString("email") %><br>
                                    <%= rs.getString("phone") %>
                                </span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Item ID:</span>
                                <span class="detail-value"><%= rs.getInt("item_id") %></span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Category:</span>
                                <span class="detail-value"><%= rs.getString("category") %></span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Status:</span>
                                <span class="detail-value <%= statusClass %>">
                                    <i class="fas <%= 
                                        status.equalsIgnoreCase("Approved") ? "fa-check-circle" : 
                                        status.equalsIgnoreCase("Rejected") ? "fa-times-circle" : "fa-hourglass-half" %> 
                                        me-2"></i>
                                    <%= status %>
                                </span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Date Submitted:</span>
                                <span class="detail-value"><%= rs.getTimestamp("created_at") %></span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Claim Reason:</span>
                                <span class="detail-value"><%= rs.getString("claim_reason") %></span>
                            </div>
                            
                            <% if (rs.getString("additional_details") != null && !rs.getString("additional_details").isEmpty()) { %>
                            <div class="detail-row">
                                <span class="detail-label">Additional Details:</span>
                                <span class="detail-value"><%= rs.getString("additional_details") %></span>
                            </div>
                            <% } %>
                        </div>
                        
                        <div class="d-flex justify-content-between mt-4">
                            <a href="admin-claims.jsp" class="btn btn-cancel text-white">
                                <i class="fas fa-arrow-left me-2"></i>Cancel
                            </a>
                            <form action="delete-claim-process.jsp" method="post">
                                <input type="hidden" name="claim_id" value="<%= rs.getInt("claim_id") %>">
                                <button type="submit" class="btn btn-delete">
                                    <i class="fas fa-trash-alt me-2"></i>Confirm Delete
                                </button>
                            </form>
                        </div>
                        <%
                                } else {
                                    response.sendRedirect("admin-claims.jsp?error=claim_not_found");
                                }
                                
                                rs.close();
                                stmt.close();
                                con.close();
                            } catch (Exception e) {
                                response.sendRedirect("admin-claims.jsp?error=db_error");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>