/// <reference path="C:\DemoToday\ModernUI\ModernUI\Scripts/jquery-3.1.1.js" />

$(onPageLoad);

function onPageLoad() {
  $(".leftNavHide").toggle();
  $("#navigation-toggle").click(onNavigationToggle);
  $(window).resize(resizeNavigationPane);
  resizeNavigationPane();
}

function resizeNavigationPane() {
  var windowHeight = $(window).height();
  var bannerHeight = $("#banner").height();
  $("#left-nav").height(windowHeight - bannerHeight);
}

function onNavigationToggle() {
  $("#left-nav").toggleClass("navigationPaneCollapsed");
  $("#content-body").toggleClass("contentBodyNavigationCollapsed");
  $("#navigation-toggle").toggleClass("fa-arrow-left").toggleClass("fa-mail-reply");
  $(".leftNavHide").toggle();
}