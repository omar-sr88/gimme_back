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
//= require bootstrap
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require page
//= require_tree .


// $($(".chosen-select")[0]).html('');
// $(".chosen-select").trigger('chosen:updated');

$( document ).on('turbolinks:load', function() {

	writeData = function() {
	  url = '/users/search';
	  return $.ajax({
	    url: url,
	    dataType: 'json',
	    data: {
	      'search_text': $('.user-search').val()
	    },
	    success: function(data) {
	      $('#user-search-results').html('');
	      $('#user-search-results').append($('<option>').attr('value', '').text(''));
	      $.each(data, function(i, obj) {
	        $('#user-search-results').append($('<option>').attr('value', obj.email).text(obj.name));
	      });
	    },
	  });
	};

	$('.user-search').on('keyup', function() {
	  writeData();
	});

	$('#ck-tem-back').change(function() {
	  $('#datetimepicker8').toggleClass('returned-date-h', 'returned-date-s');
	});

	$('#ck-recipient').change(function() {
	  $('.user-search').toggle();
	  $('#user-search-results').toggle();
	  $('.guest').toggle();
	});

	$('#user-search-results').change(function() {
	  $('.user-search').val($('#user-search-results').find(":selected").val());
	});

	

})