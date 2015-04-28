carousel = document.getElementById('carousel').firstChild
t = setInterval ->
  $(carousel).animate { marginLeft: "-100%" }, 1100, ->
    $(this).find("li:last").after $(this).find("li:first")
    $(this).css { marginLeft: 0 }
 ,4500
