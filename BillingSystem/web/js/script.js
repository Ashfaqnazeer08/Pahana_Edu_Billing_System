$(document).ready(function () {
    // Sidebar submenu toggle
    $('.has-submenu > a').click(function (e) {
        e.preventDefault();
        $(this).siblings('.submenu').slideToggle();
        $(this).find('.toggle-icon').toggleClass('fa-chevron-down fa-chevron-up');
    });

    // Counter animation
    animateCounter("#billCount", 142);
    animateCounter("#customerCount", 37);
    animateCounter("#itemCount", 89);
});

function animateCounter(id, target) {
    let count = 0;
    let interval = setInterval(() => {
        if (count < target) {
            count++;
            $(id).text(count);
        } else {
            clearInterval(interval);
        }
    }, 20); // speed of counting
}

//Customer
function openModal() {
    $('#addCustomerModal').fadeIn();
}
function closeModal() {
    $('#addCustomerModal').fadeOut();
}

// Validate name, email, phone before submitting
function validateCustomerForm() {
    let phone = document.querySelector('input[name="phone"]').value;
    let email = document.querySelector('input[name="email"]').value;
    let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (phone.length !== 10 || isNaN(phone)) {
        showMessage("Phone number must be 10 digits", "error");
        return false;
    }

    if (!emailPattern.test(email)) {
        showMessage("Enter a valid email address", "error");
        return false;
    }

    return true;
}

// Show custom message box
function showMessage(msg, type) {
    let box = document.getElementById("messageBox");
    box.className = "message " + type;
    box.innerText = msg;
    box.style.display = "block";
    setTimeout(() => box.style.display = "none", 4000);
}

// Show auto-dismiss alerts based on query parameter
$(document).ready(function () {
    const params = new URLSearchParams(window.location.search);
    const success = params.get("success");

    let message = "";
    let type = "";
    if (success === "2") {
        message = "Customer updated successfully!";
        type = "success";
    } else if (success === "3") {
        message = "Customer deleted successfully!";
        type = "success";
    } else if (success === "0") {
        message = "An error occurred. Please try again.";
        type = "danger";
    }

    if (message !== "") {
        const alertBox = `<div class="alert alert-${type} alert-dismissible fade show" role="alert">
                            <strong>${message}</strong>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
        $("#messageBox").html(alertBox);

        setTimeout(() => {
            $(".alert").alert('close');
        }, 3000);
    }
});


