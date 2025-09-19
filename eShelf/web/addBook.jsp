<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Book</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; padding-top: 40px;}
        .form-container { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 400px; }
        h2 { text-align: center; color: #333; }
        label { font-weight: bold; }
        input[type="text"], input[type="number"] { width: 100%; padding: 8px; margin: 6px 0 15px 0; border: 1px solid #ccc; border-radius: 4px; }
        input[type="submit"] { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        input[type="submit"]:hover { background-color: #218838; }
        a { display: block; text-align: center; margin-top: 15px; }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Add a New Book to the Library</h2>
    <form action="addBook" method="post">
        <label for="name">Book Name:</label><br>
        <input type="text" id="name" name="name" required><br>

        <label for="author">Author:</label><br>
        <input type="text" id="author" name="author" required><br>

        <label for="price">Price:</label><br>
        <input type="number" step="0.01" id="price" name="price" required><br>

        <label for="qty">Quantity (for sale):</label><br>
        <input type="number" id="qty" name="qty" required><br>

        <label for="brwcopies">Copies for Borrowing:</label><br>
        <input type="number" id="brwcopies" name="brwcopies" required><br>

        <input type="submit" value="Add Book">
    </form>
    <a href="dashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>