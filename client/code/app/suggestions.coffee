suggestions = [
  {"title":"Watching Movies with the Sound Off (Deluxe Edition)","subtitle":"Mac Miller","image":"http://userserve-ak.last.fm/serve/300x300/91010329.png"}
  {title: "Acid Rap", subtitle: "Chance the Rapper", image: "http://userserve-ak.last.fm/serve/300x300/93294971.png"}
]
for suggestion in suggestions
  el = $ ss.tmpl['chart-suggestion'].render suggestion
  el.click ->
    collectionView.add suggestion
  $('.suggestions').append el
