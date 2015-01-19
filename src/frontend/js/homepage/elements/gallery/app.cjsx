define [
  'zepto'
  'react'
], ($, React) ->

  IMAGES =
    engagement: [
      'img0.jpg'
      'img1.jpg'
      'img2.jpg'
      'img3.jpg'
      'img4.jpg'
      'img5.jpg'
      'img6.jpg'
      'img7.jpg'
      'img8.jpg'
    ]

  App = React.createClass

    getInitialState: ->
      numberOfImages: 2

    componentWillMount: ->
      $('html, body').css('height', '100%')
      $('#NickAndBora').addClass('NickAndBora-gallery')

    componentDidUnmount: ->
      $('html, body').css('height', '')
      $('#NickAndBora').removeClass('NickAndBora-gallery')

    switchOrientation: ->
      $container = $('.gallery-container')
      if $container.hasClass('horizontal')
        $container.removeClass('horizontal').addClass('vertical')
      else
        $container.removeClass('vertical').addClass('horizontal')

    showMore: ->
      { numberOfImages } = @state
      @setState { numberOfImages: numberOfImages + 2 }

    render: ->
      { numberOfImages } = @state

      <div className='gallery-container horizontal'>
        <div className='left'>
          <h1>Nav</h1>
          <div className='links'>
            <ul>
              <li>
                <a href='gallery' onClick={@switchOrientation}>Switch</a>
              </li>
            </ul>
            <ul>
              {for i in [0..5]
                <li key={"gallery=#{i}"} >
                  <a href='gallery'>Gallery {i}</a>
                </li>
              }
            </ul>
          </div>
        </div>
        <div className='gallery'>
          {for image, i in IMAGES.engagement[0...numberOfImages]
            <div key={"engagement-#{i}"} className='image'>
              <div className='polaroid'>
                <img src="http://nickandbora.s3.amazonaws.com/engagement/#{image}" />
              </div>
            </div>
          }
          {if numberOfImages < IMAGES.engagement.length
            <div className='showMore'>
              <div className='showMore-link'>
                <a href='gallery' onClick={@showMore}>Show me more ↠</a>
              </div>
            </div>
          }
        </div>
      </div>
