<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eShelf | Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4F46E5;
            --bg-color: #0F172A;
            --card-bg: #1E293B;
            --text-main: #F8FAFC;
            --text-muted: #94A3B8;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { 
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
        }
        nav {
            background: rgba(30, 41, 59, 0.8);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255,255,255,0.05);
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .brand { font-weight: 800; font-size: 24px; background: linear-gradient(to right, #818CF8, #C084FC); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .user-nav { display: flex; align-items: center; gap: 20px; font-weight: 500; }
        .logout-btn { padding: 8px 16px; background: rgba(239, 68, 68, 0.1); color: #EF4444; border-radius: 8px; text-decoration: none; transition: all 0.2s; border: 1px solid transparent; }
        .logout-btn:hover { background: rgba(239, 68, 68, 0.2); border-color: rgba(239, 68, 68, 0.4); }
        
        .container { max-width: 1200px; margin: 60px auto; padding: 0 20px; }
        .dashboard-header { margin-bottom: 40px; }
        .dashboard-header h1 { font-size: 36px; font-weight: 800; margin-bottom: 10px; }
        .dashboard-header p { color: var(--text-muted); font-size: 16px; }
        
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 24px;
        }
        
        .card {
            background: var(--card-bg);
            border: 1px solid rgba(255,255,255,0.05);
            border-radius: 20px;
            padding: 30px;
            text-decoration: none;
            color: white;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            justify-content: center;
            min-height: 180px;
        }
        .card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(135deg, rgba(79, 70, 229, 0.1) 0%, transparent 100%);
            opacity: 0; transition: opacity 0.3s ease;
        }
        .card:hover { transform: translateY(-5px); border-color: rgba(129, 140, 248, 0.3); box-shadow: 0 20px 40px -15px rgba(0,0,0,0.5); }
        .card:hover::before { opacity: 1; }
        
        .card h3 { font-size: 22px; margin-bottom: 10px; font-weight: 600; z-index: 1; }
        .card p { color: var(--text-muted); font-size: 14px; line-height: 1.5; z-index: 1; }
        
    </style>
</head>
<body>

<nav>
    <div class="brand">eShelf</div>
    <div class="user-nav">
        <span>Hi, <%= session.getAttribute("username") %> (<%= session.getAttribute("role") %>)</span>
        <a href="logout" class="logout-btn">Logout</a>
    </div>
</nav>

<div class="container">
    <div class="dashboard-header">
        <h1>Welcome to your Library</h1>
        <p>Access and manage literature from anywhere in the world.</p>
    </div>
    
    <div class="grid">
        <a href="viewBooks" class="card">
            <h3>View & Manage Books</h3>
            <p>Browse the entire catalog, check availability, and manage titles.</p>
        </a>
        <a href="searchBooks.jsp" class="card">
            <h3>Search Catalog</h3>
            <p>Find specific books quickly by title, author, or publisher.</p>
        </a>

        <% if ("Admin".equals(session.getAttribute("role"))) { %>
        <a href="addBook.jsp" class="card">
            <h3>Add New Book</h3>
            <p>Inject new literature directly into the library catalog system.</p>
        </a>
        <a href="viewOrders" class="card">
            <h3>System Orders</h3>
            <p>View all historical purchases and transaction details globally.</p>
        </a>
        <% } else { %>
        <a href="myBooks" class="card">
            <h3>My Books & Returns</h3>
            <p>View your borrowed active loans and purchased history.</p>
        </a>
        <% } %>
    </div>
</div>

</body>
</html>