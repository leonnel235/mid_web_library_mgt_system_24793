// Smooth scrolling for navbar links
document.querySelectorAll('.navbar a').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        if (this.hash !== "") {
            e.preventDefault();
            document.querySelector(this.hash).scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// Fade-in effect on page load
window.addEventListener('load', () => {
    document.body.classList.add('fade-in');
});

// Intersection Observer for revealing sections on scroll
const observerOptions = {
    threshold: 0.1
};

const revealOnScroll = (entries, observer) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            observer.unobserve(entry.target); // Only animate once
        }
    });
};

const observer = new IntersectionObserver(revealOnScroll, observerOptions);
document.querySelectorAll('.featured-section, .welcome-message').forEach(section => {
    observer.observe(section);
});
