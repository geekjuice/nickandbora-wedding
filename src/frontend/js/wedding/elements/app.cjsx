define [
  'react'
  'wedding/lib/parallax'
  'wedding/elements/hero'
  'wedding/elements/content'
], (
  React
  Parallax
  HeroElement
  ContentElement
) ->

  App = React.createClass

    componentDidMount: ->
      Parallax.init()

    render: ->
      <div>
        <HeroElement />
        <ContentElement />
      </div>

