React = require('react')

CoffeeReactClass = React.createClass(
  render: () ->
    items = [
      "item1"
      "item2"
      "item3"
    ]

    <div>
      <h1>{this.props.title}</h1>
      <ul>
        {items.map((x) -> <li>{x}</li>)}
      </ul>
    </div>
)

module.exports.CoffeeReactClass = CoffeeReactClass
