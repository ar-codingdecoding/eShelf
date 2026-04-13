<%@ page import="java.util.List" %>
<%@ page import="eShelf.BorrowInfo" %>
<%@ page import="eShelf.OrderInfo" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eShelf | My Literature</title>
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
        
        .pill-badge { padding: 4px 10px; border-radius: 20px; font-size: 13px; font-weight: 600; }
        .date-badge { background: rgba(148, 163, 184, 0.1); color: var(--text-muted); }
        
        .btn { border: none; padding: 8px 16px; border-radius: 8px; font-weight: 600; font-size: 13px; cursor: pointer; transition: all 0.2s; }
        .btn-return { background: rgba(239, 68, 68, 0.1); color: #F87171; }
        .btn-return:hover { background: rgba(239, 68, 68, 0.2); }
        
        .empty-state { text-align: center; padding: 60px 20px; color: var(--text-muted); }
        h2 { font-size: 24px; font-weight: 600; margin-bottom: 20px; color: #818CF8; }
    </style>
</head>
<body>

<nav>
    <a href="dashboard.jsp" class="brand">eShelf</a>
    <a href="dashboard.jsp" class="back-link">&larr; Back to Dashboard</a>
</nav>

<div class="container">
    <div class="header-section">
        <h1>My Literature & Activity</h1>
    </div>

    <h2>Currently Borrowed</h2>
    <table>
        <tr>
            <th>Title</th>
            <th>Borrowed On</th>
            <th>Due Date</th>
            <th>Actions</th>
        </tr>
        <%
            List<BorrowInfo> borrows = (List<BorrowInfo>) request.getAttribute("borrows");
            if (borrows != null && !borrows.isEmpty()) {
                for (BorrowInfo b : borrows) {
        %>
        <tr>
            <td style="font-weight: 600;"><%= b.getBookName() %></td>
            <td><span class="pill-badge date-badge"><%= b.getStartDate() %></span></td>
            <td><span class="pill-badge date-badge"><%= b.getFinishDate() %></span></td>
            <td>
                <form action="returnBook" method="post" style="margin:0;">
                    <input type="hidden" name="borrowId" value="<%= b.getBorrowId() %>">
                    <input type="hidden" name="bookId" value="<%= b.getBookId() %>">
                    <button type="submit" class="btn btn-return">Return Book</button>
                </form>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4" class="empty-state">You have no active borrowings.</td>
        </tr>
        <% } %>
    </table>

    <h2 style="color: #34D399; margin-top: 60px;">Purchased Catalog</h2>
    <table>
        <tr>
            <th>Order ID</th>
            <th>Title</th>
            <th>Price Paid</th>
        </tr>
        <%
            List<OrderInfo> orders = (List<OrderInfo>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
                for (OrderInfo o : orders) {
        %>
        <tr>
            <td><span style="color: var(--text-muted);">#<%= String.format("%06d", o.getOrderId()) %></span></td>
            <td style="font-weight: 600;"><%= o.getBookName() %></td>
            <td style="color: #34D399; font-weight: 500;">$<%= String.format("%.2f", o.getPrice()) %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3" class="empty-state">No past orders.</td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
