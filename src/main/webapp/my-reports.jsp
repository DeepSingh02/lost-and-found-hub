<%@ page import="java.sql.*" %>
<%@ page import="com.myproject.lostandfoundhub.utils.DatabaseConnection" %>
<%@ page session="true" %>
<%
    // Check user session
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Claims | Lost & Found Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-container {
            margin: 50px auto;
            max-width: 1000px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #3f37c9;
        }
        .status-pending { 
            color: #ffc107; 
            font-weight: bold; 
        }
        .status-approved { 
            color: #28a745; 
            font-weight: bold; 
        }
        .status-rejected { 
            color: #dc3545; 
            font-weight: bold; 
        }
        .action-buttons .btn {
            padding: 5px 10px;
            font-size: 0.875rem;
        }
        .details-cell {
            max-width: 200px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>
    <div class="container table-container">
        <h2>My Submitted Claims</h2>
        
        <%-- Success/Error Messages --%>
        <% 
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if (success != null) {
        %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= "Approved".equals(success) ? "Claim approved successfully!" : "Claim submitted successfully!" %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            }
            
            if (error != null) {
        %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= "Error processing your request. Please try again." %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            }
        %>

        <%
            try {
                conn = DatabaseConnection.getConnection();
                
                // First get user_id from users table
                int userId = 0;
                PreparedStatement userStmt = conn.prepareStatement("SELECT user_id FROM users WHERE email = ?");
                userStmt.setString(1, userEmail);
                ResultSet userRs = userStmt.executeQuery();
                if (userRs.next()) {
                    userId = userRs.getInt("user_id");
                }
                userRs.close();
                userStmt.close();
                
                // Now get claims for this user
                String sql = "SELECT c.claim_id, c.category, c.item_id, c.claim_reason, " +
                             "c.additional_details, c.created_at, c.status " +
                             "FROM claims c WHERE c.user_id = ? ORDER BY c.created_at DESC";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
        %>
            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="table-primary">
                        <tr>
                            <th>Claim ID</th>
                            <th>Category</th>
                            <th>Item ID</th>
                            <th>Reason</th>
                            <th>Details</th>
                            <th>Date Submitted</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                            String status = rs.getString("status");
                            String statusClass = status.toLowerCase();
                    %>
                        <tr>
                            <td><%= rs.getInt("claim_id") %></td>
                            <td><%= rs.getString("category") %></td>
                            <td><%= rs.getInt("item_id") %></td>
                            <td class="details-cell"><%= rs.getString("claim_reason") %></td>
                            <td class="details-cell"><%= rs.getString("additional_details") != null ? rs.getString("additional_details") : "N/A" %></td>
                            <td><%= new java.text.SimpleDateFormat("MMM dd, yyyy hh:mm a").format(rs.getTimestamp("created_at")) %></td>
                            <td class="status-<%= statusClass %>">
                                <% if ("Approved".equals(status)) { %>
                                    <i class="bi bi-check-circle-fill"></i>
                                <% } else if ("Rejected".equals(status)) { %>
                                    <i class="bi bi-x-circle-fill"></i>
                                <% } else { %>
                                    <i class="bi bi-hourglass-split"></i>
                                <% } %>
                                <%= status %>
                            </td>
                            <td class="action-buttons">
                                <% if ("Approved".equals(status)) { %>
                                    <a href="reports_detail.jsp?claim_id=<%= rs.getInt("claim_id") %>&source=my-reports" 
                                       class="btn btn-sm btn-primary" title="View Details">
                                        <i class="bi bi-eye-fill"></i>
                                    </a>
                                <% } else { %>
                                    <button class="btn btn-sm btn-primary" 
                                            title="View Details" 
                                            onclick="showStatusAlert('<%= status %>')">
                                        <i class="bi bi-eye-fill"></i>
                                    </button>
                                <% } %>
                            </td>
                        </tr>
                    <%
                        }
                        if (!hasData) {
                    %>
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">
                                <i class="bi bi-info-circle-fill" style="font-size: 1.5rem;"></i><br>
                                No claims found yet.<br>
                                <a href="view-found-reports.jsp" class="btn btn-primary mt-2">Submit New Claim</a>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        <%
            } catch (Exception e) {
                out.println("<div class='alert alert-danger'>Error loading claims: " + e.getMessage() + "</div>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            }
        %>
        
        <div class="d-flex justify-content-between mt-4">
            <a href="dashboard.jsp" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Back to Dashboard
            </a>
            <a href="view-found-reports.jsp" class="btn btn-primary">
                <i class="bi bi-plus-circle"></i> Submit New Claim
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showStatusAlert(status) {
            let message = "Please wait until your claim request gets approved.";
            if (status === "Rejected") {
                message = "This claim was rejected. You cannot view details for rejected claims.";
            }
            alert(message);
        }
    </script>
</body>
</html>