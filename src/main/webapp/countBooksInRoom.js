function fetchBookCount(event) {
    event.preventDefault();
    const roomId = document.getElementById("roomId").value;
    if (!roomId) {
        document.getElementById("message").innerText = "Please select a room.";
        return;
    }
    fetch(`RoomServlet?action=countBooks&roomId=${roomId}`, {
        method: 'GET'
    })
    .then(response => response.text())
    .then(count => {
        document.getElementById("message").innerText = `Books in selected room: ${count}`;
    })
    .catch(error => {
        console.error("Error fetching book count:", error);
        document.getElementById("message").innerText = "Error fetching book count.";
    });
}
