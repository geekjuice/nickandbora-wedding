define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/elements/map'
], ($, React, NavBarElement, FooterElement, MapElement) ->

  DetailsApp = React.createClass

    render: ->
      <div className='NickAndBora-details'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Wedding Details</h1>

        <section>
          <h3>When & Where?</h3>
          <div className='img-container'>
            <img src='/img/details/calendar.png' className='calendar'/>
          </div>
          <p>
            We will be getting married <em>Saturday, March 28, 2015 at 5:30 pm at the Rancho Valencia Resort in Rancho Santa Fe, California</em>. The ceremony will be held in the croquet lawn, right across from the pony room. Valet parking will be offered at no cost. Please feel free to drive up to the courtyard and mention <em>Hwang-Lee Wedding</em>.
          </p>
          <div className='img-container'>
            <img src='/img/details/schedule.png' />
          </div>
          <p>
            The ceremony will begin at <em>5:30pm sharp in the Croquet Lawn</em> followed by <em>Cocktail Hour at 6pm</em>, along with delious tray passed food. You won’t be disappointed! We have plenty of food and drinks on the way.
          </p>
          <p>
            Dinner and dancing will follow. Then the real party begins. Leave your timidness at home and pack your dancing shoes!
          </p>
        </section>

        <section>
          <h3>Directions</h3>
          <MapElement />
          <p>
            Rancho Valencia is located 25 miles north of San Diego. A half-hour drive from the San Diego International Airport, 17 miles south of McClellan-Palomar Airport, and easily accessible from the freeway in every direction.
          </p>
        </section>

        <section>
          <p>If you have any questions about any of the above, feel free to email us at <a href='mailto:nickandbora@gmail.com?subject=%5BNick%20%26%20Bora%5D%20Hey!%20Listen!' target='_top'>NickAndBora@gmail.com</a>.</p>
        </section>

        <FooterElement />
      </div>

