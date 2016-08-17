# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'changeDate', '.bootstrap-datepicker', (evt) ->
    rails_date = undefined
    rails_date = evt.date.getFullYear() + '-' + ('0' + evt.date.getMonth() + 1).slice(-2) + '-' + ('0' + evt.date.getDate()).slice(-2)
    $(this).next('input[type=hidden]').val rails_date
    return
  
  return

writeData = ->
  url = '/users/search'
  $.ajax
    url: url
    data: 'search_text': $('.user-search').val()
    success: (data) ->
      $('#user-search-results').html ''
      $('#user-search-results').append $('<option>').attr('value', '').text('')
      $.each data, (i, obj) ->
        $('#user-search-results').append $('<option>').attr('value', obj.email).text(obj.name)
        return
      return
    dataType: 'json'

setUp = (data, text) ->
  $('.chosen-select').html ''
  $.each data, (i, user) ->
    $('.chosen-select').append $('<option>').text(user.name)
    return
  $('.chosen-select').trigger 'chosen:updated'
  $('.chosen-search input').val text
  $('.chosen-select').prepend $('<option>').text('')

sendSearchString = ->
  $.ajax
    type: 'POST'
    url: '/users/search'
    dataType: 'json'
    data: search_text: $('.chosen-search input').val()
    success: (data) ->
      setUp data, $('.chosen-search input').val()
      false
    error: (data) ->
      false
  false