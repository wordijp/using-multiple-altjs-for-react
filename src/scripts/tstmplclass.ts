/// <reference path="../../typings/tsd.d.ts" />

import React = require('react');
var tmpl = require('./test-template');

export var TSTmplClass = React.createClass({
  render: function() {
    var items = [
      "tom",
      "bob",
      "hiroshi"
    ];

    return tmpl({
      title: this.props.title + " (using jade template file)",
      items: items
    });
  }
});
