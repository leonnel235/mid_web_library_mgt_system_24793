document.getElementById('registerForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const membershipTypeId = document.getElementById('membershipType').value;
    const membershipCode = document.getElementById('membershipCode').value;
    const registrationDate = document.getElementById('registrationDate').value;
    const expiringDate = document.getElementById('expiringDate').value;
    const membershipStatus = document.getElementById('membershipStatus').value;

    if (!membershipTypeId) {
        document.getElementById('message').textContent = "Please select a membership type.";
        return;
    }

    fetch('MembershipServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `action=registerMembership&membershipTypeId=${membershipTypeId}&membershipCode=${membershipCode}&registrationDate=${registrationDate}&expiringDate=${expiringDate}&membershipStatus=${membershipStatus}`
    })
    .then(response => {
        if (response.ok) {
            document.getElementById('message').textContent = "Membership registered successfully!";
            document.getElementById('registerForm').reset(); // Reset form
        } else {
            document.getElementById('message').textContent = "Error registering membership.";
        }
    })
    .catch(error => {
        document.getElementById('message').textContent = "Network error. Please try again.";
    });
});
