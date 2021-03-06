// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require file-upload/jquery.iframe-transport
//= require file-upload/vendor/jquery.ui.widget
//= require file-upload/jquery.fileupload
//= require handlebars-v4.0.11
//= require bootstrap-datepicker.min
//= require property_images


$(function () {
  $(".datepicker").datepicker({
      format: "yyyy/mm/dd",
      showOtherMonths: true,
      selectOtherMonths: true,
      autoclose: true,
      changeMonth: true,
      changeYear: true,
      //gotoCurrent: true,
      orientation: "bottom" // add this
  });
});
