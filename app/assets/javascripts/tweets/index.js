console.log('Im running!');

$(window).scroll(function() {
  if ($(window).scrollTop() == $(document).height() - $(window).height()) {
    console.log("Scrolled all the way!");
  }
});
