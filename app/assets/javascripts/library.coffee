$ ->     
  
  jQuery.fn.rigMediaItems = ->
    $('.media-item',@).each ->
      $media_item = $(@)
      
      # Rig click events    
      $('> a', @).click (event)->
        if $media_item.hasClass('active')
          # $('body').smoothScroll(350, 'easeInOutQuint')
          return true 
        event.preventDefault()
        
        drawer =
          drawerOut: ->
            $('.study-detail-display').length
          
          cleanupOld: ->
            $('.media-item.active').removeClass('active')
            ($('.study-detail-display').slideFadeHide 350, 'easeInOutQuint', -> $(@).remove()) if drawer.drawerOut()
    
          insertNew: =>
            $study_details   = $('.study-details', @)
            $display= $('''
              <cite class="study-detail-display">
                <span class="close" >&times;</span>
              </cite>''')
            $('.close',$display).click -> drawer.cleanupOld()
            $display.append($study_details.html())
      
            if is_mobile_layout = $(window).width() < 768
              $study_details.after($display)
            else
              $(@).parents('.media-row').after($display)
              
            $display.slideFadeShow 350, 'easeInOutQuint'
          
          activateMediaItem: ->
            $media_item.addClass('active')
          
          handleScroll: ()->
            # $media_item.smoothScroll(350, 'easeInOutQuint')
            media_offset  = $media_item.offset().top
            drawer_offset = drawer.drawerOut && $('.study-detail-display').offset().top
            drawer_height = drawer.drawerOut && $('.study-detail-display').height()
            
            # debugger
            
            if drawer_offset && media_offset > drawer_offset
              # remove the height of the olde drawer from the $media_item
              $media_item.smoothScroll(350, 'easeInOutQuint', {offset: -drawer_height})
            else
              $media_item.smoothScroll(350, 'easeInOutQuint')
        
        drawer.cleanupOld()
        drawer.insertNew()
        drawer.activateMediaItem()
        drawer.handleScroll()
  
  $('#library-media').rigMediaItems()