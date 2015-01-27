define [
  'lodash'
  'react'
  'homepage/lib/mapConfig'
], (_, React, MapConfig) ->

  WEDDING_LOCATION = '5921 Valencia Circle, Rancho Santa Fe, CA'

  { Map, Marker, Geocoder, GeocoderStatus } = google.maps

  MapElement = React.createClass

    getDefaultProps: ->
      address: WEDDING_LOCATION

    componentWillMount: ->
      @_debouncedUpdate = _.debounce @updateMap, 500
      $(window).on 'resize', @_debouncedUpdate

    componentDidMount: ->
      $maps = @refs.map.getDOMNode()
      @map = new Map($maps, MapConfig)
      @geocoder = new Geocoder()
      @updateMap()

    componentWillUnmount: ->
      $(window).off 'resize', @_debouncedUpdate

    updateMap: ->
      address = @props.address or WEDDING_LOCATION
      @geocoder.geocode { address }, (results, status) =>
        if status is GeocoderStatus.OK
          position = results[0].geometry.location
          @map.setCenter(position)
          marker = new Marker { @map, position }
        else
          console.log "Error: #{status}"

    render: ->
      <div ref='map' id='map' className='map' />

