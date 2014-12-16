define [
  'lodash'
], (_) ->

  parseQueryParams: (keys=[]) ->
    values = {}

    unless _.isArray keys
      keys = [keys]

    { search } = window.location

    return {} unless search

    params = search[1...].split('&')

    for param in params
      [query, value] = param.split('=')
      if query and value and query in keys
        values[query] = decodeURIComponent(value)

    return values
