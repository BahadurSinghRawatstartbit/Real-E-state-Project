// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// IMPORTANT: Load jQuery plugins BEFORE code that uses them
// jQuery Validate must load before wizard.js which uses $.fn.validate
import "./jsfolder/jquery.validate.min.js"
import "./jsfolder/bootstrap.min.js"
import "./jsfolder/bootstrap-select.min.js"
import "./jsfolder/bootstrap-hover-dropdown.js"
import "./jsfolder/jquery.easypiechart.min.js"
import "./jsfolder/owl.carousel.min.js"
import "./jsfolder/icheck.min.js"
import "./jsfolder/price-range.js"
import "./jsfolder/easypiechart.min.js"
import "./jsfolder/wow.js"
import "./jsfolder/jquery.bootstrap.wizard.js"
import "./jsfolder/modernizr-2.6.2.min.js"
// import "./jsfolder/jquery-1.10.2.min.js"
import "./jsfolder/lightslider.min.js"
import "./wishlist.js"
import "./activenavbarclass.js"
import Rails from "@rails/ujs"
import $ from 'jquery';
window.$ = $;
window.jQuery = $;

// Ensure jQuery is available globally for other scripts
$(document).on('turbolinks:load', () => {
  console.log('Turbolinks loaded and jQuery initialized.');
});




// NOW it's safe to load wizard.js after jQuery plugins are loaded
import "./jsfolder/wizard.js"

// WOW must be global
import WOW from "./jsfolder/wow"
window.WOW = WOW

// -------------------------
// Theme logic (LAST)
// -------------------------
import "./jsfolder/main"


// Rails.start()
Turbolinks.start()
ActiveStorage.start()
Rails.start()

// jQuery is provided globally via webpack ProvidePlugin
// No need for ES6 imports since window.$ and window.jQuery are available

searchVisible = 0;
transparent = true;

$(document).ready(function () {
    /*  Activate the tooltips      */
    $('[rel="tooltip"]').tooltip();

    $('.wizard-card').bootstrapWizard({
        'tabClass': 'nav nav-pills',
        'nextSelector': '.btn-next',
        'previousSelector': '.btn-previous',
        onInit: function (tab, navigation, index) {

            //check number of tabs and fill the entire row
            var $total = navigation.find('li').length;
            $width = 100 / $total;

            $display_width = $(document).width();

            if ($display_width < 600 && $total > 3) {
                $width = 50;
            }

            navigation.find('li').css('width', $width + '%');

        },
        onNext: function (tab, navigation, index) {
            if (index == 1) {
                return validateFirstStep();
            } else if (index == 2) {
                return validateSecondStep();
            } else if (index == 3) {
                return validateThirdStep();
            } //etc. 

        },
        onTabClick: function (tab, navigation, index) {
            // Disable the posibility to click on tabs
            return false;
        },
        onTabShow: function (tab, navigation, index) {
            var $total = navigation.find('li').length;
            var $current = index + 1;

            var wizard = navigation.closest('.wizard-card');

            // If it's the last tab then hide the last button and show the finish instead
            if ($current >= $total) {
                $(wizard).find('.btn-next').hide();
                $(wizard).find('.btn-finish').show();
            } else {
                $(wizard).find('.btn-next').show();
                $(wizard).find('.btn-finish').hide();
            }
        }
    });

    // Prepare the preview for profile picture
    $("#wizard-picture").change(function () {
        readURL(this);
    });

    $('[data-toggle="wizard-radio"]').click(function () {
        wizard = $(this).closest('.wizard-card');
        wizard.find('[data-toggle="wizard-radio"]').removeClass('active');
        $(this).addClass('active');
        $(wizard).find('[type="radio"]').removeAttr('checked');
        $(this).find('[type="radio"]').attr('checked', 'true');
    });

    $('[data-toggle="wizard-checkbox"]').click(function () {
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
            $(this).find('[type="checkbox"]').removeAttr('checked');
        } else {
            $(this).addClass('active');
            $(this).find('[type="checkbox"]').attr('checked', 'true');
        }
    });

    $height = $(document).height();
    $('.set-full-height').css('height', $height);


});

function validateFirstStep() {

    $(".wizard-card form").validate({
        rules: {
            firstname: "required",
            lastname: "required",
            email: {
                required: true,
                email: true
            }

            /*  other possible input validations
             ,username: {
             required: true,
             minlength: 2
             },
             password: {
             required: true,
             minlength: 5
             },
             confirm_password: {
             required: true,
             minlength: 5,
             equalTo: "#password"
             },
             
             topic: {
             required: "#newsletter:checked",
             minlength: 2
             },
             agree: "required"
             */

        },
        messages: {
            firstname: "Please enter your First Name",
            lastname: "Please enter your Last Name",
            email: "Please enter a valid email address",
            /*   other posible validation messages
             username: {
             required: "Please enter a username",
             minlength: "Your username must consist of at least 2 characters"
             },
             password: {
             required: "Please provide a password",
             minlength: "Your password must be at least 5 characters long"
             },
             confirm_password: {
             required: "Please provide a password",
             minlength: "Your password must be at least 5 characters long",
             equalTo: "Please enter the same password as above"
             },
             email: "Please enter a valid email address",
             agree: "Please accept our policy",
             topic: "Please select at least 2 topics"
             */

        }
    });

    if (!$(".wizard-card form").valid()) {
        //form is invalid
        return false;
    }

    return true;
}

function validateSecondStep() {

    //code here for second step
    $(".wizard-card form").validate({
        rules: {
        },
        messages: {
        }
    });

    if (!$(".wizard-card form").valid()) {
        console.log('invalid');
        return false;
    }
    return true;

}

function validateThirdStep() {
    //code here for third step


}

//Function to show image before upload

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#wizardPicturePreview').attr('src', e.target.result).fadeIn('slow');
        }
        reader.readAsDataURL(input.files[0]);
    }
}


$(document).ready(function () {
  $('#wizardProperty').bootstrapWizard({
    nextSelector: '.btn-next',
    previousSelector: '.btn-previous',

    onTabShow: function(tab, navigation, index) {
      var total = navigation.find('li').length;
      var current = index + 1;

      if (current >= total) {
        $('.btn-next').hide();
        $('.btn-finish').show();
      } else {
        $('.btn-next').show();
        $('.btn-finish').hide();
      }
    }
  });
});

$(window).on("load", function () {
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
});

document.addEventListener("turbolinks:load", function() {
  // Initialize selectpicker
  $('.selectpicker').selectpicker();
});

// Temporarily disable Turbolinks for testing
// Turbolinks.start();
