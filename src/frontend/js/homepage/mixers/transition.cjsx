define [], ->

  DEFAULT_TRANSITION = 600

  startAnimation: (selector) ->
    duration = @getTransitionDuration(selector, 'transform')
    setTimeout @animatingFinished(selector), duration

  animatingFinished: (selector) ->
    (e) ->
      $(selector).removeClass('animating')

  getTransitionDuration: _.memoize (selector, property) ->
    TRANSITION_REGEX = new RegExp "#{property}\\s+([0-9.]+)"
    transition = $(selector).css 'transition'
    match = transition.match TRANSITION_REGEX
    match[1] * 1000 ? DEFAULT_TRANSITION

