document.getElementById("assignForm").addEventListener("submit", function(event) {
    event.preventDefault(); // Prevent the default form submission
    const form = event.target; // Get the form
    const formData = new FormData(form); // Create FormData object

    console.log("Submitting form with action: " + formData.get("action")); // Log action

    fetch("BookServlet", {
        method: "POST",
        body: formData, // Form data should contain the action parameter
    })
    .then(response => {
        if (!response.ok) {
            throw new Error("Network response was not ok: " + response.statusText);
        }
        return response.text(); // Assuming your servlet returns a message as text
    })
    .then(result => {
        document.getElementById("message").textContent = result; // Display the result message
        // form.reset(); // Uncomment if you want to reset the form after successful submission
    })
    .catch(error => {
        document.getElementById("message").textContent = "Error assigning book to shelf: " + error.message;
        console.error("Error:", error);
    });
});
