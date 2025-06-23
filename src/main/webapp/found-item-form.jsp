<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Found Item - Lost-and-Found Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
       
    <link rel="stylesheet" href="css/form-style.css"> 
    
</head>
<body>

<header>
    <div class="container">
        <h1>Report a Found Item</h1>
        <p>Fill out the form below to report a found item.</p>
    </div>
</header>

<nav class="navbar">
    <div class="navbar-container">
        <ul class="navbar-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="about-us.jsp">About Us</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="privacy-policy.jsp">Privacy Policy</a></li>
            <li><a href="terms-and-conditions.jsp">Terms and Conditions</a></li>
        </ul>
    </div>
</nav>

<section class="form-section">
    <div id="categoryInfo" class="category-info">
        <p><strong>Category Descriptions:</strong></p>
        <ul>
            <li><strong>Product</strong>: Items like electronics, gadgets, clothing, shoes, etc.</li>
            <li><strong>Humans/Animals</strong>: Report found people or pets.</li>
            <li><strong>Documents</strong>: Include IDs, passports, birth certificates, etc.</li>
            <li><strong>Valuables</strong>: Jewelry, watches, wallets, and other high-value items.</li>
            <li><strong>Vehicles</strong>: Cars, bikes, and other vehicles.</li>
        </ul>
    </div>

    <form action="/LostAndFoundHub/FoundItemServlet" method="POST" enctype="multipart/form-data" class="form-container" id="foundItemForm" novalidate>

        <!-- Item Category Selection -->
        <label for="itemCategory">Choose the type of item you found:</label>
        <select id="itemCategory" name="itemCategory" required>
            <option value="">Select Category</option>
            <option value="product">Product</option>
            <option value="humans_animals">Humans/Animals</option>
            <option value="documents">Documents</option>
            <option value="valuables">Valuables</option>
            <option value="vehicles">Vehicles</option>
        </select>

        <!-- Product Section -->
        <div id="productSection" class="category-section hidden">
            <label for="productName">Product Name (mandatory):</label>
            <input type="text" id="productName" name="productName" placeholder="Enter product name">
            
            <label for="productBrand">Brand (optional):</label>
            <input type="text" id="productBrand" name="productBrand" placeholder="Enter brand name">
            
            <label for="productColor">Color (mandatory):</label>
            <input type="text" id="productColor" name="productColor" placeholder="Enter color of the product">
            
            <label for="productDescription">Description (mandatory):</label>
            <textarea id="productDescription" name="productDescription" placeholder="Describe the product in detail"></textarea>
            
            <label for="foundLocation">Location Found (mandatory):</label>
            <input type="text" id="foundLocation" name="foundLocation" placeholder="Enter the location where you found the item">

            <label for="foundDate">Date Found (mandatory):</label>
            <input type="date" id="foundDate" name="foundDate">
            
            <label for="serialNumber">Model Number/Serial Number (optional):</label>
            <input type="text" id="serialNumber" name="serialNumber" placeholder="Enter model or serial number">
            
            <!-- Contact Info -->
            <label><strong>Contact Info:</strong></label>
            <div class="contact-container">
                <label for="productPhone">Phone Number:</label>
                <input type="tel" id="productPhone" name="productPhone" placeholder="Enter phone number" pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
            </div>
            <div class="contact-container">
                <label for="productEmail">Email ID:</label>
                <input type="email" id="productEmail" name="productEmail" placeholder="Enter email ID">
            </div>
            
            <!-- Image Upload -->
            <label for="productImage">Upload Image of the Product (mandatory):</label>
            <input type="file" id="productImage" name="productImage" accept="image/*">
        </div>

        <!-- Humans/Animals Section -->
        <div id="humans_animalsSection" class="category-section hidden">
            <label for="name">Name of Human/Animal or Breed (mandatory):</label>
            <input type="text" id="name" name="name" placeholder="Enter name or breed">
            
             <label for="humanImage">Upload Image (mandatory):</label>
            <input type="file" id="humanImage" name="humanImage" accept="image/*">
            
            <label for="skinTone">Skin Tone (mandatory):</label>
            <input type="text" id="skinTone" name="skinTone" placeholder="Enter skin tone">
            
            <label for="foundTime">Time Found (optional):</label>
            <input type="time" id="foundTime" name="foundTime" placeholder="Enter the time the person/animal was found">
            
            <label for="foundLocationHuman">Location Found (mandatory):</label>
            <input type="text" id="foundLocationHuman" name="foundLocationHuman" placeholder="Enter location found">

            <label for="height">Height (mandatory):</label>
            <input type="text" id="height" name="height" placeholder="Enter height">
            
            <label for="birthmark">Birthmark (optional):</label>
            <input type="text" id="birthmark" name="birthmark" placeholder="Enter any known birthmarks">
            
            <label for="behavioralNotes">Behavioral Notes (optional):</label>
            <textarea id="behavioralNotes" name="behavioralNotes" placeholder="Describe any distinguishing behavior"></textarea>
            
            <label for="foundDateHuman">Date Found (mandatory):</label>
            <input type="date" id="foundDateHuman" name="foundDateHuman">
            
            

            <!-- Contact Info -->
            <label><strong>Contact Info:</strong></label>
            <div class="contact-container">
                <label for="humanPhone">Phone Number:</label>
                <input type="tel" id="humanPhone" name="humanPhone" placeholder="Enter phone number" pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
            </div>
            <div class="contact-container">
                <label for="humanEmail">Email ID:</label>
                <input type="email" id="humanEmail" name="humanEmail" placeholder="Enter email ID">
            </div>
        </div>

        <!-- Documents Section -->
        <div id="documentsSection" class="category-section hidden">
            <label for="documentName">Document Name (e.g., Adhar Card, Marksheet) (mandatory):</label>
            <input type="text" id="documentName" name="documentName" placeholder="Enter document name">
            
            <label for="issuedBy">Issued By (e.g., school, college, government) (mandatory):</label>
            <input type="text" id="issuedBy" name="issuedBy" placeholder="Enter the issuer of the document">

            <label for="documentNumber">Document Number (mandatory):</label>
            <input type="text" id="documentNumber" name="documentNumber" placeholder="Enter document number">

            <label for="documentLocation">Location Found (mandatory):</label>
            <input type="text" id="documentLocation" name="documentLocation" placeholder="Enter the location where the document was found">

            <label for="issueDate">Date of Issue (mandatory):</label>
            <input type="date" id="issueDate" name="issueDate">

            <label for="foundDateDocument">Date Found (mandatory):</label>
            <input type="date" id="foundDateDocument" name="foundDateDocument">

            <!-- Contact Info -->
            <label><strong>Contact Info:</strong></label>
            <div class="contact-container">
                <label for="docPhone">Phone Number:</label>
                <input type="tel" id="docPhone" name="docPhone" placeholder="Enter phone number" pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
            </div>
            <div class="contact-container">
                <label for="docEmail">Email ID:</label>
                <input type="email" id="docEmail" name="docEmail" placeholder="Enter email ID">
            </div>
            
            <!-- Image Upload -->
            <label for="documentImage">Upload Image of the Document (mandatory):</label>
            <input type="file" id="documentImage" name="documentImage" accept="image/*">
        </div>

        <!-- Valuables Section -->
        <div id="valuablesSection" class="category-section hidden">
            <label for="valuablesDescription">Describe the Found Valuable Item (mandatory):</label>
            <input type="text" id="valuablesDescription" name="valuablesDescription" placeholder="Describe the item">
            
            <label for="valuablesLocation">Location Found (mandatory):</label>
            <input type="text" id="valuablesLocation" name="valuablesLocation" placeholder="Enter location where found">

            <label for="foundDateValuables">Date Found (mandatory):</label>
            <input type="date" id="foundDateValuables" name="foundDateValuables">

            <!-- Contact Info -->
            <label><strong>Contact Info:</strong></label>
            <div class="contact-container">
                <label for="valuablesPhone">Phone Number:</label>
                <input type="tel" id="valuablesPhone" name="valuablesPhone" placeholder="Enter phone number" pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
            </div>
            <div class="contact-container">
                <label for="valuablesEmail">Email ID:</label>
                <input type="email" id="valuablesEmail" name="valuablesEmail" placeholder="Enter email ID">
            </div>
            
            <!-- Image Upload -->
            <label for="valuablesImage">Upload Image of the Valuable Item (mandatory):</label>
            <input type="file" id="valuablesImage" name="valuablesImage" accept="image/*">
        </div>

        <!-- Vehicles Section -->
        <div id="vehiclesSection" class="category-section hidden">
            <label for="vehicleType">Type of Vehicle (e.g., Car, Bike) (mandatory):</label>
            <input type="text" id="vehicleType" name="vehicleType" placeholder="Enter vehicle type">
            
            <label for="vehicleName">Vehicle Name (mandatory):</label>
            <input type="text" id="vehicleName" name="vehicleName" placeholder="Enter vehicle name">
            
            <label for="vehicleColor">Color of Vehicle (mandatory):</label>
            <input type="text" id="vehicleColor" name="vehicleColor" placeholder="Enter vehicle color">

            <label for="registrationNumber">Registration Number (optional):</label>
            <input type="text" id="registrationNumber" name="registrationNumber" placeholder="Enter registration number">

            <label for="makeModel">Make and Model (mandatory):</label>
            <input type="text" id="makeModel" name="makeModel" placeholder="Enter make and model">

            <label for="chassisNumber">Chassis Number/Engine Number (mandatory):</label>
            <input type="text" id="chassisNumber" name="chassisNumber" placeholder="Enter chassis or engine number">

            <label for="additionalNotes">Additional Notes (mandatory):</label>
            <textarea id="additionalNotes" name="additionalNotes" placeholder="Describe any distinguishing features"></textarea>

            <label for="vehicleFoundDate">Date Found (mandatory):</label>
            <input type="date" id="vehicleFoundDate" name="vehicleFoundDate">

            <!-- Contact Info -->
            <label><strong>Contact Info:</strong></label>
            <div class="contact-container">
                <label for="vehiclePhone">Phone Number:</label>
                <input type="tel" id="vehiclePhone" name="vehiclePhone" placeholder="Enter phone number" pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
            </div>
            <div class="contact-container">
                <label for="vehicleEmail">Email ID:</label>
                <input type="email" id="vehicleEmail" name="vehicleEmail" placeholder="Enter email ID">
            </div>
            
            <!-- Image Upload -->
            <label for="vehicleImage">Upload Image of the Vehicle (mandatory):</label>
            <input type="file" id="vehicleImage" name="vehicleImage" accept="image/*">
        </div>

        <!-- Submit Button Section -->
        <div class="form-submit-container">
            <button type="submit" class="form-submit-button">Submit Report</button>
        </div>
    </form>
</section>

<footer>
    <p>&copy; 2024 Lost-and-Found Hub. All rights reserved.</p>
</footer>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const categorySelect = document.getElementById('itemCategory');
        const allSections = document.querySelectorAll('.category-section');
        const form = document.getElementById('foundItemForm');
        
        // Function to show the selected section and hide others
        function showSelectedSection() {
            const selectedValue = categorySelect.value;
            
            allSections.forEach(section => {
                section.classList.add('hidden');
            });
            
            if (selectedValue) {
                const activeSection = document.getElementById(selectedValue + 'Section');
                if (activeSection) {
                    activeSection.classList.remove('hidden');
                }
            }
        }
        
        // Initialize the form
        showSelectedSection();
        
        // Handle category changes
        categorySelect.addEventListener('change', showSelectedSection);
        
        // Custom form validation
        form.addEventListener('submit', function(e) {
            const selectedCategory = categorySelect.value;
            if (!selectedCategory) {
                alert('Please select a category');
                e.preventDefault();
                return;
            }
            
            const activeSection = document.getElementById(selectedCategory + 'Section');
            if (!activeSection) {
                alert('Invalid category selection');
                e.preventDefault();
                return;
            }
            
            // Manually validate required fields in the active section
            let isValid = true;
            const requiredFields = activeSection.querySelectorAll('[required]');
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = 'red';
                    
                    // Focus the first invalid field
                    if (isValid === false) {
                        field.focus();
                        isValid = true; // Prevent multiple alerts
                    }
                } else {
                    field.style.borderColor = '';
                }
            });
            
            // Validate email format if email field exists
            const emailField = activeSection.querySelector('input[type="email"]');
            if (emailField && emailField.value) {
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(emailField.value)) {
                    alert('Please enter a valid email address');
                    emailField.style.borderColor = 'red';
                    emailField.focus();
                    e.preventDefault();
                    return;
                }
            }
            
            // Validate phone format if phone field exists
            const phoneField = activeSection.querySelector('input[type="tel"]');
            if (phoneField && phoneField.value) {
                const phoneRegex = /^\d{10}$/;
                if (!phoneRegex.test(phoneField.value)) {
                    alert('Please enter a valid 10-digit phone number');
                    phoneField.style.borderColor = 'red';
                    phoneField.focus();
                    e.preventDefault();
                    return;
                }
            }
            
            if (!isValid) {
                alert('Please fill in all required fields');
                e.preventDefault();
            }
        });
    });
</script>

</body>
</html>