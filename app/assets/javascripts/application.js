//= require jquery
//= require jquery_ujs
//= require_tree .

/*
 * Animated Menu Icon
 * https://codepen.io/kyleHenwood/pen/Alayb
 */

$('document').ready(function () {
  var $trigger = $('.js--site-menu-trigger')
    , $body    = $('.js--body')
    , isClosed = true
    ;

  $trigger.on('click', function () {
    onSiteMenuIconClick();
  });

  function onSiteMenuIconClick() {
    if (isClosed == true) {
      $trigger.attr('data-menu-state', 'open');
      $body.attr('data-menu-state', 'open');
      isClosed = false;
    } else {
      $trigger.attr('data-menu-state', 'closed');
      $body.attr('data-menu-state', 'closed');
      isClosed = true;
    }
  }
});
