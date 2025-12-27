// Patient Record Management System - Main JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Initialize the application
    initializeApp();
});

function initializeApp() {
    // Set up event listeners
    setupFormValidation();
    setupConfirmDialogs();
    setupSearchFunctionality();
    setupStatusUpdates();
   
    // Auto-hide alerts after 5 seconds
    autoHideAlerts();
   
    // Add fade-in animation to main content
    document.querySelector('.main-content')?.classList.add('fade-in');
}

// Form Validation
function setupFormValidation() {
    const forms = document.querySelectorAll('form');
   
    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!validateForm(this)) {
                e.preventDefault();
                showAlert('Please fill in all required fields correctly.', 'error');
            }
        });
    });
}

function validateForm(form) {
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
   
    requiredFields.forEach(field => {
        if (!field.value.trim()) {
            field.style.borderColor = '#e74c3c';
            isValid = false;
        } else {
            field.style.borderColor = '#ecf0f1';
        }
    });
   
    // Email validation
    const emailFields = form.querySelectorAll('input[type="email"]');
    emailFields.forEach(field => {
        if (field.value && !isValidEmail(field.value)) {
            field.style.borderColor = '#e74c3c';
            isValid = false;
        }
    });
   
    // Phone validation
    const phoneFields = form.querySelectorAll('input[type="tel"]');
    phoneFields.forEach(field => {
        if (field.value && !isValidPhone(field.value)) {
            field.style.borderColor = '#e74c3c';
            isValid = false;
        }
    });
   
    return isValid;
}

function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function isValidPhone(phone) {
    const phoneRegex = /^[\+]?[1-9][\d]{0,15}$/;
    return phoneRegex.test(phone.replace(/[\s\-\(\)]/g, ''));
}

// Confirmation Dialogs
function setupConfirmDialogs() {
    const deleteButtons = document.querySelectorAll('.btn-danger, [onclick*="delete"]');
   
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to delete this record? This action cannot be undone.')) {
                e.preventDefault();
                return false;
            }
        });
    });
}

// Search Functionality
function setupSearchFunctionality() {
    const searchForms = document.querySelectorAll('.search-form');
   
    searchForms.forEach(form => {
        const searchButton = form.querySelector('button[type="submit"]');
        const clearButton = document.createElement('button');
        clearButton.type = 'button';
        clearButton.className = 'btn btn-secondary';
        clearButton.textContent = 'Clear';
        clearButton.onclick = function() {
            form.reset();
            // Reload the page to show all records
            window.location.href = window.location.pathname;
        };
       
        if (searchButton) {
            searchButton.parentNode.insertBefore(clearButton, searchButton.nextSibling);
        }
    });
}

// Status Updates
function setupStatusUpdates() {
    const statusButtons = document.querySelectorAll('[data-status-update]');
   
    statusButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            const appointmentId = this.getAttribute('data-appointment-id');
            const newStatus = this.getAttribute('data-status');
           
            if (confirm(`Are you sure you want to change the status to ${newStatus}?`)) {
                updateAppointmentStatus(appointmentId, newStatus);
            }
        });
    });
}

function updateAppointmentStatus(appointmentId, status) {
    // Show loading state
    showLoading();
   
    fetch(`/appointments/${appointmentId}/status/${status}`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        }
    })
    .then(response => {
        if (response.ok) {
            showAlert(`Appointment status updated to ${status}`, 'success');
            // Refresh the page after a short delay
            setTimeout(() => {
                window.location.reload();
            }, 1500);
        } else {
            throw new Error('Failed to update status');
        }
    })
    .catch(error => {
        showAlert('Error updating appointment status', 'error');
    })
    .finally(() => {
        hideLoading();
    });
}

// Alert Functions
function showAlert(message, type = 'info') {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.textContent = message;
   
    const container = document.querySelector('.container');
    if (container) {
        container.insertBefore(alertDiv, container.firstChild);
       
        // Auto-hide after 5 seconds
        setTimeout(() => {
            alertDiv.remove();
        }, 5000);
    }
}

function autoHideAlerts() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            setTimeout(() => {
                alert.remove();
            }, 300);
        }, 5000);
    });
}

// Loading Functions
function showLoading() {
    let loadingDiv = document.querySelector('.loading-overlay');
    if (!loadingDiv) {
        loadingDiv = document.createElement('div');
        loadingDiv.className = 'loading-overlay';
        loadingDiv.innerHTML = '<div class="loading-spinner"></div>';
        loadingDiv.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        `;
        document.body.appendChild(loadingDiv);
    }
    loadingDiv.style.display = 'flex';
}

function hideLoading() {
    const loadingDiv = document.querySelector('.loading-overlay');
    if (loadingDiv) {
        loadingDiv.style.display = 'none';
    }
}

// Table Enhancement
function enhanceTable(tableSelector) {
    const table = document.querySelector(tableSelector);
    if (!table) return;
   
    // Add sorting capability
    const headers = table.querySelectorAll('th');
    headers.forEach((header, index) => {
        if (header.textContent.trim()) {
            header.style.cursor = 'pointer';
            header.addEventListener('click', () => sortTable(table, index));
        }
    });
   
    // Add row hover effects
    const rows = table.querySelectorAll('tbody tr');
    rows.forEach(row => {
        row.addEventListener('mouseenter', function() {
            this.style.backgroundColor = '#f8f9fa';
        });
        row.addEventListener('mouseleave', function() {
            this.style.backgroundColor = '';
        });
    });
}

function sortTable(table, columnIndex) {
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
   
    const sortedRows = rows.sort((a, b) => {
        const aText = a.cells[columnIndex].textContent.trim();
        const bText = b.cells[columnIndex].textContent.trim();
       
        // Try to sort as numbers first
        const aNum = parseFloat(aText);
        const bNum = parseFloat(bText);
       
        if (!isNaN(aNum) && !isNaN(bNum)) {
            return aNum - bNum;
        }
       
        // Sort as text
        return aText.localeCompare(bText);
    });
   
    // Re-append sorted rows
    sortedRows.forEach(row => tbody.appendChild(row));
}

// Date/Time Utilities
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString();
}

function formatDateTime(dateTimeString) {
    const date = new Date(dateTimeString);
    return date.toLocaleString();
}

// Form Auto-save (for long forms)
function setupAutoSave(formSelector) {
    const form = document.querySelector(formSelector);
    if (!form) return;
   
    const formData = {};
    const inputs = form.querySelectorAll('input, select, textarea');
   
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            formData[this.name] = this.value;
            localStorage.setItem('formAutoSave', JSON.stringify(formData));
        });
    });
   
    // Restore saved data on page load
    const savedData = localStorage.getItem('formAutoSave');
    if (savedData) {
        const data = JSON.parse(savedData);
        Object.keys(data).forEach(key => {
            const input = form.querySelector(`[name="${key}"]`);
            if (input) {
                input.value = data[key];
            }
        });
    }
   
    // Clear saved data on successful submit
    form.addEventListener('submit', function() {
        localStorage.removeItem('formAutoSave');
    });
}

// Responsive Table
function makeTableResponsive() {
    const tables = document.querySelectorAll('.table');
   
    tables.forEach(table => {
        if (window.innerWidth < 768) {
            table.style.fontSize = '0.8rem';
           
            // Hide less important columns on mobile
            const headers = table.querySelectorAll('th');
            const rows = table.querySelectorAll('tbody tr');
           
            headers.forEach((header, index) => {
                if (header.classList.contains('hide-mobile')) {
                    header.style.display = 'none';
                    rows.forEach(row => {
                        if (row.cells[index]) {
                            row.cells[index].style.display = 'none';
                        }
                    });
                }
            });
        }
    });
}

// Initialize responsive features
window.addEventListener('resize', makeTableResponsive);
makeTableResponsive();

// Initialize table enhancements
document.addEventListener('DOMContentLoaded', function() {
    enhanceTable('.table');
});
