<<?php
// Start the session
session_start();

// Secure session settings (optional, for cookie security)
session_set_cookie_params([
    'secure' => true, // Ensure cookies are sent over HTTPS
    'httponly' => true, // Prevent JavaScript access to cookies
    'samesite' => 'Strict', // Protect against CSRF attacks
]);

// Unset all session variables
session_unset();

// Destroy the session
session_destroy();

// Optionally, delete the session cookie (for extra security)
if (isset($_COOKIE[session_name()])) {
    setcookie(session_name(), '', time() - 3600, '/'); // Expire the cookie
}

// Redirect the user to the logged_out.php page
header("Location: loggedout.php");
exit();