# $ ->  
  jQuery.fn.slideFadeToggle = (speed, easing, callback) ->
    @animate
      opacity: "toggle"
      height: "toggle"
    , speed, easing, callback

  jQuery.fn.slideFadeHide = (speed, easing, callback) ->
    @animate
      opacity: 0
      height: "0px"
    , speed, easing, callback
    return

  jQuery.fn.slideFadeShow = (speed, easing, callback) ->
    target_height = @height()
    @css({display:'block', height:'0px',opacity:0,visibility:'visible'})
    @animate
      opacity: 1
      height: "#{target_height }px"
    , speed, easing, callback
    
  jQuery.fn.smoothScroll = (speed, easing, options={}, callback) ->
    target = $(@)
    if target.length
      $("html,body").animate
        scrollTop: target.offset().top + (options.offset || 0),
        speed,
        easing,
        callback
  