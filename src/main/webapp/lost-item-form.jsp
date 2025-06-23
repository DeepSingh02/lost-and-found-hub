<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Lost Item - Lost-and-Found Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="css/form-style.css"> 
</head>
<body>

<header>
    <div class="container">
        <h1>Report a Lost Item</h1>
        <p>Fill out the form below to report your lost item.</p>
    </div>
</header>

<nav class="navbar">
    <div class="navbar-container">
        <ul class="navbar-links">
            <li><a href="index.html">Home</a></li>
            <li><a href="about-us.html">About Us</a></li>
            <li><a href="contact.html">Contact</a></li>
            <li><a href="privacy-policy.html">Privacy Policy</a></li>
            <li><a href="terms-and-conditions.html">Terms and Conditions</a></li>
        </ul>
    </div>
</nav>
    
    

<section class="form-section">
    
    <!-- Category Description Info -->
<div id="categoryInfo" class="category-info">
    <p><strong>Category Descriptions:</strong></p>
    <ul>
        <li><strong>Product</strong>: Items like electronics, gadgets, clothing, shoes, etc.</li>
        <li><strong>Humans/Animals</strong>: Report lost people or pets.</li>
        <li><strong>Documents</strong>: Include IDs, passports, birth certificates, etc.</li>
        <li><strong>Valuables</strong>: Jewelry, watches, wallets, and other high-value items.</li>
        <li><strong>Vehicles</strong>: Cars, bikes, and other vehicles.</li>
    </ul>
</div>
    
    <form action="/LostAndFoundHub/LostItemServlet" method="POST" enctype="multipart/form-data" class="form-container" id="lostItemForm">
        
        <!-- Hidden input for unique Report ID -->
        <input type="hidden" name="reportId" id="reportId">

        <label for="itemCategory">Choose the type of item you have lost:</label>
        <select id="itemCategory" name="itemCategory" required>
            <option value="">Select Category</option>
            <option value="product">Product</option>
            <option value="humans-animals">Humans/Animals</option>
            <option value="documents">Documents</option>
            <option value="valuables">Valuables</option>
            <option value="vehicles">Vehicles</option>
        </select>

        <!-- Product Section -->
        <div id="productSection" class="category-section hidden">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" placeholder="Enter product name">
            
            <label for="brand">Brand:</label>
            <input type="text" id="brand" name="brand" placeholder="Enter brand">
            
            <label for="color">Color:</label>
            <input type="text" id="color" name="color" placeholder="Enter color">
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" placeholder="Enter description"></textarea>
            
            <label for="lostLocation">Lost Location:</label>
            <input type="text" id="lostLocation" name="lostLocation" placeholder="Enter lost location">
            
            <label for="lostDate">Date Lost:</label>
            <input type="date" id="lostDate" name="lostDate">
            
            <label for="bill">Upload Bill/Receipt:</label>
            <input type="file" id="bill" name="bill">
            
            <label for="serialNumber">Serial Number:</label>
            <input type="text" id="serialNumber" name="serialNumber" placeholder="Enter serial number">
            
           <label for="contactInfo"><strong>Contact Info:</strong></label>

<div class="contact-container">
    <label for="phoneNumber">Phone Number:</label>
    <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="Enter phone number" required pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
</div>

<div class="contact-container">
    <label for="email">Email ID:</label>
    <input type="email" id="email" name="email" placeholder="Enter email ID" required>
</div>
            
            <label for="reward">Reward (if any):</label>
            <input type="number" id="reward" name="reward" placeholder="Enter reward amount">
        </div>

        <!-- Humans/Animals Section -->
        <div id="humansAnimalsSection" class="category-section hidden">
            <label for="name">Name or Breed:</label>
            <input type="text" id="name" name="name" placeholder="Enter name or breed">
            
            <label for="skinTone">Skin Tone/Color:</label>
            <input type="text" id="skinTone" name="skinTone" placeholder="Enter skin tone/color">
            
            <label for="age">Age:</label>
            <input type="text" id="age" name="age" placeholder="Enter age">
            
            <label for="lastSeenTime">Last Seen Time:</label>
            <input type="datetime-local" id="lastSeenTime" name="lastSeenTime">
            
            <label for="lastSeenLocation">Last Seen Location:</label>
            <input type="text" id="lastSeenLocation" name="lastSeenLocation" placeholder="Enter last seen location">
            
            <label for="height">Height:</label>
            <input type="text" id="height" name="height" placeholder="Enter height">
            
            <label for="birthmark">Birthmark/Identifying Marks:</label>
            <textarea id="birthmark" name="birthmark" placeholder="Enter birthmark or identifying marks"></textarea>
            
            <label for="behavioralNotes">Behavioral Notes:</label>
            <textarea id="behavioralNotes" name="behavioralNotes" placeholder="Enter behavioral notes"></textarea>
            
            <label for="photo">Upload a Photo:</label>
            <input type="file" id="photo" name="photo">
            
            <label for="ownerRelation">Who are you? (e.g., owner, family member):</label>
            <input type="text" id="ownerRelation" name="ownerRelation" placeholder="Describe your relation to the lost person/animal">
            
            <label for="contactInfo"><strong>Contact Info:</strong></label>

<div class="contact-container">
    <label for="human_phoneNumber">Phone Number:</label>
    <input type="tel" id="human_phoneNumber" name="human_phoneNumber" placeholder="Enter phone number" required pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
</div>

<div class="contact-container">
    <label for="human_email">Email ID:</label>
    <input type="email" id="human_email" name="human_email" placeholder="Enter email ID" required>
</div>
            
            <label for="human_reward">Reward (if any):</label>
            <input type="number" id="human_reward" name="human_reward" placeholder="Enter reward amount">
        </div>

        <!-- Documents Section -->
        <div id="documentsSection" class="category-section hidden">
            <label for="documentName">Document Name:</label>
            <input type="text" id="documentName" name="documentName" placeholder="Enter document name">
            
            <label for="issuedBy">Issued By:</label>
            <input type="text" id="issuedBy" name="issuedBy" placeholder="Enter issued by">
            
            <label for="documentNumber">Document Number:</label>
            <input type="text" id="documentNumber" name="documentNumber" placeholder="Enter document number">
            
            <label for="xeroxCopy">Upload Xerox Copy:</label>
            <input type="file" id="xeroxCopy" name="xeroxCopy">
            
            <label for="doc_lostLocation">Lost Location:</label>
            <input type="text" id="doc_lostLocation" name="doc_lostLocation" placeholder="Enter lost location">
            
            <label for="doc_issueDate">Issue Date:</label>
            <input type="doc_date" id="doc_issueDate" name="issueDate">
            
           <label for="doc_lostDate">Date Lost:</label>
           <input type="date" id="doc_lostDate" name="doc_lostDate">

            
            <label for="contactInfo"><strong>Contact Info:</strong></label>

<div class="contact-container">
    <label for="documents_phoneNumber">Phone Number:</label>
    <input type="tel" id="documents_phoneNumber" name="documents_phoneNumber" placeholder="Enter phone number" required pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
</div>

<div class="contact-container">
    <label for="documents_email">Email ID:</label>
    <input type="email" id="documents_email" name="documents_email" placeholder="Enter email ID" required>
</div>
            
            <label for="reward">Reward (if any):</label>
            <input type="number" id="reward" name="reward" placeholder="Enter reward amount">
        </div>

        <!-- Valuables Section -->
        <div id="valuablesSection" class="category-section hidden">
            <label for="description">Description:</label>
            <textarea id="description" name="description" placeholder="Describe the valuable"></textarea>
            
            <label for="val_lostLocation">Lost Location:</label>
            <input type="text" id="val_lostLocation" name="val_lostLocation" placeholder="Enter lost location">
            
            <label for="val_lostDate">Date Lost:</label>
            <input type="date" id="val_lostDate" name="val_lostDate">
            
           <label for="contactInfo"><strong>Contact Info:</strong></label>

<div class="contact-container">
    <label for="valuables_phoneNumber">Phone Number:</label>
    <input type="tel" id="valuables_phoneNumber" name="valuables_phoneNumber" placeholder="Enter phone number" required pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
</div>

<div class="contact-container">
    <label for="valuables_email">Email ID:</label>
    <input type="email" id="valuables_email" name="valuables_email" placeholder="Enter email ID" required>
</div>
            
            <label for="val_reward">Reward (if any):</label>
            <input type="number" id="val_reward" name="val_reward" placeholder="Enter reward amount">
        </div>

        <!-- Vehicles Section -->
        <div id="vehiclesSection" class="category-section hidden">
            <label for="vehicleType">Vehicle Type:</label>
            <input type="text" id="vehicleType" name="vehicleType" placeholder="Car, Bike, etc.">
            
            <label for="vehicleName">Vehicle Name:</label>
            <input type="text" id="vehicleName" name="vehicleName" placeholder="Enter vehicle name">
            
            <label for="color">Color:</label>
            <input type="text" id="color" name="color" placeholder="Enter color">
            
            <label for="registrationNumber">Registration Number:</label>
            <input type="text" id="registrationNumber" name="registrationNumber" placeholder="Enter registration number">
            
            <label for="makeModel">Make/Model:</label>
            <input type="text" id="makeModel" name="makeModel" placeholder="Enter make/model">
            
            <label for="chassisNumber">Chassis Number:</label>
            <input type="text" id="chassisNumber" name="chassisNumber" placeholder="Enter chassis number">
            
            <label for="additionalNotes">Additional Notes:</label>
            <textarea id="additionalNotes" name="additionalNotes" placeholder="Enter additional notes"></textarea>
            
            <label for="rcCopy">Upload RC Copy:</label>
            <input type="file" id="rcCopy" name="rcCopy">
            
            <label for="vec_lostDate">Date Lost:</label>
            <input type="date" id="vec_lostDate" name="vec_lostDate">
            
            <label for="contactInfo"><strong>Contact Info:</strong></label>

<div class="contact-container">
    <label for="vehicles_phoneNumber">Phone Number:</label>
    <input type="tel" id="vehicles_phoneNumber" name="vehicles_phoneNumber" placeholder="Enter phone number" required pattern="[0-9]{10}" title="Enter a valid 10-digit phone number">
</div>

<div class="contact-container">
    <label for="vehicles_email">Email ID:</label>
    <input type="email" id="vehicles_email" name="vehicles_email" placeholder="Enter email ID" required>
</div>
            
            <label for="vec_reward">Reward (if any):</label>
            <input type="number" id="vec_reward" name="vec_reward" placeholder="Enter reward amount">
        </div>

        <div class="form-submit-container">
            <button type="submit" class="form-submit-button">Submit Report</button>
        </div>
    </form>
</section>

<footer>
    <p>&copy; 2024 Lost-and-Found Hub. All rights reserved.</p>
</footer>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById('lostItemForm');
    const reportIdField = document.getElementById('reportId');
    const categoryDropdown = document.getElementById('itemCategory');

    function toggleRequiredFields(section, isVisible) {
        if (!section) return;
        section.querySelectorAll("input, textarea, select").forEach(field => {
            if (field.name !== "reward") { // Reward field should always be optional
                if (!isVisible) {
                    field.removeAttribute("required");
                } else {
                    field.setAttribute("required", "true");
                }
            }
        });
    }

    // Generate Unique Report ID on form submission
    if (form && reportIdField) {
        form.addEventListener('submit', function () {
            reportIdField.value = 'RID-' + Date.now(); 
        });
    }

    // Handle category selection and show the correct section
    if (categoryDropdown) {
        categoryDropdown.addEventListener('change', function () {
            // Hide all sections
            document.querySelectorAll('.category-section').forEach(section => {
                section.classList.add('hidden');
                toggleRequiredFields(section, false);
            });

            let selectedCategory = this.value;

            // Fix ID issue for Humans/Animals category
            if (selectedCategory === "humans-animals") {
                selectedCategory = "humansAnimals";
            }

            // Show the selected category section
            const sectionToShow = document.getElementById(selectedCategory + 'Section');
            if (sectionToShow) {
                sectionToShow.classList.remove('hidden');
                toggleRequiredFields(sectionToShow, true);
            }
        });
    }
});
</script>

</body>
</html>