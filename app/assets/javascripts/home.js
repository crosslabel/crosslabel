// Kaminari pagination
$(document).ready(function() {
  $("#product-home .products-list").infinitescroll({
    loading: {
      finishedMsg: '<p>No more items :(</p>',
      msgText: "<p>Loading more items</p>",
    },
    navSelector: "nav.pagination",
    nextSelector: "nav.pagination a[rel=next]",
    itemSelector: "#product-home .products-list"
    });
});
