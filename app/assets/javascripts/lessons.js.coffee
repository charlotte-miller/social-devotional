#= require_tree ../../../vendor/assets/javascripts/video-js

$ ->
  $('#carasel-toggle').click ->
    $('#lesson_carasel').slideFadeToggle();