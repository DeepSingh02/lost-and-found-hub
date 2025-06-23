<%@page import="java.sql.*"%>
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

    String url = "jdbc:mysql://localhost:3306/lost_and_found_db";
    String dbUser = "root";
    String dbPassword = "1234";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, dbUser, dbPassword);
        
        // First check if claim exists
        PreparedStatement checkStmt = con.prepareStatement("SELECT claim_id FROM claims WHERE claim_id = ?");
        checkStmt.setInt(1, Integer.parseInt(claimId));
        ResultSet rs = checkStmt.executeQuery();
        
        if (!rs.next()) {
            response.sendRedirect("admin-claims.jsp?error=claim_not_found");
            return;
        }
        
        // Delete the claim
        PreparedStatement stmt = con.prepareStatement("DELETE FROM claims WHERE claim_id = ?");
        stmt.setInt(1, Integer.parseInt(claimId));
        
        int rowsAffected = stmt.executeUpdate();
        stmt.close();
        con.close();
        
        if (rowsAffected > 0) {
            response.sendRedirect("admin-claims.jsp?success=delete");
        } else {
            response.sendRedirect("admin-claims.jsp?error=delete_failed");
        }
    } catch (Exception e) {
        response.sendRedirect("admin-claims.jsp?error=db_error");
    }
%>