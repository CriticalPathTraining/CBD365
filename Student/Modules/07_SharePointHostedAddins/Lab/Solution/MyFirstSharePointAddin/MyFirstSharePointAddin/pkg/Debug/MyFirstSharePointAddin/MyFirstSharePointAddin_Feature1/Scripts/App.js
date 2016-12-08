'use strict';

$(onPageLoad);

function onPageLoad() {
  $("#cmdPressMe").click(onPressMe);
}

function onPressMe() {
  $("#content_box").text("Hello SharePoint Add-ins");
}