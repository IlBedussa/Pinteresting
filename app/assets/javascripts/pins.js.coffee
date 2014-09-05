# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#pins').imagesLoaded ->
    $('#pins').masonry
      itemSelector: '.box'
      isFitWidth: true

  $("#happyBdayBtn").click (event) ->
    $("#loginBtns").removeClass "hidden"
    $("#happyBdayBtn").addClass("hidden")
    event.preventDefault()
    return
  
  $("#like_pin").click (event) ->
    event.preventDefault()
    pin_id = $(this).data()
    type: 'POST'
    dataType: 'json'
    action: '/pins/'+pin_id.pinId+'/likes'
    error: (jqXHR, textStatus, errorThrown) ->
      alert textStatus
    success: (data, textStatus, jqXHR) ->
      alert data
    return
    
  $("#unlike_pin").click (event) ->
    $("#loginBtns").removeClass "hidden"
    $("#happyBdayBtn").addClass("hidden")
    event.preventDefault()
    return
    
    
    