class CollectionView
  constructor: (model) ->
    @model = model
    @dom = $ '#collection .list'

  add: (item) =>
    @model.push item
    @render()

  render: =>
    @dom.empty()
    for entry in @model then do (entry) =>
      li = $ ss.tmpl['chart-entry'].render entry
      @dom.append li
    return @dom

window.collectionView = new CollectionView []
