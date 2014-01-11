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
      $('#publish').addClass('button--blue')
      $('#publish').removeClass('button--inactive')
    @dom.empty()
    for entry in @model then do (entry) =>
      div = $ ss.tmpl['chart-entry'].render entry
      @dom.append div
      div.click =>
        $('.item--selected').removeClass('item--selected')
        @model = _.reject @model, (item) -> item is entry
        div.remove()
        if @model.length < 5
          $('#publish').removeClass('button--blue')
          $('#publish').addClass('button--inactive')
    return @dom

window.collectionView = new CollectionView []

$('.collection .entry').click =>
  @model = _.reject @model, (item) -> item is actualItem
  @render()

$('#publish').click (e) ->
  e.preventDefault()
  if $('.collection .entry').length is 5
    Nav.go 'register'
    $('.finder').hide()
    $('.login-link').hide()
    $('.register #email').focus()
  else
    return