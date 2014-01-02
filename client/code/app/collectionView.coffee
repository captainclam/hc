class CollectionView
  constructor: (model) ->
    @model = model
    @dom = $ '.chart'

  add: (item) =>
    if _.findWhere @model, item
      return
    else
      @model.push item
      @render()

  render: =>
    if @model.length > 5
      return
    if @model.length is 5
      $('.app').addClass('app--publish')
    @dom.empty()
    if @model.length is 1
      $('.collection').addClass('collection--visible')
    for entry in @model then do (entry) =>
      div = $ ss.tmpl['chart-entry'].render entry
      @dom.append div
      div.click =>
        @model = _.reject @model, (item) -> item is entry
        div.remove()
    return @dom

window.collectionView = new CollectionView []
