React = require('react')

TSClass = require('./tsclass').TSClass
BabelClass = require('./babelclass').BabelClass

CoffeeReactClass = React.createClass(
  render: () ->
    items = [
      "item1"
      "item2"
      "item3"
    ]

    <div>
      <h1>CoffeeReactClass from coffee-react</h1>
      <ul>
        {items.map((x) -> <li>{x}</li>)}
      </ul>
    </div>
)


App = React.createClass(
  render: () ->
    <div>
      <CoffeeReactClass />
      <hr />
      <TSClass />
      <hr />
      <BabelClass />
    </div>
)

React.render(
  <App />,
  document.getElementById("app-container")
)
