<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet">
   <style>
    body {
    background: linear-gradient(to bottom, #ffffff, #b8e0e6, #5a8ab6);
    font-family: 'Roboto', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.register-container {
    width: 350px;
    padding: 40px;
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    text-align: center;
}

.register-container h1 {
    font-size: 24px;
    margin-bottom: 20px;
}

.register-container form input {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border: 1px solid #dcdcdc;
    border-radius: 5px;
    font-size: 16px;
}

.register-container form button {
    width: 100%;
    padding: 12px;
    background-color: #4caf50;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.register-container .login-link {
    margin-top: 15px;
    font-size: 14px;
}

.register-container .login-link a {
    color: #007bff;
    text-decoration: none;
}

.register-container .login-link a:hover {
    color: #0056b3;
}
</style> 

</head>
<body>
    <div class="register-container">
        <h1>Sign up to NutriMed</h1>
        <p>Please fill in the form to create a new account.</p>
        <form action="signup.php" method="POST">
            <input type="text" name="Fname" placeholder="Enter Full Name (Surname First)" required>
            <input type="email" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <input type="password" name="confirm_password" placeholder="Confirm Password" required>
            <button type="submit">Register</button>
        </form>

        <?php
$successMessage = ''; // Initialize the success message variable
// Check if the form was submitted and then show success message
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Assuming form is successfully "logged in"
    $successMessage = 'Login successful! You can now proceed.';
}
?>

<?php if ($successMessage): ?>
    <div class="success-message">
        <?php echo $successMessage; ?>
    </div>
<?php endif; ?>

<p>Already have an account? <a href="login.php">Login</a></p>
       
</body>
</html>