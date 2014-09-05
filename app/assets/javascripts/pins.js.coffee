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
    formData = $(this).data()
    counts = formData.count + 1;
    element = $(this)
    $.ajax 
      url: "/pins/"+formData.pinId+"/likes"
      type: 'POST'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error!"
      success: (data, textStatus, jqXHR) ->
        element.hide()
        $('#counts_'+formData.pinId).text("+"+counts)
    return
    
  $("#unlike_pin").click (event) ->
    event.preventDefault()
    formData = $(this).data()
    console.log(formData)  
    $.ajax 
      url: "/likes/" + formData.likeId 
      type: 'DELETE'
      dataType: 'json'
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error!"
      success: (data, textStatus, jqXHR) ->
        alert "Disliked!"
    return
    
    
    