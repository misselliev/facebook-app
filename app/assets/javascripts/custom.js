window.setTimeout(function () {
  $(".message").fadeTo(500, 0)
      .slideUp(500, function () {
        $(this).remove();
      });
}, 3000);

$(document).on('turbolinks:load', function() {
  let acc = $('.accordion').accordion(
      {
        event: "click",
        active: false,
        collapsible: true,
        autoHeight: false
      }
  );
  $(".accordion-content").css("display", "none");
});

$(document).on('turbolinks:load', function() {
  $('#accept_friendship,#decline_friendship').on('click', function() {
      $(this).prop('disabled', true);
  });
});

