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

    render: ->
      <div className='NickAndBora-homepage'>
        <BannerElement />
        <BioElement who='nick' />
        <BioElement who='bora' />
      </div>
