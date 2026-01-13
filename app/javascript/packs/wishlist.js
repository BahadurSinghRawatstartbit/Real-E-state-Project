document.addEventListener("click", function (e) {
  const button = e.target.closest(".wishlist-toggle");

  if (!button) return;

  e.preventDefault();

  const propertyId = button.dataset.propertyId;

  const isWishlisted = button.dataset.wishlisted === "true";

  const token = document.querySelector("meta[name='csrf-token']").content;

  fetch(`/properties/${propertyId}/wishlist`, {
    method: isWishlisted ? "DELETE" : "POST",

    headers: {
      "X-CSRF-Token": token,

      Accept: "application/json",
    },
  })
    .then((res) => {
      if (!res.ok) throw res;

      return res.json();
    })

    .then((data) => {
      const icon = button.querySelector("i");

      if (data.status === "added") {
        icon.classList.remove("fa-star-o");

        icon.classList.add("fa-star", "wishlisted");

        button.dataset.wishlisted = "true";
      } else if (data.status === "removed") {
        icon.classList.remove("fa-star", "wishlisted");

        icon.classList.add("fa-star-o");

        button.dataset.wishlisted = "false";
      }
    })

    .catch((err) => {
      if (err.status === 401) {
        $("#login-modal").modal("show");
      } else {
        console.error("Wishlist error:", err);
      }
    });
});
