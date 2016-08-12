# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  # convert bootstrap-datepicker value to rails date format (yyyy-mm-dd) on our hidden field
  $(document).on 'changeDate', '.bootstrap-datepicker', (evt) ->
    rails_date = evt.date.getFullYear() + '-' + ('0' + (evt.date.getMonth() + 1)).slice(-2) + '-' + ('0' + evt.date.getDate()).slice(-2)
    $(this).next("input[type=hidden]").val(rails_date)

  # enable chosen js
  $('.chosen-select').chosen
    allow_single_deselect: true
    include_blank: true
    no_results_text: 'No results matched'
    width: '100%'

  $('.chosen-search input').on 'keyup', (e) ->
	  sendSearchString()
	  return

  $('#ck-tem-back').change ->
   $('#datetimepicker8').toggleClass 'returned-date-h', 'returned-date-s'
  return


setUp = (data, text) ->
	$('.chosen-select').html('')
	$.each data, (i, user) ->
	  $('.chosen-select').append $('<option>').text(user.name)
	  return
	$('.chosen-select').trigger 'chosen:updated'
	$(".chosen-search input").val(text)
	$('.chosen-select').prepend $('<option>').text("")

sendSearchString = ->
  #$.post('/users/search', $(".chosen-search input").val().serialize(), 'script')
	 $.ajax
	      type: "POST",
	      url: "/users/search",
	      dataType: "json",
	      data: { search_text:  $(".chosen-search input").val()  },
	      success:(data) ->
	        setUp data , $(".chosen-search input").val()
	        return false
	      error:(data) ->
	        return false
	     return false

