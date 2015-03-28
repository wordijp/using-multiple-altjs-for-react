React = require('react')


Mixin =
  render: () ->
    <div>
      <h1>{this.state.title}</h1>
      <ul>
        {this.state.items.map((x) -> <li>{x}</li>)}
      </ul>
    </div>


CoffeeReactMixinClass = React.createClass(
  mixins: [Mixin]
  getInitialState: () ->
    title: this.props.title + " (using mixin)"
    items: [
      "hoge"
      "fuga"
      "piyo"
    ]

)

module.exports.CoffeeReactMixinClass = CoffeeReactMixinClass
