siteWrapper = $('#site-wrapper')
siteCanvas = $('#site-canvas')
imgToggle = $("#toggle")

toggleNav = ->
  if siteWrapper.hasClass 'show-nav'
    siteWrapper.removeClass('show-nav')
    siteCanvas.css("backgroundColor", "initial")
    imgToggle.removeClass 'flipped'
  else
    siteWrapper.addClass('show-nav')
    siteCanvas.css("backgroundColor", "rgba(0, 0, 0, .6)")
    imgToggle.addClass 'flipped'

$ ->
  $('.nav-toggle').click ->
    toggleNav()
  siteCanvas.height($(document).height())
  $(window).resize(->
    siteCanvas.height($(document).height())
    )
  t = setInterval ->
    $("#carousel ul").animate { marginLeft: "-100%" }, 1100, ->
      $(this).find("li:last").after $(this).find("li:first")
      $(this).css { marginLeft: 0 }
   ,4500
