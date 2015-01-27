define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
  'homepage/elements/map'
], ($, React, NavBarElement, FooterElement, MapElement) ->

  MORGAN_RUN_RESORT = '5690 Cancha De Golf, Rancho Santa Fe, CA'
  HOTEL_INDIGO = '710 Camino Del Mar, Del Mar, CA 92014'

  TravelApp = React.createClass

    render: ->
      <div className='NickAndBora-travel'>
        <NavBarElement onNavChange={@onNavChange} />
        <h1>Travel</h1>

        <section>
          <p>For our out-of-town guests, fly into San Diego International Airport (SAN).</p>

          <div className='location'>
            <p className='left'>
              <a href='http://www.clubcorp.com/Clubs/Morgan-Run-Club-Resort/Amenities/Accommodations' target='_blank'>Morgan Run</a> is offering us special rates for our wedding weekend and is a 5 minute drive from the wedding venue. Just mention the <em>Hwang and Lee Wedding</em> to apply the discount. Rememeber that it's a first come, first serve rate, so don’t wait too long to book a room.
            </p>
            <div className='map-container right'>
              <MapElement address={MORGAN_RUN_RESORT} />
            </div>
          </div>

          <div className='location'>
            <p className='right'>
              Prefer the beach? Then consider the <a href='http://ichotelsgroup.com/redirect?path=rates&brandCode=IN&regionCode=1&localeCode=en&GPC=LHW&hotelCode=SANDM&_PMID=99801505' target='_blank'>Hotel Indigo San Diego Del Mar</a>. It's actually minutes away from our first date location at <a href='http://doublehappiness-delmar.com/' target='_blank'>The Double Happiness</a>! And luckily enough, they are also offering a special rate if you mention the <em>Hwang and Lee Wedding</em>. It's about a 10 minute Uber ride from the resort, but it's definietely worth it and right on the beach!
            </p>
            <div className='map-container left'>
              <MapElement address={HOTEL_INDIGO} />
            </div>
          </div>

          <p>Remember that booking early means you will have better rates. If you are unsure about the travel, consider booking directly with the hotel as they have flexible (48 hours - 7 days prior) cancellation policies.</p>

          <p>San Diego spring weather is typically mild <a href='http://forecast.io/#/f/32.7157,-117.1617/1396033200' target='_blank'>(60s - 70s)</a>, but could get chilly once the sun goes down. The ceremony will be outside and the reception will be inside, but be sure to bring a sweater or light jacket just in case.</p>

          <p>Also, San Diego is not blessed with public transportation. Keep that in mind when you need to get around. A few options we recommend are <a href='http://uber.com' target='_blank'>Uber</a>, <a href='http://lyft.com'>Lyft</a>, or <a href='http://zipcar.com' target='_blank'>Zipcar</a>.</p>

          <p>And finally, if you get hungry and need some advice on where to go grab a bit, check out <a href='http://www.strayboots.com/p/g69q' target='_blank'>this map here</a>. It should point you to some of <em>Bora's</em> favorite spots in San Diego and Los Angeles with notes on what to get there! The map will be constantly updated leading up to the wedding, so make sure to check often so you don't miss out!</p>

          <p>If you have any questions about any of the above, feel free to email us at <a href='mailto:nickandbora@gmail.com?subject=%5BNick%20%26%20Bora%5D%20Hey!%20Listen!' target='_top'>NickAndBora@gmail.com</a>.</p>
        </section>

        <FooterElement />
      </div>
