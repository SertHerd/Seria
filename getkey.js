document.addEventListener("DOMContentLoaded", async () => {
    const resultContainer = document.getElementById("resultContainer");
    const resultMessage = document.getElementById("resultMessage");
    const resultLink = document.getElementById("resultLink");

    try {
        const response = await fetch('http://localhost:5002/api/getkey', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ hwid: 'exampleHWID' }),
        });

        const data = await response.json();

        if (data.success) {
            resultMessage.textContent = "Key generated successfully!";
            resultLink.innerHTML = `<a href="${data.link_get_key}" target="_blank">Link to get key</a>`;
            resultContainer.classList.remove("hidden");
        } else {
            resultMessage.textContent = `Failed to generate key. Error: ${data.error}`;
            resultContainer.classList.remove("hidden");
        }
    } catch (error) {
        console.error('Error:', error.message);
    }
});
