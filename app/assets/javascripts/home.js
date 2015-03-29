// Kaminari pagination


// Kaminari pagination
$(document).ready(function() {
  $('#next').click(function() {
    $("#product-home .products-list").infinitescroll({
      loading: {
        finishedMsg: '<p>No more items :(</p>',
        img: "",
        msgText: "<span class='loader'></span>"
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#product-home .products-list",
      });
  });

  $(window).unbind('.infscr');

  $('#next').click(function() {
    $("#product-home .products-list").infinitescroll('retrieve');
    $("#next").fadeOut();
  });
  return false;

});
