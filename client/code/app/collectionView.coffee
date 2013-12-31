class CollectionView
  constructor: (model) ->
    @model = model
    @dom = $ '.chart'

  add: (item) =>
    @model.push item
    @render()

  render: =>
    @dom.empty()
    if @model.length is 5
      $('.app').addClass('app--publish')
    if @model.length is 1
      $('.collection').addClass('collection--visible')
    for entry in @model then do (entry) =>
      div = $ ss.tmpl['chart-entry'].render entry
      @dom.append div
    return @dom

window.collectionView = new CollectionView []
