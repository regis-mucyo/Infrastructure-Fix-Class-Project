<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 h-screen flex flex-col justify-center items-center">

<%
  String u = request.getParameter("username");
  String p = request.getParameter("password");
  String error = "";

  if (u != null && p != null) {
    if (u.equals("admin") && p.equals("admin123")) {
      session.setAttribute("user", "Administrator");
      response.sendRedirect("dashboard.jsp");
      return;
    } else {
      error = "Invalid username or password";
    }
  }
%>

<div class="sm:mx-auto sm:w-full sm:max-w-md">
  <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">Admin Portal</h2>
  <p class="mt-2 text-center text-sm text-gray-600">Please sign in to access the dashboard</p>
</div>

<div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
  <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">

    <% if (!error.isEmpty()) { %>
    <div class="bg-red-50 border-l-4 border-red-400 p-4 mb-6">
      <div class="flex">
        <div class="ml-3">
          <p class="text-sm text-red-700"><%= error %></p>
        </div>
      </div>
    </div>
    <% } %>

    <form class="space-y-6" action="login.jsp" method="post">
      <div>
        <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
        <div class="mt-1">
          <input id="username" name="username" type="text" required
                 class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
      </div>

      <div>
        <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
        <div class="mt-1">
          <input id="password" name="password" type="password" required
                 class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
        </div>
      </div>

      <div>
        <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition">
          Sign in
        </button>
      </div>
    </form>

    <div class="mt-6">
      <div class="relative">
        <div class="absolute inset-0 flex items-center">
          <div class="w-full border-t border-gray-300"></div>
        </div>
        <div class="relative flex justify-center text-sm">
                        <span class="px-2 bg-white text-gray-500">
                            <a href="index.jsp" class="hover:text-blue-500">← Back to Reporting</a>
                        </span>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>