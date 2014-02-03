// This is a manifest file that'll be compiled into application.js
//
//= require_tree ../../../vendor/assets/javascripts/browser_compatibility
//= require jquery/jquery-1.8.0
//= require jquery/jquery-ui.min
//= require jquery/jquery.easing-1.3
//= require jquery/select2-3.2
//= require backbone/handlebars-1.0.rc.1
//= require backbone/underscore-1.4.4
//= require backbone/backbone-0.9.10
//= require backbone/backbone-relational-0.6.0
//= require backbone/backbone-query-0.2.3
//= require backbone/backbone-bind-to-1.0.0
//= require backbone/backbone-handlebars-1.0.0
//= require_tree ./shared

jQuery(document).ready(function($) {

  // $('article').readmore({
  //   speed: 75,
  //   maxHeight: 400
  // });
  
  
  // Auto Refresh CSS every 5 seconds
  // setInterval(
  //   function() {void(function(){var i,a,s;a=document.getElementsByTagName('link');for(i=0;i<a.length;i++){s=a[i];if(s.rel.toLowerCase().indexOf('stylesheet')>=0&&s.href) {var h=s.href.replace(/(&|\?)forceReload=\d+/,'');s.href=h+(h.indexOf('?')>=0?'&':'?')+'forceReload='+(new Date().valueOf());}}})();},
  //   5000
  // );
  
});
