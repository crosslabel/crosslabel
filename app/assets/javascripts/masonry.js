$('#signup-link').on('click', function(e) {
  e.preventDefault();
  $('.form-wrapper-page').html("<%= escape_javascript(render partial: 'shared/signup_form') %>")
});

$('#login-link').on('click', function(e) {
  e.preventDefault();
  $('.form-wrapper-page').html("<%= escape_javascript(render partial: 'shared/login_form') %>")
});
