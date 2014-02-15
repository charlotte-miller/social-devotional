jQuery.fn.slideFadeToggle = function(speed, easing, callback) {
  return this.animate({opacity: 'toggle', height: 'toggle'}, speed, easing, callback);
};

jQuery.fn.slideFadeHide = function(speed, easing, callback) {
  this.animate({opacity: 'hide', height: 'hide'}, speed, easing, callback);
  // return this.css('visibility', 'hidden');
};

jQuery.fn.slideFadeShow = function(speed, easing, callback) {
  // this.css('visibility', 'visible');
  return this.animate({opacity: "show", height: 'show'}, speed, easing, callback);
};