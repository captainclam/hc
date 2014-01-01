class CollectionView
  constructor: (model) ->
    @model = model
    @dom = $ '.chart'

  add: (item) =>
    @model.push item
    @render()

  render: =>
    if @model.length > 5
      return
    if @model.length is 5
      $('.app').addClass('app--publish')
    @dom.empty()
    for entry in @model then do (entry) =>
      div = $ ss.tmpl['chart-entry'].render entry
      @dom.append div
    return @dom

window.collectionView = new CollectionView []
