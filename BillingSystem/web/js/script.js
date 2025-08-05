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

