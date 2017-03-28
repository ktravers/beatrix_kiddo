document.addEventListener('DOMContentLoaded', function onDOMContentLoaded () {
  var trigger = document.getElementById('js--site-menu-trigger')
    , body    = document.getElementById('js--body')
    ;

  trigger.addEventListener('click', function toggleMenu () {
    var menuState = trigger.getAttribute('data-menu-state') == 'open' ? 'closed' : 'open';

    trigger.setAttribute('data-menu-state', menuState);
    body.setAttribute('data-menu-state', menuState);
  });
});
