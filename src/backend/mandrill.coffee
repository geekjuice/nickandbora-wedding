###
# Mandrill
###

NAME = 'NickAndBora'

_         = require('lodash')
debug     = require('debug')(NAME)
mandrill  = require('mandrill-api/mandrill')

C         = require('./constants')
Enviro    = require('./lib/enviro')

mailer = new mandrill.Mandrill(C.MANDRILL_API_KEY)

defaults = ({subject}) ->
  message:
    html: "<h1>Save the Date</h1>"
    text: "Save the Date"
    subject: subject
    from_email: "TheCouple@NickAndBora.Life"
    from_name: "Nick & Bora"
    to: [
      {
        email: "nick.joosung.hwang@gmail.com"
        name: "Nicholas Hwang"
        type: "to"
      }
    ]
    headers:
      "Reply-To": "no-reply@NickAndBora.Life"
    important: false
    track_opens: null
    track_clicks: null
    auto_text: null
    auto_html: null
    inline_css: null
    url_strip_qs: null
    preserve_recipients: null
    view_content_link: null
    bcc_address: "nick.joosung.hwang@gmail.com"
    tracking_domain: null
    signing_domain: null
    return_path_domain: null
    merge: true
    global_merge_vars: []
    merge_vars: []
    tags: []
    subaccount: null
    google_analytics_domains: []
    google_analytics_campaign: null
    metadata:
      website: "NickAndBora.Life/SaveTheDate"
    recipient_metadata: []
    attachments: []
    images: []
  async: false
  ip_pool: null
  send_at: null


class Mailer

  constructor: (@name) ->

  getSubject: ->
    switch
      when Enviro.isLocal()
        "Nick & Bora - #{@name} [LOCAL]"
      when Enviro.isQA()
        "Nick & Bora - #{@name} [QA]"
      when Enviro.isProd()
        "Nick & Bora - #{@name}"

  success: (result) ->
    debug '[SUCCESS] Email Sent!'
    debug result

  error: (err) ->
    debug '[ERROR] Email not sent!'
    debug err

  send: (options={}, success=@success, error=@error) ->
    message = _.merge {}, defaults(subject: @getSubject()), options
    mailer.messages.send(message, success, error)


module.exports = Mailer
