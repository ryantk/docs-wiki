// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(document).ready(function() {
  $('textarea.editable').keydown(function(e) {
    var keyCode = e.keyCode || e.which; 

    if (keyCode == 9) { 
      e.preventDefault();

      // get current text
      var value = this.value;
      // get current selection start
      var start = this.selectionStart;
      // get current selection end
      var end   = this.selectionEnd;

      var numSpacesInTab = 2;

      // set the value to be the existing value but with two spaces injected between selection range
      this.value = value.substring(0, start) + ' '.repeat(numSpacesInTab) + value.substring(end);

      // increment cursor position
      this.selectionStart = this.selectionEnd = start + numSpacesInTab;
    }
  });
});
