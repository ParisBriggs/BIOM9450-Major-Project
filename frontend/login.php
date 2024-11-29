<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles/styles_login.css">
</head>

<body>
<div class="login-container">
        <h1><img src="images/large_logo.png" class="company_logo"></h1>
        <h3>Login to get started</h3>
        
        <!-- Error Message -->
        <?php
        if (isset($_GET['error']) && $_GET['error'] == 'invalid_credentials') {
            echo "<p style='color: red; text-align: center;'>Invalid username or password. Please try again.</p>";
        }
        ?>
        

        <!-- Login Form -->
        <form action="loginvalidation.php" method="POST">
            <input type="userName" name="userName" placeholder="Enter Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <div class="remember-forgot">
                <div class="remember">
                    <input type="checkbox" name="remember">
                    <label for="remember"> Remember for 30 days</label>
                </div>
                <a href="forgetpassword.php">Forgot password?</a>
            </div>
            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>