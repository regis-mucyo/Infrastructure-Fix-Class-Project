<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.infrastructurefix.InfrastructureDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Report Infrastructure | Community Fix</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-10">

<div class="max-w-2xl mx-auto bg-white p-8 shadow-lg rounded-xl">
    <h1 class="text-3xl font-bold mb-6 text-blue-600">Report Infrastructure Damage</h1>

    <%
        // 1. Capture the form data
        String loc = request.getParameter("location");
        String desc = request.getParameter("description");

        if (loc != null && desc != null) {
            // 2. Call the DAO to Insert into Database
            InfrastructureDAO dao = new InfrastructureDAO();
            boolean isSaved = dao.insertReport(loc, desc);

            if (isSaved) {
    %>
    <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6">
        <strong>Success!</strong> Your report for "<%= loc %>" was sent successful.
    </div>
    <%
    } else {
    %>
    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6">
        <strong>Error!</strong> Could not connect to the database.
    </div>
    <%
            }
        }
    %>

    <form action="index.jsp" method="post" class="space-y-4">
        <div>
            <label class="block text-sm font-medium text-gray-700">Location</label>
            <input name="location" type="text" required placeholder="e.g. Kigali Main Road" class="w-full border p-2 rounded focus:ring-blue-500 focus:border-blue-500">
        </div>
        <div>
            <label class="block text-sm font-medium text-gray-700">Description</label>
            <textarea name="description" required placeholder="Describe the damage..." rows="4" class="w-full border p-2 rounded focus:ring-blue-500 focus:border-blue-500"></textarea>
        </div>
        <button type="submit" class="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 font-bold transition">Submit Report</button>
    </form>
</div>

</body>
</html>