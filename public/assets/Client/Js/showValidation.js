document.addEventListener("DOMContentLoaded", function () {
    setTimeout(function () {
        let flashMessage = document.getElementById("flash-message");
        if (flashMessage) {
            flashMessage.style.opacity = "0";
            setTimeout(() => flashMessage.remove(), 500); 
        }
    }, 2000); 
});

//-------------------COMMENT------------------
document.addEventListener("DOMContentLoaded", function () {
   document.querySelectorAll(".edit-comment").forEach((btn) => {
      btn.addEventListener("click", function () {
         const commentId = this.getAttribute("data-id");
         const content = prompt("Nhập nội dung chỉnh sửa:");
         if (content) {
            fetch(`/comment/update/${commentId}`, {
               method: "POST",
               headers: { "Content-Type": "application/json" },
               body: JSON.stringify({ content }),
            })
               .then((res) => res.json())
               .then((data) => {
                  if (data.success) location.reload();
                  else alert(data.message);
               });
         }
      });
   });

   document.querySelectorAll(".delete-comment").forEach((btn) => {
      btn.addEventListener("click", function () {
         if (confirm("Bạn có chắc muốn xóa bình luận này không?")) {
            const commentId = this.getAttribute("data-id");
            fetch(`/comment/delete/${commentId}`, {
               method: "DELETE",
               headers: { "Content-Type": "application/json" },
            })
               .then((res) => res.json())
               .then((data) => {
                  if (data.success) location.reload();
                  else alert(data.message);
               });
         }
      });
   });
});

