$ ->     
  
  jQuery.fn.rigMediaItems = ->
    $('.study',@).each ->
      $media_item = $(@)
      
      # Rig click events    
      $('> a', @).click (event)->
        if $media_item.hasClass('active')
          # $('body').smoothScroll(350, 'easeInOutQuint')
          return true 
        event.preventDefault()
        
        base =
          isMobileLayout: -> $(window).width() < 768
          
          drawerOut: ->
            $('.study-detail-display').length
          
          cleanupOld: ->
            $('.study.active').removeClass('active')
            ($('.study-detail-display').slideFadeHide 350, 'easeInOutQuint', -> $(@).remove()) if base.drawerOut()
    
          insertNew: =>
            $study_details   = $('.study-details', @)
            $display= $('''
              <cite class="study-detail-display">
                <span class="close" >&times;</span>
              </cite>''')
            $('.close',$display).click -> base.cleanupOld()
            $display.append($study_details.html())
      
            if base.isMobileLayout()
              base.cleanupOld()
            else
              $(@).parents('.study-row').after($display)
              
            $display.slideFadeShow 350, 'easeInOutQuint'
          
          activateMediaItem: ->
            $media_item.addClass('active')
          
          handleScroll: ()->
            media_offset  = $media_item.offset().top
            drawer_offset = base.drawerOut() && $('.study-detail-display').offset().top
            drawer_height = base.drawerOut() && $('.study-detail-display').height()
            
            if drawer_height && drawer_offset && media_offset > drawer_offset
              # remove the height of the olde drawer from the $media_item
              $media_item.smoothScroll(350, 'easeInOutQuint', {offset: -drawer_height})
            else
              $media_item.smoothScroll(350, 'easeInOutQuint')
        
        base.cleanupOld()
        base.insertNew()
        base.activateMediaItem()
        base.handleScroll()
  
  $('#study-library').rigMediaItems()