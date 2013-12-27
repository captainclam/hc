
class BemEl
  constructor: ({block, element, modifier, dom}) ->
    @dom = dom
    @b = block
    @e = element
    @m = modifier

  # toggle MODIFIER
  toggleModifier: (m) ->
    # todo: second toggleClass param to allow explicit setting
    @dom.toggleClass @b + '__' + @e + '--' + m

# Usage

finder = new BemEl
  dom: $('.finder')
  block: 'finder'
  element: 'input'
  modifier: 'active'

finder.toggleModifier 'active'
