define [
  'react'
  'saveTheDate/stores/mapStore'
  'saveTheDate/mixins/listen'
  'saveTheDate/lib/mapConfig'
], (React, MapStore, ListenMixin, MapConfig) ->

  WEDDING_LOCATION = 'Rancho Valencia, San Diego, CA'

  { Map, Marker, Geocoder, GeocoderStatus, LatLng } = google.maps

  MapElement = React.createClass

    mixins: [ListenMixin]

    getInitialState: ->
      address: WEDDING_LOCATION
      showMap: false

    onStoreChange: ->
      address = MapStore.get('address') ? @state.address
      showMap = !!address.length
      @setState { address, showMap }
      @updateMap()

    componentWillMount: ->
      @listenTo(MapStore)

    componentWillUnmount: ->
      @stopListening(MapStore)

    componentDidMount: ->
      $maps = @refs.map.getDOMNode()
      @map = new Map($maps, _.extend {}, MapConfig)
      @geocoder = new Geocoder()
      @updateMap()

    updateMap: ->
      address = @state.address or WEDDING_LOCATION
      @geocoder.geocode { address }, (results, status) =>
        if status is GeocoderStatus.OK
          position = results[0].geometry.location
          @map.setCenter(position)
          marker = new Marker {@map, position}
        else
          # NOTE: Handle better
          console.log "Error: #{address}"

    render: ->
      { showMap } = @state

      <div ref='map' id='address-map' className='component address-map' />
