<?php
session_set_cookie_params([
    'secure' => false, // For local testing over HTTP
    'httponly' => true,
    'samesite' => 'Strict',
]);
session_start();

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    // Redirect to login page if the user is not logged in
    header('Location: login.php');
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nutrimed Health - Dashboard</title>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
    <link rel="stylesheet" href="styles/styles_dashboard.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="logout_dropdown.js" defer></script>
</head>
<body>

    <!-- Logo and Centered Navigation Bar -->
    <header>
        <div class="header-left">
            <img src="images/company_logo.png" alt="Nutrimed Health Logo" class="logo">
        </div>
        <div class="header-right">
            <div class="ward-profile">
                <div class="dropdown">
                    <button class="dropdown-button" onclick="toggleDropdown()"><br><small>Welcome</small>
                    <?php echo $_SESSION['user_name']; ?><br>
                    </button>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="logout.php">Logout</a>
                    </div>
                </div>
            </div>
        </div> 
    </header>

    <div class="container">
        <!-- Left Column with Logo -->
        <div class="left-column">
            <img src="images/large-logo.jpg" alt="Nutrimed Health Logo" class="logo">
        </div>
    
        <!-- Right Column with Navigation Buttons -->
        <div class="right-column">
            <button onclick="location.href='medication_rounds.php'">Medication Rounds</button>
            <button onclick="location.href='diet_rounds.php'">Diet Regime Rounds</button>
            <button onclick="location.href='patient_records.php'">View Patient Records</button>
            <button onclick="location.href='manage_orders.php'">Manage Prescriptions</button>
            <button onclick="location.href='generate_reports.php'">Generate Reports</button>
            <button onclick="location.href='practitioner_info.php'">Create New Practitioner Account</button>
        </div>
    </div>
    
    <section class="facility-details">
        <div class="facility-container">
            <!-- Facility Information -->
            <div class="facility-info">
                <h2>Welcome to Nutrimed Sydney Facility</h2>
                <p>
                    At Nutrimed Health, we pride ourselves on providing a luxury elderly care experience, combining cutting-edge healthcare with compassionate staff in a state-of-the-art environment. 
                    Our facility is nestled in the heart of Kensington, NSW, offering unparalleled accessibility and comfort. Designed to provide a holistic approach to elderly care, our services cater to
                    every aspect of well-being.
                </p>
                <h3>What We Offer</h3>
                <ul>
                    <li><span><strong>Comprehensive Care:</strong> A full suite of medical and elderly care services tailored to individual needs.</span></li>
                    <li><span><strong>Modern Amenities:</strong> Relaxing lounges, peaceful gardens, advanced technology, and personalised rooms.</span></li>
                    <li><span><strong>Dedicated Staff:</strong> Highly trained professionals committed to providing compassionate, high-quality care.</span></li>
                    <li><span><strong>Engaging Activities:</strong> Daily enrichment programs designed to keep residents active, happy, and fulfilled.</span></li>
                </ul>
                <p>
                    Experience healthcare reimagined. Whether you are a resident, visitor, or staff member, our facility is designed to inspire comfort, connection, and community. 
                    Visit us today to see the difference we make in the lives of our residents and their families.
                </p>
            </div>
            <!-- Facility Image -->
            <div class="facility-image">
                <img src="images/facility.webp" alt="Nutrimed Sydney Facility">
            </div>
        </div>
    </section>

    <section class="map-and-directions">
        <div class="map-container">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3353.9688347855886!2d151.23655437576002!3d-33.919036173207296!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6b12b22188c339c7%3A0xf017d68f9f009c0!2sPrince%20Of%20Wales%20Hospital!5e1!3m2!1sen!2sau!4v1731747352711!5m2!1sen!2sau"
                width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
        <div class="directions-content">
            <h2>Directions to Our Facility</h2>
            <p>
                Our Nutrimed Health Luxury Elderly Care Facility is conveniently located in Kensington, NSW. Accessible by public transport, the facility offers a welcoming environment for both staff and visitors.
            </p>
            <p>
                Visitors can use the L2 Randwick light rail line, buses (348, 358, 370, 390x lines, among others) or park onsite.
            </p>
            <h3>Available Amenities</h3>
            <table class="facilities-table">
                    <td>🌐</td>
                    <td><strong>Wi-Fi</strong></td>
                    <td>Complimentary high-speed Wi-Fi available throughout the premises for staff and visitors.</td>
                </tr>
                <tr>
                    <td>☕</td>
                    <td><strong>Refreshments</strong></td>
                    <td>Onsite cafeteria offering a variety of hot and cold meal options, including vegetarian and halal choices.</td>
                </tr>
                <tr>
                    <td>📱</td>
                    <td><strong>Charging Stations</strong></td>
                    <td>Conveniently located charging points for electronic devices, accessible in common areas and private rooms.</td>
                </tr>
                <tr>
                    <td>🌳</td>
                    <td><strong>Outdoor Spaces</strong></td>
                    <td>Beautifully landscaped gardens and open-air seating areas for relaxation and leisure activities.</td>
                </tr>
                <tr>
                    <td>🩺</td>
                    <td><strong>Round the Clock Care</strong></td>
                    <td>24/7 medical care available with an on-call doctor and fully equipped healthcare rooms.</td>
                </tr>
                    <td>📚</td>
                    <td><strong>Library</strong></td>
                    <td>A well-stocked library with books, magazines, and digital resources for all interests.</td>
                </tr>
            </table>
        </div>
    </section>
    <section class="testimonials">
        <h2>What Our Residents Say</h2>
        <div class="testimonial-container">
            <div class="testimonial">
                <p>"The care and attention I receive here are beyond exceptional. The staff treat me like family, and the facilities are amazing."</p>
                <h4>- Emily Johnson</h4>
            </div>
            <div class="testimonial">
                <p>"I love the daily activities and the peaceful gardens. It truly feels like home, with a touch of luxury."</p>
                <h4>- Michael Reed</h4>
            </div>
            <div class="testimonial">
                <p>"Moving here was the best decision I ever made. The medical staff are attentive, and the amenities are top-notch."</p>
                <h4>- Sarah Bennett</h4>
            </div>
        </div>
    </section>
    <section class="gallery-section">
        <h2>Our Residents in Action</h2>
        <p>Celebrating moments of joy, connection, and care.</p>
        <div class="gallery-grid">
            <div class="gallery-item">
                <img src="images/event.webp">
            </div>
            <div class="gallery-item">
                <img src="images/event2.png">
            </div>
            <div class="gallery-item">
                <img src="images/event3.jpg">
            </div>
            <div class="gallery-item">
                <img src="images/event4.jpg">
            </div>
            <div class="gallery-item">
                <img src="images/event5.jpg">
            </div>
            <div class="gallery-item">
                <img src="images/event6.avif">
            </div>
            <div class="gallery-item">
                <img src="images/event7.jpg">
            </div>
            <div class="gallery-item">
                <img src="images/event8.avif">
            </div>
        </div>
    </section>

    <section class="practitioner-wellness-support">
        <h2>Wellness and Support</h2>
        <div class="wellness-grid">
            <!-- Health Tips Section -->
            <div class="wellness-tips">
                <h3>Practitioner Wellness Tips</h3>
                <ul>
                    <li>Take regular breaks during shifts to recharge your energy.</li>
                    <li>Practice mindfulness or meditation for stress management.</li>
                    <li>Stay connected with peers for emotional support and camaraderie.</li>
                    <li>Focus on hydration and healthy snacking during busy hours.</li>
                    <li>Prioritise sleep and establish a consistent bedtime routine.</li>
                </ul>
            </div>
    
            <!-- Resource Center Section -->
            <div class="resource-center">
                <h3>Professional Development Resources</h3>
                <ul>
                    <li><a href="https://support.mips.com.au/home/time-management-tips-for-healthcare-pros" target="_blank">Time Management Guide</a></li>
                    <li><a href="https://www.safetyandquality.gov.au/our-work/communicating-safety/communicating-patients-and-colleagues" target="_blank">Effective Patient Communication Tips</a></li>
                    <li><a href="https://www.e4recruitment.com.au/how-to-avoid-burnout-in-healthcare-professions" target="_blank">Burnout Prevention Strategies</a></li>
                    <li><a href="https://advancedclinicaled.com/" target="_blank">Continuing Professional Development Courses</a></li>
                    <li><a href="https://pubmed.ncbi.nlm.nih.gov/" target="_blank">Access to Medical Journals</a></li>
                </ul>
            </div>
        </div>
    </section>

    <section class="contact-section">
        <h2>Contact Us</h2>
        <p>Reach out to the appropriate department for assistance.</p>
        
        <div class="contact-grid">
            <div class="contact-item">
                <h3>Bookings</h3>
                <p>Email: <a href="mailto:bookings@nutrimedhealth.com">bookings@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61234567890">+61 2 3456 7890</a></p>
                <p>Timings: Monday to Friday, 8:00 AM - 6:00 PM</p>
            </div>
            <div class="contact-item">
                <h3>Reception</h3>
                <p>Email: <a href="mailto:reception@nutrimedhealth.com">reception@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61212345678">+61 2 1234 5678</a></p>
                <p>Timings: 24/7 Availability</p>
            </div>
            <!-- New Contacts -->
            <div class="contact-item">
                <h3>Pharmacy</h3>
                <p>Email: <a href="mailto:pharmacy@nutrimedhealth.com">pharmacy@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61265432109">+61 2 6543 2109</a></p>
                <p>Timings: Monday to Saturday, 9:00 AM - 5:00 PM</p>
            </div>
            <div class="contact-item">
                <h3>Dietician</h3>
                <p>Email: <a href="mailto:dietician@nutrimedhealth.com">dietician@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61254321098">+61 2 5432 1098</a></p>
                <p>Timings: Monday to Friday, 8:30 AM - 4:30 PM</p>
            </div>
            <div class="contact-item">
                <h3>IT Support</h3>
                <p>Email: <a href="mailto:itsupport@nutrimedhealth.com">itsupport@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61243210987">+61 2 4321 0987</a></p>
                <p>Timings: Monday to Friday, 9:00 AM - 6:00 PM</p>
            </div>
            <div class="contact-item">
                <h3>Security</h3>
                <p>Email: <a href="mailto:security@nutrimedhealth.com">security@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61232109876">+61 2 3210 9876</a></p>
                <p>Timings: 24/7 Availability</p>
            </div>
            <div class="contact-item">
                <h3>Ward A - Head Nurse</h3>
                <p>Email: <a href="mailto:warda.nurse@nutrimedhealth.com">warda.nurse@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61298765432">+61 2 9876 5432</a></p>
                <p>Timings: 24/7 Availability</p>
            </div>
            <div class="contact-item">
                <h3>Ward B - Head Nurse</h3>
                <p>Email: <a href="mailto:wardb.nurse@nutrimedhealth.com">wardb.nurse@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61287654321">+61 2 8765 4321</a></p>
                <p>Timings: 24/7 Availability</p>
            </div>
            <div class="contact-item">
                <h3>Ward C - Head Nurse</h3>
                <p>Email: <a href="mailto:wardc.nurse@nutrimedhealth.com">wardc.nurse@nutrimedhealth.com</a></p>
                <p>Phone: <a href="tel:+61276543210">+61 2 7654 3210</a></p>
                <p>Timings: 24/7 Availability</p>
            </div>
        </div>
        <div class="extra-contact">
            <h3>Need More Help?</h3>
            <p>
                For general inquiries, please contact us at 
                <a href="mailto:support@nutrimedhealth.com">support@nutrimedhealth.com</a> 
                or call our main line at <a href="tel:+61255555555">+61 2 5555 5555</a>.
            </p>
            <p>Timings: Monday to Friday, 9:00 AM - 5:00 PM</p>
        </div>
    </section>
    </div>
</body>
</html>
