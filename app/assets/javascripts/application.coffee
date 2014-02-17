# Universal scripts
#
#= require_tree ../../../vendor/assets/javascripts/browser_compatibility
#= require jquery/jquery-1.8.0
#= require jquery/jquery.easing-1.3
#= require jquery/jquery.sd.utils

# Site-wide behavior
$ ->
  # # Smooth scrole to hash links
  # $("a[href*=#]:not([href=#])").click ->
  #   if location.pathname.replace(/^\//, "") is @pathname.replace(/^\//, "") and location.hostname is @hostname
  #     target = $(@hash)
  #     target = (if target.length then target else $("[name=" + @hash.slice(1) + "]"))
  #     if target.length
  #       $("html,body").animate
  #         scrollTop: target.offset().top
  #       , 1000
  #       false
  # 
  # return
