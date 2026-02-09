

// document.addEventListener("DOMContentLoaded", function() {
//   var btnContainer = document.getElementById("myDIV");
//   if (btnContainer) {
//     var btns = btnContainer.getElementsByClassName("myli");
//     for (var i = 0; i < btns.length; i++) {
//       btns[i].addEventListener("click", function() {
        
//         for (var j = 0; j < btns.length; j++) {
//           btns[j].classList.remove("active");
//         }
//         this.classList.add("active");
//       });
//     }
//   }
// });

document.addEventListener("turbolinks:load", function() {
  var btnContainer = document.getElementById("myDIV");
  if (btnContainer) {
    var btns = btnContainer.getElementsByClassName("myli");
    for (var i = 0; i < btns.length; i++) {
      btns[i].addEventListener("click", function() {

        for (var j = 0; j < btns.length; j++) {
          btns[j].classList.remove("active");
        }
        this.classList.add("active");
      });
    }
  }
});
