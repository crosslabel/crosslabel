// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require jquery.infinitescroll
//= require jquery.turbolinks
//= require mousetrap.min
//= require unveil.js
//= require validations/formValidation.popular
//= require validations/bootstrap
//= require_tree .

$(document).ready(function() {
  $("img").unveil();
});

if (window.location.hash && window.location.hash == '#_=_') {
    window.location.hash = '';
}

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
});

$(function() {
  $('.product-user-image').popover({
    html: true,
    trigger: "manual focus"
  }).on("mouseenter", function () {
    var _this = this;
    $(this).popover("show");
    $(".popover").on("mouseleave", function () {
        $(_this).popover('hide');
    });
    }).on("mouseleave", function () {
    var _this = this;
    setTimeout(function () {
        if (!$(".popover:hover").length) {
            $(_this).popover("hide");
        }
    }, 300);
});
});

Mousetrap.bind('right', nextPage);
Mousetrap.bind('prev', prevPage);

function nextPage() {
  host = window.location.host
  window.location.href = host + "/";
}

function prevPage() {
  host = window.location.host
  window.location.href = host + "/";
}
