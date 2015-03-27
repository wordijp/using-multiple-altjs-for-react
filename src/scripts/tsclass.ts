/// <reference path="../../typings/tsd.d.ts" />

import React = require('react');
var jade = require('react-jade'); // XXX : 型定義ファイルがまだない

export var TSClass = React.createClass({

  getInitialState: function () {
    return {
      tmpl: jade.compile(
        'h1 TSClass from TypeScript  \n' +
        'ul                          \n' +
        '  for x in items            \n' +
        '    li= x                   \n'
      )
    };
  },

  render: function() {
    var items = [
      "tom",
      "bob",
      "hiroshi"
    ];

    return this.state.tmpl({items: items});
  }
});
