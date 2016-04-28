// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap
//= require adminlte/adminlte
//= require chart/chart
//= require angular/angular
//= require angular-route/angular-route
//= require angular-resource/angular-resource
//= require angular-sanitize/angular-sanitize
//= require angular-messages/angular-messages
//= require angular-ui-select/dist/select
//= require bootstrap-colorpicker/dist/js/bootstrap-colorpicker
//= require select2/dist/js/select2.full
//= require angular-tooltips/dist/angular-tooltips.min

//= require app
//= require routes
//= require_tree ./charts
//= require_tree ./components
//= require_tree ./models

$(function() {
  $('.colorpicker-element').colorpicker();

  $('.js-proj-select2').on('select2:open', function() {
    $(this).data('open', true);
  });

  $('.js-proj-select2').on('select2:close', function() {
    $(this).data('open', false);
  });

  $('.js-cat-select2').on('select2:open', function() {
    $(this).data('open', true);
  });

  $('.js-cat-select2').on('select2:close', function() {
    $(this).data('open', false);
  });
});

$(document).on('keydown', function(e) {
  var keyCode = e.keyCode || e.which;

  if (keyCode == 9) {
    if($('.js-description').is(':focus')) {
      $('.js-proj-select2').select2('open');
    }
  }
})
