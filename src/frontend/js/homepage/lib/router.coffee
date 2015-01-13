define [
  'zepto'
  'lodash'
  'backbone'
  'react'
  'homepage/lib/router'
  'homepage/elements/app'
], ($, _, Backbone, React, Router, App) ->

  class Router extends Backbone.Router

    @init: (root='/', pushState=true)->
      new Router
      Backbone.history.start { root, 'pushState' }

    routes:
      'gallery(/)': 'gallery'
      '(/)': 'index'

    index: ->
      React.render(<App />, document.getElementById('NickAndBora'))

    gallery: ->
      $el = ''
      for i in [0..5]
        width = 500 + Math.floor((500 * Math.random()))
        height = 500 + Math.floor((500 * Math.random()))
        $el += """
          <div id='img#{i}' class='image'>
            <img src="http://placehold.it/#{width}x#{height}">
          </div>
        """
      $('.gallery').html($el)

      # React.render(
      #   <h1>Hello</h1>
      #   document.getElementById('NickAndBora')
      # )
