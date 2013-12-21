suggestions = [
  {"title":"Watching Movies with the Sound Off (Deluxe Edition)","subtitle":"Mac Miller","image":"http://userserve-ak.last.fm/serve/300x300/91010329.png"}
  {"title": "Acid Rap", "subtitle": "Chance the Rapper", "image": "http://userserve-ak.last.fm/serve/300x300/93294971.png"}
  {"title":"Old","subtitle":"Danny Brown","image":"http://userserve-ak.last.fm/serve/300x300/94257157.jpg"}
  {"title":"Retrograde","subtitle":"James Blake","image":"http://userserve-ak.last.fm/serve/300x300/88442075.png"}
  {"title":"Doris","subtitle":"Earl Sweatshirt","image":"http://userserve-ak.last.fm/serve/300x300/91706171.png"}
  {"title":"Born Sinner","subtitle":"J. Cole","image":"http://userserve-ak.last.fm/serve/300x300/92364469.png"}
  {"title":"Wolf","subtitle":"Tyler, the Creator","image":"http://userserve-ak.last.fm/serve/300x300/88141265.png"}
  {"title":"Stranger Than Fiction","subtitle":"Kevin Gates","image":"http://userserve-ak.last.fm/serve/300x300/91531681.png"}
  {"title":"Kismet","subtitle":"Mr. Muthafuckin' eXquire","image":"http://userserve-ak.last.fm/serve/300x300/90212407.jpg"}
  {"title":"LONG.LIVE.A$AP (Deluxe Version)","subtitle":"A$AP Rocky","image":"http://userserve-ak.last.fm/serve/300x300/88031365.png"}
  {"title":"Kiss Land","subtitle":"The Weeknd","image":"http://userserve-ak.last.fm/serve/300x300/91697657.png"}
  {"title":"No Poison No Paradise","subtitle":"Black Milk","image":"http://userserve-ak.last.fm/serve/300x300/93986839.jpg"}
  {"title":"Indigioism","subtitle":"The Underachievers","image":"http://userserve-ak.last.fm/serve/300x300/91205035.png"}
  {"title":"Twelve Reasons To Die","subtitle":"Ghostface Killah","image":"http://userserve-ak.last.fm/serve/300x300/93647957.jpg"}
  {"title":"My Name Is My Name","subtitle":"Pusha T","image":"http://userserve-ak.last.fm/serve/300x300/92761901.png"}
  {"title":"Yeezus","subtitle":"Kanye West","image":"http://userserve-ak.last.fm/serve/300x300/91826975.png"}
  {"title":"Nothing Was the Same","subtitle":"Drake","image":"http://userserve-ak.last.fm/serve/300x300/92541381.png"}
  {"title":"Doris","subtitle":"Earl Sweatshirt","image":"http://userserve-ak.last.fm/serve/300x300/91706171.png"}
  {"title":"Run The Jewels","subtitle":"Run the Jewels","image":"http://userserve-ak.last.fm/serve/300x300/90507813.png"}
  {"title":"The Gifted","subtitle":"Wale","image":"http://userserve-ak.last.fm/serve/300x300/90875377.png"}
  {"title":"Something Else","subtitle":"Tech N9ne","image":"http://userserve-ak.last.fm/serve/300x300/95439353.png"}
  {"title":"Because The Internet","subtitle":"Childish Gambino","image":"http://userserve-ak.last.fm/serve/300x300/95152407.png"}
]
for suggestion in suggestions
  el = $ ss.tmpl['chart-suggestion'].render suggestion
  el.click ->
    collectionView.add suggestion
  $('#suggestions').append el
