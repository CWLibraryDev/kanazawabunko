# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', () ->
  $toggle = $('input[type="checkbox"]')
  $toggle.bootstrapToggle()
  $('.toggle').on 'click', (e) ->
    console.log($(e.target))
    id = $(e.target).closest('.toggle-group').siblings('input').data('id')

    $.ajax(
      url: "/user_books/#{id}"
      method: "PUT"
    )
