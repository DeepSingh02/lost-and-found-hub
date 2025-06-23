<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Claim Requests</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #333;
        }
        
        .header {
            background-color: #343a40;
            color: white;
            padding: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .header h1 {
            margin: 0;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        .nav-buttons {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-view {
            background-color: #17a2b8;
            color: white;
            padding: 8px 12px;
            font-size: 14px;
        }
        
        .btn-approve {
            background-color: #28a745;
            color: white;
            padding: 8px 12px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .btn-reject {
            background-color: #dc3545;
            color: white;
            padding: 8px 12px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #343a40;
            color: white;
            font-weight: 500;
        }
        
        tr:hover {
            background-color: #f5f5f5;
        }
        
        .no-claims {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
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
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Admin - Claim Requests</h1>
        <div>
            <a href="logout.jsp" class="btn btn-danger">🚪 Logout</a>
        </div>
    </div>
    
    <div class="container">
        <div class="nav-buttons">
            <a href="dashboard.jsp" class="btn btn-secondary">🏠 Dashboard</a>
            <a href="index.html" class="btn btn-primary">🏡 Home</a>
        </div>

        <%-- Success/Error Messages --%>
        <% 
            String success = request.getParameter("success");
            String error = request.getParameter("error");
            
            if (success != null) {
                String message = "";
                if (success.equals("approve")) {
                    message = "Claim approved successfully!";
                } else if (success.equals("reject")) {
                    message = "Claim rejected successfully!";
                }
        %>
            <div class="success-message">
                <%= message %>
            </div>
        <%
            }
            
            if (error != null) {
                String message = "";
                if (error.equals("invalid_params")) {
                    message = "Invalid parameters!";
                } else if (error.equals("update_failed")) {
                    message = "Failed to update claim status!";
                } else if (error.equals("db_error")) {
                    message = "Database error occurred!";
                }
        %>
            <div class="error-message">
                <%= message %>
            </div>
        <%
            }
        %>

        <%
            String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
            String dbUser = "root";
            String dbPassword = "1234";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, dbUser, dbPassword);

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery(
                    "SELECT c.*, u.name, u.email, u.phone " +
                    "FROM claims c " +
                    "JOIN users u ON c.user_id = u.user_id " +
                    "ORDER BY c.created_at DESC");
                
                if (!rs.isBeforeFirst()) {
        %>
            <div class="no-claims">
                <h3>No claim requests found</h3>
                <p>There are currently no claims submitted by users.</p>
            </div>
        <%
                } else {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Claim ID</th>
                        <th>User</th>
                        <th>Item ID</th>
                        <th>Category</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            String status = rs.getString("status");
                            String statusClass = status.toLowerCase();
                    %>
                    <tr>
                        <td><%= rs.getInt("claim_id") %></td>
                        <td>
                            <strong><%= rs.getString("name") %></strong><br>
                            <%= rs.getString("email") %>
                        </td>
                        <td><%= rs.getInt("item_id") %></td>
                        <td><%= rs.getString("category") %></td>
                        <td><%= rs.getTimestamp("created_at") %></td>
                        <td class="status-<%= statusClass %>">
                            <%= status %>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="claim-details.jsp?claim_id=<%= rs.getInt("claim_id") %>" class="btn btn-view">View Details</a>
                                <% if ("Pending".equalsIgnoreCase(status)) { %>
                                    <form action="process-claim.jsp" method="post" style="display: inline;">
                                        <input type="hidden" name="claim_id" value="<%= rs.getInt("claim_id") %>">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="btn btn-approve">Approve</button>
                                    </form>
                                    <form action="process-claim.jsp" method="post" style="display: inline;">
                                        <input type="hidden" name="claim_id" value="<%= rs.getInt("claim_id") %>">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="btn btn-reject">Reject</button>
                                    </form>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                out.println("<div class='error-message'>Error loading claims: " + e.getMessage() + "</div>");
            }
        %>
    </div>
</body>
</html> 