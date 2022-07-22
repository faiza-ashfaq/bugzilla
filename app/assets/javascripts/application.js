// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap
//= require bootstrap-sprockets
//= require_tree .

$(document).on("change", "#bugs", function(){
  let bugs = $("#bugs :selected").text();
 // console.log(bugs)
  $.ajax({
    url: "/projects/1/bugs/update_status",
    method: "GET",
    dataType: "json",
    data: {bugs: bugs},
    error: function (xhr, status, error) {
      console.error('AJAX Error: ' + status + error);
    },
    success: function (response) {
      console.log(response);
      var status = response["status"];
      $("#status").empty();
      $('#status').removeClass('d-none')
      $("#status").append('<option>Select status</option>');
      jQuery.each(status, function (name, value) {
        $('#status').append('<option value="' + value + '">' + name + '</option>');
    });

    }
  });
});

