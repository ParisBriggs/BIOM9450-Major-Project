<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Reset Sent</title>
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
            background: linear-gradient(to bottom, #e3f2fd, #90caf9);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Main container for the message */
        .email-sent-container {
            background-color: #fff;
            padding: 40px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
            max-width: 450px;
            width: 100%;
        }

        /* Icon styling */
        .status-icon {
            font-size: 50px;
            color: #4caf50; /* Green color for success */
            margin-bottom: 20px;
        }

        /* Header styling */
        .email-sent-container h1 {
            font-size: 26px;
            color: #333;
            margin-bottom: 20px;
        }

        /* Message text styling */
        .email-sent-container p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }

        /* Button styling */
        .back-to-login-button {
            padding: 12px 20px;
            background-color: #2196F3;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            display: inline-block;
            transition: background-color 0.3s;
        }

        .back-to-login-button:hover {
            background-color: #1976D2;
        }

        /* Responsive adjustments */
        @media (max-width: 480px) {
            .email-sent-container {
                padding: 20px;
            }

            .email-sent-container h1 {
                font-size: 22px;
            }

            .email-sent-container p {
                font-size: 16px;
            }

            .back-to-login-button {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <div class="email-sent-container">
        <div class="status-icon">&#10003;</div> <!-- Checkmark for success -->
        <h1>Password Reset Email Sent</h1>
        <p>A password reset link has been sent to your email address. Please check your inbox and follow the instructions to reset your password.</p>
        <a href="login.php" class="back-to-login-button">Back to Login</a>
    </div>

</body>
</html>