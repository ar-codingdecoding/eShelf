<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eShelf | Add New Book</title>
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

        .container { max-width: 600px; margin: 60px auto; padding: 0 20px; }
        
        .form-card {
            background: var(--card-bg);
            border: 1px solid rgba(255,255,255,0.05);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px -15px rgba(0,0,0,0.5);
        }
        .form-card h2 { font-size: 28px; font-weight: 800; margin-bottom: 30px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 15px; }

        .input-group { margin-bottom: 24px; }
        .input-group label { display: block; font-size: 13px; font-weight: 600; color: var(--text-muted); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
        .input-group input {
            width: 100%; padding: 14px 16px; background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255,255,255,0.1); border-radius: 12px;
            color: white; font-size: 15px; transition: all 0.3s ease; outline: none;
        }
        .input-group input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2); }
        
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }

        .submit-btn {
            width: 100%; padding: 16px; background: linear-gradient(135deg, var(--primary) 0%, #7C3AED 100%);
            color: white; border: none; border-radius: 12px; font-size: 16px; font-weight: 600;
            cursor: pointer; transition: transform 0.2s ease, box-shadow 0.2s ease; margin-top: 10px;
        }
        .submit-btn:hover { transform: translateY(-2px); box-shadow: 0 10px 20px -10px rgba(124, 58, 237, 0.8); }
    </style>
</head>
<body>

<nav>
    <a href="dashboard.jsp" class="brand">eShelf</a>
    <a href="dashboard.jsp" class="back-link">&larr; Back to Dashboard</a>
</nav>

<div class="container">
    <div class="form-card">
        <h2>Ingest New Book</h2>
        <form action="addBook" method="post">
            <div class="input-group">
                <label>Title of Book</label>
                <input type="text" name="name" required placeholder="e.g. The Lord of the Rings">
            </div>
            <div class="input-group">
                <label>Author</label>
                <input type="text" name="author" required placeholder="e.g. J.R.R. Tolkien">
            </div>
            
            <div class="row">
                <div class="input-group">
                    <label>Retail Price ($)</label>
                    <input type="number" step="0.01" name="price" required placeholder="29.99">
                </div>
                <div class="input-group">
                    <label>Stock Quantity</label>
                    <input type="number" name="qty" required placeholder="10">
                </div>
            </div>
            
            <div class="input-group">
                <label>Borrowing Copies Available</label>
                <input type="number" name="brwcopies" required placeholder="5">
            </div>

            <button type="submit" class="submit-btn">Add Book to Catalog</button>
        </form>
    </div>
</div>

</body>
</html>