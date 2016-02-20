jQuery(document).ready(function($) {
  $.fn.showDescription = function(e, submenu){
    $('a').removeClass('current');
    $(this).addClass('current');
    
    $('#feature_description > img').remove();
    $('#feature_description').append( $('.wireframe', this).clone().show() );
    $('#feature_description > .wireframe').venobox();
    
    var description = $('.description', this).text();
    var clean = $.trim(description.replace(/[^\S|\n]+/g,' '));
    $('#feature_description > pre').html(clean || 'No Description');
    $('#feature_description').addClass('animated fadeInLeft');
    $('#feature_description').one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', function(){
      $('#feature_description').removeClass('fadeInLeft');
    });
  };
  
  $('#features>ul').addClass('nav');
  $('.nav').navgoco({
    caret: '<span class="caret"></span>',
    accordion: true,
    openClass: 'open',
    save: true,
    cookie: {
        name: 'features',
        expires: 7,
        path: '/'
    },
    slide: {
        duration: 800,
        easing: 'easeOutExpo'
    }
  });
  
  $('#wrapper').addClass('animated fadeInLeft').show();
  $('#wrapper').one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', function(){
    $('#wrapper').removeClass('fadeInLeft');
  });
  $('li > a').click(function(){$(this).showDescription();});
  
  $('#features > ul > li > a').showDescription();
  if ($('.feature.open').length===0) {
    $('.nav').navgoco('toggle', true, 0);
  }
});
