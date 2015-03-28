React = require('react')

TSClass = require('./tsclass').TSClass
BabelClass = require('./babelclass').BabelClass
BabelTmplClass = require('./babeltmplclass').BabelTmplClass
CoffeeReactClass = require('./coffeereactclass').CoffeeReactClass
CoffeeReactMixinClass = require('./coffeereactmixinclass').CoffeeReactMixinClass

App = React.createClass(
  render: () ->
    <div>
      <CoffeeReactClass title="coffee-react" />
      <hr />
      <CoffeeReactMixinClass title="coffee-react" />
      <hr />
      <TSClass title="TypeScript" />
      <hr />
      <BabelClass title="Babel" />
      <hr />
      <BabelTmplClass title="Babel" />
    </div>
)

React.render(
  <App />,
  document.getElementById("app-container")
)
