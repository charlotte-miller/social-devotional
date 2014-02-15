$ -> 
  $('.media-item > a').click (event)->
    event.preventDefault()
    $study_details = $('.study-details', @)
    $drawer = $('<cite class="drawer">')
    $drawer = $drawer.append($study_details.html())
    
    $old_drawer = $('.drawer')
    $old_drawer.animate {height:'0px', opacity:0}, 350, 'easeInOutQuint', ->
      $(this).remove()
    
    if $(window).width() < 768
      $study_details.after($drawer)
    else
      $(@).parents('.media-row').after($drawer)
    
    $drawer.animate({height:'300px', opacity:1}, 350, 'easeInOutQuint')