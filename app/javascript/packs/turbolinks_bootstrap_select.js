// Ensure bootstrap-select initializes properly with Turbolinks
document.addEventListener('turbolinks:load', () => {
  // Reinitialize bootstrap-select elements
  if (typeof $.fn.selectpicker !== 'undefined') {
    $('.selectpicker').selectpicker('refresh');
  }
});