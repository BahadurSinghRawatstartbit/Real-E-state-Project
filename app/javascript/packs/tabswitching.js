// document.addEventListener("turbolinks:load", function () {
//     const tabButtons = document.querySelectorAll(".tab-btns");
//     tabButtons.forEach((button) => {
//     button.addEventListener("click", () => {
//         // Logic to toggle 'active' class on buttons and related content
//         document.querySelectorAll(".tab-btns, .tab-contents").forEach(el => el.classList.remove("active"));
//         button.classList.add("active");
//         document.getElementById(button.dataset.tabTarget).classList.add("active");
//     });
//     });

// });

$(document).on("turbo:load", function () {

  $(".btn-next").click(function () {
    let currentTab = $(".tab-pane.active");
    let inputs = currentTab.find("input, textarea, select").filter("[required]");
    let valid = true;

    inputs.each(function () {
      if (!this.checkValidity()) {
        this.reportValidity();
        valid = false;
        return false;
      }
    });

    if (valid) {
      let nextTab = $('ul li a[href="#' + currentTab.next().attr("id") + '"]');
      nextTab.tab("show");
    }
  });

  $(".btn-previous").click(function () {
    let currentTab = $(".tab-pane.active");
    let prevTab = $('ul li a[href="#' + currentTab.prev().attr("id") + '"]');
    prevTab.tab("show");
  });

});


