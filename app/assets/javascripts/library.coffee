$ ->     
  
  jQuery.fn.rigMediaItems = ->
    $('.media-item',@).each ->
      $media_item = $(@)
      
      # Rig click events    
      $('> a', @).click (event)->
        return true if $media_item.hasClass('active')
        event.preventDefault()
        
        drawer =
          cleanupOld: ->
            $('.media-item.active').removeClass('active')
            $('.study-detail-display').slideFadeHide 350, 'easeInOutQuint', -> $(@).remove()
    
          insertNew: =>
            $study_details   = $('.study-details', @)
            $display= $('<cite class="study-detail-display"><span class="close" >&times;</span></cite>')
            $('.close',$display).click -> drawer.cleanupOld()
            $display.append($study_details.html())
      
            if is_mobile_layout = $(window).width() < 768
              $study_details.after($display)
            else
              $(@).parents('.media-row').after($display)
      
            $display.slideFadeShow 350, 'easeInOutQuint'
          
          activateMediaItem: ->
            $media_item.addClass('active')
    
        drawer.cleanupOld()
        drawer.insertNew()
        drawer.activateMediaItem()
  
  $('#library-media').rigMediaItems()