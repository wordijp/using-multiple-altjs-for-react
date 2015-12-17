React = require('react')
ReactDOM = require('react-dom')

TSTmplClass = require('./tstmplclass').TSTmplClass
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
      <TSTmplClass title="TypeScript" />
      <hr />
      <BabelClass title="Babel" />
      <hr />
      <BabelTmplClass title="Babel" />
    </div>
)

ReactDOM.render(
  <App />,
  document.getElementById("app-container")
)
