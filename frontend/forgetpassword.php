<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</P></title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
 
<style>
        /* Basic reset for margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling */
        body {
            font-family: 'Roboto', sans-serif;
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: linear-gradient(to bottom,white, #90caf9); 
        }

        /* Main container for the form */
        .reset-password-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        /* The reset password card styling */
        .reset-password-card {
            background-color: #fff;
            padding: 30px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .reset-password-card h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #333;
        }

        .reset-password-card p {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
        }

        .reset-password-card input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        .reset-password-card input:focus {
            border-color: #2196F3;
            outline: none;
        }

        .reset-password-card button {
            width: 100%;
            padding: 12px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .reset-password-card button:hover {
            background-color: #1976D2;
        }

        .reset-password-card .note {
            margin-top: 15px;
            font-size: 14px;
        }

        .reset-password-card .note a {
            color: #2196F3;
            text-decoration: none;
        }

        .reset-password-card .note a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="reset-password-container">
        <div class="reset-password-card">
            <h1>Reset Account Password</h1>
            <p>Enter details below to reset password</p>

        <!-- Display the error message if there's an error in the URL -->
        <?php if (isset($_GET['error']) && $_GET['error'] == 'invalid_details'): ?>
            <p class="error-message" style='color: red; text-align: center;'>Invalid username or ID. Please try again.</p>
        <?php endif; ?>

            <form action="processforgotpassword.php" method="POST">
                <input type="userName" name="userName" placeholder="Enter Username" required>
                <input type="id" name="id" placeholder="Enter Practitioner ID" required>
                <button type="submit">Reset Password</button>
            </form>
            <p class="note">Remember your password? <a href="login.php">Back to Login</a></p>
        </div>
    </div>
</body>
</html>

