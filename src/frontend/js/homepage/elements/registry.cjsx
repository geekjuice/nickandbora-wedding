define [
  'zepto'
  'react'
  'homepage/elements/navbar'
  'homepage/elements/footer'
], ($, React, NavBarElement, FooterElement) ->

  RegistryApp = React.createClass

    render: ->
      <div className='NickAndBora-registry'>
        <NavBarElement />
        <h1>Registry</h1>

        <section>
          <a href='http://www.crateandbarrel.com/gift-registry/' target='_blank'>
            <img className='cnb' src='/img/registry/cnb.png' />
            <img className='zola' src='/img/registry/zola.png' />
          </a>
          <h3>Dear friends and family,</h3>
          <p>We registered! Yes, we (as in <em>Bora</em>) made a trip to <a href='http://www.crateandbarrel.com/gift-registry/' target='_blank'>Crate and Barrel</a> and added the entire store and we (as in <em>Bora</em>) accumulated various items. We also used <a href='https://www.zola.com/' target='_blank'>Zola Registry</a> to add in group gifting options.</p>
          <p>We love all of you deeply and are so blessed that you would want to honor us with gifts to start our new life together, but we are asking in love and sincerity that you choose to bless us only from the following:</p>
          <ol>
            <li>
              <p>1. Use the money to get to San Diego.</p>
              <p>Having you here with us to celebrate means more to us than a knife block or an automatic toothpaste dispenser, we promise!</p>
            </li>
            <li>
              <p>2. Visit <a href='http://www.crateandbarrel.com/gift-registry/' target='_blank'>www.CrateAndBarrel.com</a> to check out our registry. On the bridal & gift registry page, search for <em>Bora Lee</em> or <em>Nicholas Hwang</em>.</p>
              <p>For group gifting, visit <a href='https://www.zola.com/registry/boraandnick' target='_blank'>www.Zola.com</a> to check out our registry from various stores.</p>
              <p>And if you do notice something on our list that you have creatively learned to do without, please give us your feedback (we are still rookies too).</p>
            </li>
            <li>
              <p>3. We love thrifty shopping! So <a href='http://www.homegoods.com/'>Homegoods/TjMaxx</a> giftcards are also welcome.</p>
            </li>
          </ol>

          <h4>All our love,</h4>
          <h4>Nick and Bora</h4>
        </section>

        <FooterElement />
      </div>

