jQuery.fn.slideFadeToggle = function(speed, easing, callback) {
  return this.animate({opacity: 'toggle', height: 'toggle'}, speed, easing, callback);  
};

jQuery.fn.slideFadeHide = function(speed, easing, callback) {
  return this.animate({opacity: 'hide', height: 'hide'}, speed, easing, callback);  
};

jQuery.fn.slideFadeShow = function(speed, easing, callback) {
  return this.animate({opacity: "show", height: 'show'}, speed, easing, callback);  
};