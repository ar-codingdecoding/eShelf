<%@ page import="java.util.List" %>
<%@ page import="eShelf.OrderInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eShelf | System Orders</title>
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
        body { background-color: var(--bg-color); color: var(--text-main); min-height: 100vh; }
        
        nav { background: rgba(30, 41, 59, 0.8); backdrop-filter: blur(12px); border-bottom: 1px solid rgba(255,255,255,0.05); padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; }
        .brand { font-weight: 800; font-size: 24px; background: linear-gradient(to right, #818CF8, #C084FC); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-decoration: none; }
        .back-link { color: var(--text-muted); text-decoration: none; font-weight: 500; transition: color 0.2s; }
        .back-link:hover { color: white; }

        .container { max-width: 1200px; margin: 60px auto; padding: 0 20px; }
        .header-section { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; }
        .header-section h1 { font-size: 32px; font-weight: 800; }
        
        table { width: 100%; border-collapse: separate; border-spacing: 0; background: var(--card-bg); border-radius: 16px; overflow: hidden; border: 1px solid rgba(255,255,255,0.05); margin-bottom: 40px; }
        th, td { padding: 20px; text-align: left; border-bottom: 1px solid rgba(255,255,255,0.05); }
        th { background: rgba(15, 23, 42, 0.4); color: var(--text-muted); font-weight: 600; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: rgba(255,255,255,0.02); }
        
        .pill-badge { padding: 4px 10px; border-radius: 20px; font-size: 13px; font-weight: 600; background: rgba(139, 92, 246, 0.1); color: #A78BFA; }
        
        .empty-state { text-align: center; padding: 60px 20px; color: var(--text-muted); }
    </style>
</head>
<body>

<nav>
    <a href="dashboard.jsp" class="brand">eShelf Admin</a>
    <a href="dashboard.jsp" class="back-link">&larr; Back to Dashboard</a>
</nav>

<div class="container">
    <div class="header-section">
        <h1>Global Orders History</h1>
    </div>

    <table>
        <tr>
            <th>Order ID</th>
            <th>Purchasing User</th>
            <th>Purchased Item</th>
            <th>Revenue</th>
        </tr>
        <%
            List<OrderInfo> orders = (List<OrderInfo>) request.getAttribute("orderList");
            if (orders != null && !orders.isEmpty()) {
                double totalRev = 0;
                for (OrderInfo o : orders) {
                    totalRev += o.getPrice();
        %>
        <tr>
            <td><span class="pill-badge">ORD-<%= String.format("%06d", o.getOrderId()) %></span></td>
            <td style="font-weight: 600;"><%= o.getUserName() %></td>
            <td style="color: var(--text-muted);"><%= o.getBookName() %></td>
            <td style="color: #34D399; font-weight: 600;">$<%= String.format("%.2f", o.getPrice()) %></td>
        </tr>
        <%
                }
        %>
        <tr>
            <td colspan="3" style="text-align: right; font-weight: 600; color: var(--text-muted);">Total Revenue:</td>
            <td style="font-weight: 800; color: #10B981; font-size: 18px;">$<%= String.format("%.2f", totalRev) %></td>
        </tr>
        <%
            } else {
        %>
        <tr>
            <td colspan="4" class="empty-state">No purchases exist in the system yet.</td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
