#= require_tree ../../../vendor/assets/javascripts/video-js

$ ->
  $('#carasel-toggle').click ->
    $('#all-lessons').slideFadeToggle(350, 'easeInOutQuint')