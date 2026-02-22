<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.infrastructurefix.InfrastructureDAO" %>

<%
    // 1. Get the ID from the URL (e.g., delete.jsp?id=5)
    String idParam = request.getParameter("id");

    if (idParam != null && !idParam.isEmpty()) {
        int id = Integer.parseInt(idParam);

        // 2. Call the DAO to delete the record
        InfrastructureDAO dao = new InfrastructureDAO();
        boolean success = dao.deleteReport(id);

        // 3. Redirect back to the Dashboard
        if (success) {
            response.sendRedirect("dashboard.jsp?msg=deleted");
        } else {
            response.sendRedirect("dashboard.jsp?msg=error");
        }
    } else {
        response.sendRedirect("dashboard.jsp");
    }
%>