# Universal scripts
#
#= require_tree ../../../vendor/assets/javascripts/browser_compatibility
#= require jquery/jquery-1.8.0
#= require jquery/jquery.easing-1.3
#= require jquery/jquery.sd.utils
#= require jquery/headroom-0.4.0
#= require jquery/jquery.headroom

# Site-wide behavior
$ ->
  
  # Main Nav hiding on downscroll
  $('nav#main-nav').headroom
    tolerance: 5
    offset: 180
    classes:
      initial: "main-nav"
      pinned: "pinned"
      unpinned: "unpinned"
    
  
  