define [
  'react'
  'homepage/elements/banner'
  'homepage/elements/bio'
], (
  React
  BannerElement
  BioElement
) ->

  HomepageApp = React.createClass

    getDefaultProps: ->
      coldStart: false

    render: ->
      <div className='NickAndBora-homepage'>
        <BannerElement coldStart={@props.coldStart}/>
        <BioElement who='nick' />
        <BioElement who='bora' />
      </div>
