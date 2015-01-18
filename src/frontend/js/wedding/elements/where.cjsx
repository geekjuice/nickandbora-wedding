define [
  'react'
  'wedding/lib/mapConfig'
], (React, MapConfig) ->

  WEDDING_LOCATION = '32.991062,-117.186107'

  { Map, Marker, Geocoder, GeocoderStatus, LatLng } = google.maps

  Where = React.createClass

    componentDidMount: ->
      $maps = @refs.map.getDOMNode()
      @map = new Map($maps, _.extend {}, MapConfig)
      @geocoder = new Geocoder()
      @updateMap()

    updateMap: ->
      address = WEDDING_LOCATION
      @geocoder.geocode { address }, (results, status) =>
        if status is GeocoderStatus.OK
          position = results[0].geometry.location
          @map.setCenter(position)
          marker = new Marker {@map, position}
        else
          console.log "Error: #{address}"

    render: ->
      <section className='where'>
        <h3>Where?</h3>
        <section ref='map' className='where-img' />
        <h4>
          <a href='http://www.ranchovalencia.com/' target='_blank'>
            Rancho Valencia Resort & Spa
          </a>
        </h4>
        <p>5921 Valencia Circle</p>
        <p>Rancho Santa Fe, CA 92067</p>
      </section>
