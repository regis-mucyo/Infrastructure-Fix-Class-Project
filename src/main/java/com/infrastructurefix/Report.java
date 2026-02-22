package com.infrastructurefix;

import java.sql.Date; // Import added

public class Report {
    private int id;
    private String location;
    private String description;
    private String status;
    private Date reportDate; // New Field

    public Report(int id, String location, String description, String status, Date reportDate) {
        this.id = id;
        this.location = location;
        this.description = description;
        this.status = status;
        this.reportDate = reportDate;
    }

    public int getId() { return id; }
    public String getLocation() { return location; }
    public String getDescription() { return description; }
    public String getStatus() { return status; }
    public Date getReportDate() { return reportDate; } // New Getter
}