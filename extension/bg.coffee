console.log 'HC Extension: Background Script Starting'

# When the browser-action button is clicked... 
chrome.browserAction.onClicked.addListener (tab) ->
  chrome.tabs.sendMessage tab.id,
    text: 'report_back'
  , (d) ->
    console.log $ d
