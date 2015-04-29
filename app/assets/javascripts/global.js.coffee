global = ->
  toggleNav = ->
    if siteWrapper.className == 'show-nav'
      siteWrapper.removeAttribute 'class'
      siteCanvas.style.backgroundColor = 'initial'
      navToggle.removeAttribute 'class'
    else
      siteWrapper.className = 'show-nav'
      siteCanvas.style.backgroundColor = "rgba(0, 0, 0, .6)"
      navToggle.className = 'flipped'

  siteWrapper = document.getElementById 'site-wrapper'
  siteCanvas = document.getElementById 'site-canvas'
  navToggle = document.getElementById 'nav-toggle'

  siteCanvas.style.height = document.body.scrollHeight + "px"

  $(navToggle).click( ->
    toggleNav()
  )

  $(window).resize( ->
    siteWrapper.style.height = document.body.scrollHeight + "px"
    siteCanvas.style.height = document.body.scrollHeight + "px"
  )

$(document).ready( ->
  global()
)
$(document).on("page:load", ->
  global()
)
