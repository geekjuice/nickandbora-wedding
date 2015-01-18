define [
  'react'
  'homepage/lib/bios'
  'homepage/mixers/transition'
], (React, BIOS, TransitionMixin) ->

  Bio = React.createClass

    mixins: [TransitionMixin]

    getDefaultProps: ->
      who: ''

    hideModal: (e) ->
      e.preventDefault()
      $('.home').removeClass('unfocused')
      $('.modal').addClass('animating').removeClass('visible')
      @startAnimation('.modal')

    render: ->
      { who } = @props
      { greeting, mynameis, bio, social} = BIOS[who]

      <section className="modal #{who}-bio">
        <div className='modal-overlay' onClick={@hideModal} />
        <div className='modal-content'>
          <div className='gradient' />
          <div className='greeting'>
            <span className='greeting-text'>{greeting}</span>
          </div>
          <div className='bio'>
            <div className='mynameis'>
              <img src={mynameis} />
            </div>
            <p>{bio}</p>
            <ul className='social'>
              {for s, i in social
                <li key={"#{who}-#{i}"}>
                  <a href={s.link} target='_blank'>
                    <img src={s.icon} />
                  </a>
                </li>
              }
            </ul>
          </div>
          <a className='modal-close' href='#' onClick={@hideModal}>x</a>
        </div>
      </section>


