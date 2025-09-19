<%@ page import="java.util.List" %>
<%@ page import="eShelf.Book" %> <%-- This import now matches your package --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Books</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; }
        table { width: 80%; border-collapse: collapse; margin: 20px auto; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #007bff; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        h1, p { text-align: center; }
    </style>
</head>
<body>
<h1>Library Book Catalog</h1>
<table>
    <tr>
        <th>Name</th>
        <th>Author</th>
        <th>Price</th>
        <th>Quantity</th>
        <%-- Add Actions header only if user is Admin --%>
        <% if ("Admin".equals(session.getAttribute("role"))) { %>
        <th>Actions</th>
        <% } else { %>
        <th>Actions</th>
        <% } %>
    </tr>
    <%
        List<Book> bookList = (List<Book>) request.getAttribute("bookList");
        if (bookList != null && !bookList.isEmpty()) {
            for (Book book : bookList) {
    %>
    <tr>
        <td><%= book.getName() %></td>
        <td><%= book.getAuthor() %></td>
        <td>$<%= String.format("%.2f", book.getPrice()) %></td>
        <td><%= book.getQty() %></td>

        <%-- This is the corrected if/else block --%>
        <% if ("Admin".equals(session.getAttribute("role"))) { %>
        <td>
            <form action="deleteBook" method="post" style="margin:0;">
                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                <input type="submit" value="Delete" style="background-color: #dc3545; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px;">
            </form>
        </td>
        <% } else { %>
        <td>
            <form action="borrowBook" method="post" style="margin:0;">
                <input type="hidden" name="bookId" value="<%= book.getId() %>">
                <input type="submit" value="Borrow" style="background-color: #17a2b8; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 4px;">
            </form>
        </td>
        <% } %>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="5">No books found in the library.</td>
    </tr>
    <%
        }
    %>
</table>
<p><a href="dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>