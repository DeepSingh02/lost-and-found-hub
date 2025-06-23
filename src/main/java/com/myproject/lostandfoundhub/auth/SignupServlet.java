package com.myproject.lostandfoundhub.auth;

import com.myproject.lostandfoundhub.utils.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("🚀 SignupServlet triggered!");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");

        // 🚀 Validation
        if (name == null || email == null || password == null || phone == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || phone.trim().isEmpty()) {
            response.sendRedirect("signup.jsp?error=emptyFields");
            return;
        }

        if (!password.equals(confirmPassword)) {
            response.sendRedirect("signup.jsp?error=passwordMismatch");
            return;
        }

        if (!phone.matches("\\d{10}")) {  
            response.sendRedirect("signup.jsp?error=invalidPhone");
            return;
        }

        // Email format validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.sendRedirect("signup.jsp?error=invalidEmail");
            return;
        }

        // Password rules validation
        if (!password.matches("^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$")) {
            response.sendRedirect("signup.jsp?error=invalidPassword");
            return;
        }

        // ✅ Database Insertion
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("✅ Database connected!");

            // Check if email already exists
            String checkEmailSql = "SELECT email FROM users WHERE email = ?";
            PreparedStatement checkEmailStmt = conn.prepareStatement(checkEmailSql);
            checkEmailStmt.setString(1, email);
            ResultSet rs = checkEmailStmt.executeQuery();

            if (rs.next()) {
                // Email already exists
                response.sendRedirect("signup.jsp?error=emailExists");
                return;
            }

            // Insert new user into the database
            String sql = "INSERT INTO users (name, email, password_hash, phone) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password); // Store the plain-text password (not recommended for production)
            stmt.setString(4, phone);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("🎉 User registered successfully!");

                // Log the user in by setting their email in the session
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);

                // Redirect to choose_form.jsp
                response.sendRedirect("choose_form.jsp");
            } else {
                response.sendRedirect("signup.jsp?error=registrationFailed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=databaseError");
        }
    }
}