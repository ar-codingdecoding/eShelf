<%@ page import="java.util.List" %>
    <%@ page import="eShelf.Book" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>eShelf | Book Catalog</title>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;800&display=swap"
                    rel="stylesheet">
                <style>
                    :root {
                        --bg-color: #0F172A;
                        --card-bg: #1E293B;
                        --text-main: #F8FAFC;
                        --text-muted: #94A3B8;
                    }

                    * {
                        box-sizing: border-box;
                        margin: 0;
                        padding: 0;
                        font-family: 'Inter', sans-serif;
                    }

                    body {
                        background-color: var(--bg-color);
                        color: var(--text-main);
                        min-height: 100vh;
                    }

                    nav {
                        background: rgba(30, 41, 59, 0.8);
                        backdrop-filter: blur(12px);
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                        padding: 20px 40px;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }

                    .brand {
                        font-weight: 800;
                        font-size: 24px;
                        background: linear-gradient(to right, #818CF8, #C084FC);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        text-decoration: none;
                    }

                    .back-link {
                        color: var(--text-muted);
                        text-decoration: none;
                        font-weight: 500;
                        transition: color 0.2s;
                    }

                    .back-link:hover {
                        color: white;
                    }

                    .container {
                        max-width: 1200px;
                        margin: 60px auto;
                        padding: 0 20px;
                    }

                    .header-section {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 40px;
                    }

                    .header-section h1 {
                        font-size: 32px;
                        font-weight: 800;
                    }

                    table {
                        width: 100%;
                        border-collapse: separate;
                        border-spacing: 0;
                        background: var(--card-bg);
                        border-radius: 16px;
                        overflow: hidden;
                        border: 1px solid rgba(255, 255, 255, 0.05);
                    }

                    th,
                    td {
                        padding: 20px;
                        text-align: left;
                        border-bottom: 1px solid rgba(255, 255, 255, 0.05);
                    }

                    th {
                        background: rgba(15, 23, 42, 0.4);
                        color: var(--text-muted);
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 13px;
                        letter-spacing: 0.5px;
                    }

                    tr:last-child td {
                        border-bottom: none;
                    }

                    tr:hover td {
                        background: rgba(255, 255, 255, 0.02);
                    }

                    .pill-badge {
                        padding: 4px 10px;
                        border-radius: 20px;
                        font-size: 13px;
                        font-weight: 600;
                    }

                    .stock-good {
                        background: rgba(16, 185, 129, 0.1);
                        color: #34D399;
                    }

                    .stock-low {
                        background: rgba(245, 158, 11, 0.1);
                        color: #FBBF24;
                    }

                    .actions {
                        display: flex;
                        gap: 10px;
                    }

                    .btn {
                        border: none;
                        padding: 8px 16px;
                        border-radius: 8px;
                        font-weight: 600;
                        font-size: 13px;
                        cursor: pointer;
                        transition: all 0.2s;
                    }

                    .btn-borrow {
                        background: rgba(59, 130, 246, 0.1);
                        color: #60A5FA;
                    }

                    .btn-borrow:hover {
                        background: rgba(59, 130, 246, 0.2);
                    }

                    .btn-buy {
                        background: rgba(16, 185, 129, 0.1);
                        color: #34D399;
                    }

                    .btn-buy:hover {
                        background: rgba(16, 185, 129, 0.2);
                    }

                    .btn-delete {
                        background: rgba(239, 68, 68, 0.1);
                        color: #F87171;
                    }

                    .btn-delete:hover {
                        background: rgba(239, 68, 68, 0.2);
                    }

                    .empty-state {
                        text-align: center;
                        padding: 60px 20px;
                        color: var(--text-muted);
                    }
                </style>
            </head>

            <body>

                <nav>
                    <a href="dashboard.jsp" class="brand">eShelf</a>
                    <a href="dashboard.jsp" class="back-link">&larr; Back to Dashboard</a>
                </nav>

                <div class="container">
                    <div class="header-section">
                        <h1>Literature Catalog</h1>
                    </div>

                    <table>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Price</th>
                            <th>Buy Qty</th>
                            <th>Borrow Qty</th>
                            <th>Actions</th>
                        </tr>
                        <% List<Book> bookList = (List<Book>) request.getAttribute("bookList");
                                boolean isAdmin = "Admin".equals(session.getAttribute("role"));

                                if (bookList != null && !bookList.isEmpty()) {
                                for (Book book : bookList) {
                                %>
                                <tr>
                                    <td style="font-weight: 600;">
                                        <%= book.getName() %>
                                    </td>
                                    <td style="color: var(--text-muted);">
                                        <%= book.getAuthor() %>
                                    </td>
                                    <td style="color: #34D399; font-weight: 500;">$<%= String.format("%.2f",
                                            book.getPrice()) %>
                                    </td>

                                    <td><span class="pill-badge <%= book.getQty() > 5 ? " stock-good" : "stock-low" %>">
                                            <%= book.getQty() %> in stock</span></td>
                                    <td><span class="pill-badge <%= book.getBrwcopies() > 0 ? " stock-good"
                                            : "stock-low" %>"><%= book.getBrwcopies() %> available</span></td>

                                    <td class="actions">
                                        <% if (isAdmin) { %>
                                            <form action="deleteBook" method="post" style="margin:0;">
                                                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                                <button type="submit" class="btn btn-delete">Remove</button>
                                            </form>
                                            <% } else { %>
                                                <% if (book.getBrwcopies()> 0) { %>
                                                    <form action="borrowBook" method="post" style="margin:0;">
                                                        <input type="hidden" name="bookId" value="<%= book.getId() %>">
                                                        <button type="submit" class="btn btn-borrow">Borrow</button>
                                                    </form>
                                                    <% } %>

                                                        <% if (book.getQty()> 0) { %>
                                                            <form action="buyBook" method="post" style="margin:0;">
                                                                <input type="hidden" name="bookId"
                                                                    value="<%= book.getId() %>">
                                                                <button type="submit"
                                                                    class="btn btn-buy">Purchase</button>
                                                            </form>
                                                            <% } %>
                                                                <% } %>
                                    </td>
                                </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="6" class="empty-state">
                                            <div style="font-size: 48px; margin-bottom: 20px;">📚</div>
                                            <h3>No books found</h3>
                                            <p style="margin-top: 10px;">The library catalog is currently empty.</p>
                                        </td>
                                    </tr>
                                    <% } %>
                    </table>
                </div>

            </body>

            </html>