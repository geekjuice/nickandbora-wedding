define [
  'zepto'
  'lib/enviro'
], ($, Enviro) ->

  KEY = 'NickAndBora-Env'

  EnvElement = (env) ->
    """<div id="#{KEY}">#{env}</div>"""

  Setup = ->
    switch
      when Enviro.isQA(KEY)
        $('body').append EnvElement('QA')
      when Enviro.isLocal(KEY)
        $('body').append EnvElement('Local')

