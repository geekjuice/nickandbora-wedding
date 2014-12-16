define [
  'zepto'
  'env'
], ($, Env) ->

  KEY = 'NickAndBora-Env'

  EnvElement = (env) ->
    """<div id="#{KEY}">#{env}</div>"""

  Setup = ->
    switch
      when Env.isQA(KEY)
        $('body').append EnvElement('QA')
      when Env.isLocal(KEY)
        $('body').append EnvElement('Local')

