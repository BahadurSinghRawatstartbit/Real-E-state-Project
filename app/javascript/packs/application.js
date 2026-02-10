import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "channels"


import $ from "jquery"
window.$ = $
window.jQuery = $


import "./jsfolder/jquery-1.10.2.min"
import "./jsfolder/jquery.validate.min"
import "./jsfolder/jquery.ba-cond.min"
import "./jsfolder/jquery.slitslider"
import "./jsfolder/bootstrap.min.js"
// import "./jsfolder/easypiechart.min"
import EasyPieChart from "./jsfolder/easypiechart.min"
window.EasyPieChart = EasyPieChart

import "./jsfolder/owl.carousel.min"
import "./jsfolder/price-range"

import "./jsfolder/jquery.bootstrap.wizard"
import "./jsfolder/lightslider.min"
import "./jsfolder/modernizr-2.6.2.min"

import WOW from "./jsfolder/wow"
window.WOW = WOW


import "./wishlist"
import "./activenavbarclass"


import "./jsfolder/main"
// import "./jsfolder/gmaps.init"
import "./jsfolder/plugins"
import "./jsfolder/bootstrap-slider"
import "./jsfolder/wizard"
import "./jsfolder/bootstrap-hover-dropdown"
import "./jsfolder/bootstrap-select.min"
import "./jsfolder/icheck.min"
document.addEventListener("turbolinks:load", function() {


 
  $("#image-gallery").lightSlider({
    gallery: true,
    item: 1,
    thumbItem: 9,
    slideMargin: 0,
    speed: 500,
    auto: true,
    loop: true,
    onSliderLoad: function () {
      $("#image-gallery").removeClass("cS-hidden");
    }
  });

    

  // Initialize jQuery plugins
  $(".slider").slider({
    min: 0,
    max: 100,
    step: 1,
    value: [20, 80],
    tooltip: 'show',
    handle: 'round',
    formater: function(value) {
      return value;
    }
  });

  $(".owl-carousel").owlCarousel({
    items: 3,
    loop: true,
    autoplay: true,
    autoplayTimeout: 5000,
    nav: true,
  });

  new WOW().init();

  // Add other plugin initializations here if needed

  //  document.querySelectorAll(".chart").forEach((el) => {
  //   if (el._easyPieChart) return

  //   const chart = new EasyPieChart(el, {
  //     barColor: "#ef1e25",
  //     trackColor: "#f9f9f9",
  //     scaleColor: "#dfe0e0",
  //     scaleLength: 5,
  //     lineCap: "round",
  //     lineWidth: 3,
  //     size: 110,
  //     animate: { duration: 1000, enabled: true }
  //   })

  //   chart.update(el.dataset.percent || 0)
  //   el._easyPieChart = chart
  // })
});
document.addEventListener("turbolinks:load", () => {
  const form  = document.getElementById("message-form")
  const input = document.getElementById("message-input")

  if (!form || !input) return

  form.addEventListener("ajax:success", () => {
    input.value = ""
    input.focus()
  })
})

