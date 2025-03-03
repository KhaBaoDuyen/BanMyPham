document.addEventListener("DOMContentLoaded", function () {
    setTimeout(function () {
        let flashMessage = document.getElementById("flash-message");
        if (flashMessage) {
            flashMessage.style.opacity = "0";
            setTimeout(() => flashMessage.remove(), 500); 
        }
    }, 2000); 
});

