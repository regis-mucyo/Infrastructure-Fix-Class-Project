<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.infrastructurefix.InfrastructureDAO" %>
<%@ page import="com.infrastructurefix.Report" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Report | InfrastructureFix</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-10">

<div class="max-w-xl mx-auto bg-white p-8 shadow-lg rounded-xl">
    <h1 class="text-2xl font-bold mb-6 text-blue-600">Edit Report Status</h1>

    <%
        String idParam = request.getParameter("id");
        InfrastructureDAO dao = new InfrastructureDAO();
        Report report = null;

        // HANDLE UPDATE SUBMISSION
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            int id = Integer.parseInt(request.getParameter("id"));
            String loc = request.getParameter("location");
            String desc = request.getParameter("description");
            String status = request.getParameter("status");

            if (dao.updateReport(id, loc, desc, status)) {
                // If update is successful, go back to dashboard
                response.sendRedirect("dashboard.jsp");
                return;
            } else {
                out.println("<p class='text-red-500'>Error updating report.</p>");
            }
        }

        // LOAD EXISTING DATA
        if (idParam != null) {
            report = dao.getReportById(Integer.parseInt(idParam));
        }
    %>

    <% if (report != null) { %>
    <form action="edit.jsp" method="post" class="space-y-4">
        <input type="hidden" name="id" value="<%= report.getId() %>">

        <div>
            <label class="block text-sm font-medium text-gray-700">Location</label>
            <input name="location" type="text" value="<%= report.getLocation() %>" class="w-full border p-2 rounded bg-gray-100">
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700">Description</label>
            <textarea name="description" class="w-full border p-2 rounded bg-gray-100"><%= report.getDescription() %></textarea>
        </div>

        <div>
            <label class="block text-sm font-medium text-gray-700">Status</label>
            <select name="status" class="w-full border p-2 rounded bg-white font-bold text-blue-600">
                <option value="Pending" <%= "Pending".equals(report.getStatus()) ? "selected" : "" %>>Pending</option>
                <option value="In Progress" <%= "In Progress".equals(report.getStatus()) ? "selected" : "" %>>In Progress</option>
                <option value="Fixed" <%= "Fixed".equals(report.getStatus()) ? "selected" : "" %>>Fixed</option>
            </select>
        </div>

        <button type="submit" class="w-full bg-green-600 text-white py-2 rounded hover:bg-green-700 font-bold">Update Report</button>
    </form>
    <% } else { %>
    <p class="text-red-500">Report not found.</p>
    <% } %>

    <div class="mt-4">
        <a href="dashboard.jsp" class="text-gray-500 hover:underline">Cancel and go back</a>
    </div>
</div>

</body>
</html>