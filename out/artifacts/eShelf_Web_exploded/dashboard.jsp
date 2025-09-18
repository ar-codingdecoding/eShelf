<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .header {
            background-color: #007bff;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .header .user-info {
            font-size: 16px;
        }
        .header a {
            color: white;
            text-decoration: none;
            background-color: #dc3545;
            padding: 8px 15px;
            border-radius: 5px;
        }
        .container {
            padding: 30px;
        }
        .menu {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }
        .menu-item {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .menu-item a {
            text-decoration: none;
            color: #333;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Library Management System</h1>
    <div class="user-info">
        Welcome, <%= session.getAttribute("username") %>!
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Dashboard</h2>
    <div class="menu">

        <div class="menu-item"><a href="viewBooks">View Books</a></div>
        <div class="menu-item"><a href="#">Search for a Book</a></div>

        <%-- Check the user's role from the session --%>
        <% if ("Admin".equals(session.getAttribute("role"))) { %>

        <div class="menu-item"><a href="#">Add New Book</a></div>
        <div class="menu-item"><a href="#">Delete a Book</a></div>
        <div class="menu-item"><a href="#">View Orders</a></div>

        <% } else { %>

        <div class="menu-item"><a href="#">Place an Order</a></div>
        <div class="menu-item"><a href="#">Borrow a Book</a></div>
        <div class="menu-item"><a href="#">Return a Book</a></div>

        <% } %>
    </div>
</div>

</body>
</html>