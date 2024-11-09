document.addEventListener("DOMContentLoaded", function() {
    // This function can be expanded to add interactivity to your reports page
    const messageElement = document.getElementById("message");

    // Example function to handle any actions needed after the page loads
    function handlePageLoad() {
        // For example, you can add alerts, or any specific handling you need
        console.log("Reports page loaded successfully.");
        
        // Display a message if there are no books to display
        const tableBody = document.querySelector("tbody");
        if (tableBody.rows.length === 0) {
            messageElement.textContent = "No books available to display.";
        }
    }

    handlePageLoad();

    // If you want to add any button click events or other interactions, 
    // you can add them here.
});
