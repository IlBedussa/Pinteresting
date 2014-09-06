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
    
  like_pin = (event, formData)->
    event.preventDefault()
    counts = formData.count + 1;
    element = $(this)
    $.ajax 
      url: "/pins/"+formData.pinId+"/likes"
      type: 'POST'
      dataType: 'html'
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error!"
      success: (data, textStatus, jqXHR) ->
        $('#pindiv_'+formData.pinId).html(data)
        unBindEventBinders()
        loadEventBinders()
    
  unlike_pin = (event, formData)->
    event.preventDefault()
    $.ajax 
      url: "/likes/" + formData.likeId 
      type: 'DELETE'
      dataType: 'html'
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error!"
      success: (data, textStatus, jqXHR) ->
        $('#pindiv_'+formData.pinId).html(data)
        unBindEventBinders()
        loadEventBinders()
  
  unlike_pin_bind = ->
    $(".unlike_pin").on "click", (event) ->
      formData = undefined
      formData = $(this).data()
      unlike_pin event, formData

  like_pin_bind = ->
    $(".like_pin").on "click", (event) ->
      formData = undefined
      formData = $(this).data()
      like_pin event, formData
      
  loadEventBinders = ->
    like_pin_bind()
    unlike_pin_bind()
    
  unBindEventBinders = ->
    $(".like_pin").unbind()
    $(".unlike_pin").unbind()
    
  loadEventBinders()
    
    