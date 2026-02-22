<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.infrastructurefix.InfrastructureDAO" %>
<%@ page import="com.infrastructurefix.Report" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | InfrastructureFix</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans text-gray-800">

<div class="max-w-6xl mx-auto py-10 px-4">

    <div class="flex flex-col md:flex-row justify-between items-center mb-8 gap-4">
        <h1 class="text-3xl font-bold text-gray-900">Admin Dashboard</h1>

        <form action="dashboard.jsp" method="get" class="flex gap-2 bg-white p-2 rounded shadow">
            <label class="flex items-center text-gray-600 font-semibold px-2">Search Date:</label>
            <input type="date" name="searchDate" class="border p-2 rounded" required>
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Search</button>
            <a href="dashboard.jsp" class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Reset</a>
        </form>

        <a href="index.jsp" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Submit New Report</a>
    </div>

    <div class="bg-white shadow-md rounded-lg overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-xl font-semibold text-gray-700">
                <%
                    String searchDate = request.getParameter("searchDate");
                    if (searchDate != null && !searchDate.isEmpty()) {
                        out.print("Search Results for: " + searchDate);
                    } else {
                        out.print("All Submitted Reports");
                    }
                %>
            </h2>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full text-left text-sm whitespace-nowrap">
                <thead class="bg-gray-50 border-b">
                <tr>
                    <th class="px-6 py-4">ID</th>
                    <th class="px-6 py-4">Date</th> <th class="px-6 py-4">Location</th>
                    <th class="px-6 py-4">Description</th>
                    <th class="px-6 py-4">Status</th>
                    <th class="px-6 py-4">Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    InfrastructureDAO dao = new InfrastructureDAO();
                    List<Report> reports;

                    // HANDLE SEARCH LOGIC
                    if (searchDate != null && !searchDate.isEmpty()) {
                        reports = dao.searchReportsByDate(searchDate);
                    } else {
                        reports = dao.getAllReports();
                    }

                    // Date Formatter for DD-MM-YYYY Display
                    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

                    if (reports != null && !reports.isEmpty()) {
                        for (Report r : reports) {
                %>
                <tr class="border-b hover:bg-gray-50">
                    <td class="px-6 py-4"><%= r.getId() %></td>

                    <td class="px-6 py-4 font-mono text-gray-600">
                        <%= (r.getReportDate() != null) ? formatter.format(r.getReportDate()) : "N/A" %>
                    </td>

                    <td class="px-6 py-4"><%= r.getLocation() %></td>
                    <td class="px-6 py-4"><%= r.getDescription() %></td>
                    <td class="px-6 py-4">
                        <span class="<%= r.getStatus().equals("Fixed") ? "text-green-600 font-bold" : "text-yellow-600" %>">
                            <%= r.getStatus() %>
                        </span>
                    </td>
                    <td class="px-6 py-4">
                        <a href="edit.jsp?id=<%= r.getId() %>" class="bg-blue-100 text-blue-700 px-3 py-1 rounded hover:bg-blue-200">Edit</a>
                        <a href="delete.jsp?id=<%= r.getId() %>" onclick="return confirm('Delete this report?');" class="bg-red-100 text-red-700 px-3 py-1 rounded hover:bg-red-200 ml-2">Delete</a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" class="px-6 py-4 text-center">No reports found matching your date.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>