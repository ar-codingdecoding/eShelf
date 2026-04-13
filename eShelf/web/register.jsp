<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eShelf | Join Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4F46E5;
            --bg-color: #0F172A;
            --card-bg: rgba(30, 41, 59, 0.7);
            --text-main: #F8FAFC;
            --text-muted: #94A3B8;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { 
            font-family: 'Inter', sans-serif; 
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #0F172A 0%, #1E1B4B 100%);
            color: var(--text-main);
            padding: 20px;
        }
        .register-wrapper {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 24px;
            padding: 40px;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5);
            animation: fadeIn 0.6s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .brand { text-align: center; margin-bottom: 30px; }
        .brand h2 { font-weight: 800; font-size: 32px; letter-spacing: -1px; background: linear-gradient(to right, #818CF8, #C084FC); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .brand p { color: var(--text-muted); font-size: 14px; margin-top: 5px; }
        
        .input-group { margin-bottom: 20px; }
        .input-group label { display: block; font-size: 13px; font-weight: 600; color: var(--text-muted); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.5px; }
        .input-group input {
            width: 100%;
            padding: 14px 16px;
            background: rgba(15, 23, 42, 0.6);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 12px;
            color: white;
            font-size: 15px;
            transition: all 0.3s ease;
            outline: none;
        }
        .input-group input:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.2); background: rgba(15, 23, 42, 0.9); }
        
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--primary) 0%, #7C3AED 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            margin-top: 10px;
        }
        .submit-btn:hover { transform: translateY(-2px); box-shadow: 0 10px 20px -10px rgba(124, 58, 237, 0.8); }
        .submit-btn:active { transform: translateY(0); }
    </style>
</head>
<body>
    <div class="register-wrapper">
        <div class="brand">
            <h2>eShelf</h2>
            <p>Create your personal patron account</p>
        </div>
        <form action="register" method="post">
            <div class="input-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="John Doe" required>
            </div>
            
            <div class="input-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="john@example.com" required>
            </div>
            
            <div class="row">
                <div class="input-group">
                    <label>Phone Number</label>
                    <input type="text" name="phonenumber" placeholder="555-0198" required>
                </div>
                <div class="input-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>
            </div>

            <button type="submit" class="submit-btn">Create Account</button>
            <div style="text-align: center; margin-top: 20px; font-size: 14px; color: var(--text-muted);">
                Already have an account? <a href="login.html" style="color: var(--primary); text-decoration: none; font-weight: 600;">Sign in</a>
            </div>
        </form>
    </div>
</body>
</html>
