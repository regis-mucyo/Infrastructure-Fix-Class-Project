package com.infrastructurefix;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InfrastructureDAO {

    // 1. UPDATED: Insert now includes the current date
    public boolean insertReport(String location, String description) {
        String sql = "INSERT INTO infrastructure_reports (location, description, status, report_date) VALUES (?, ?, 'Pending', CURRENT_DATE)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, location);
            pstmt.setString(2, description);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. UPDATED: Get All now reads the date
    public List<Report> getAllReports() {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT * FROM infrastructure_reports ORDER BY id DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Report report = new Report(
                        rs.getInt("id"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getDate("report_date") // Get the date
                );
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    // 3. NEW: Search by Date Method
    public List<Report> searchReportsByDate(String dateStr) {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT * FROM infrastructure_reports WHERE report_date = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Convert String (YYYY-MM-DD) to SQL Date
            pstmt.setDate(1, Date.valueOf(dateStr));

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Report report = new Report(
                        rs.getInt("id"),
                        rs.getString("location"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getDate("report_date")
                );
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    // ... (Keep your existing getReportById, updateReport, and deleteReport methods exactly as they are) ...

    // Paste your existing getReportById, updateReport, and deleteReport methods here.
    // If you want me to give you the FULL file to avoid copy-paste errors, tell me.
    public Report getReportById(int id) {
        String sql = "SELECT * FROM infrastructure_reports WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Report(rs.getInt("id"), rs.getString("location"), rs.getString("description"), rs.getString("status"), rs.getDate("report_date"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean updateReport(int id, String location, String description, String status) {
        String sql = "UPDATE infrastructure_reports SET location = ?, description = ?, status = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, location);
            stmt.setString(2, description);
            stmt.setString(3, status);
            stmt.setInt(4, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteReport(int id) {
        String sql = "DELETE FROM infrastructure_reports WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}