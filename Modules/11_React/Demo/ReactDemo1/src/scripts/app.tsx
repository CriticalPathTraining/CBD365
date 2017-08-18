import * as React from 'react';
import * as ReactDOM from 'react-dom';

import { Component1,  } from "./components/component1"
import { Component2 } from "./components/component2"
import { Component3 } from "./components/component3"
import { TextAreaCounter } from "./components/TextAreaCounterComponent"


window.onload = () => {
  CreateandRenderSimpleComponent();
  //CreateComponent1();
  //CreateComponent2();
  //CreateComponent3();
  //CreateTextAreaCounter();
  //CreateStatefulComponent();
};

var CreateandRenderSimpleComponent = (): void => {

  var myComponent = React.createClass({
    render: () => { return React.DOM.h1(null, "Hello React!") }
  });

  ReactDOM.render(
    React.createElement(myComponent),
    document.getElementById("message")
  )
}

var CreateComponent1 = (): void => {
  var destination = document.getElementById("message");
  ReactDOM.render(
      <Component1 name="Eddie Boy" />, 
      destination
    );
}

var CreateComponent2 = (): void => {
 var destination = document.getElementById("message");
  ReactDOM.render(
      <Component2 name="Boy Named Sue" />, 
      destination
    );
}

var CreateComponent3 = (): void => {
 var destination = document.getElementById("message");
  ReactDOM.render(
      <Component3 name="Edwin" />, 
      destination
    );
}

var CreateTextAreaCounter = (): void => {
 var destination = document.getElementById("message");
  ReactDOM.render(
      <TextAreaCounter defaultText="This is the default text value" />, 
      destination
    );
}

var CreateStatefulComponent = (): void => {

  var TextAreaCounter = React.createClass({
    propTypes: {
      text: React.PropTypes.string
    },
   getDefaultProps: ()=>{
     return { text: "hey baby, hey"}
   },
    render: () => { 
      return React.DOM.div(null,
        React.DOM.textarea({
          defaultValue: this.props.text
        }),
        React.DOM.h3(null, this.props.text.lenfth)
      );
    }     
  });

  var destination = document.getElementById("message");
  ReactDOM.render(React.createElement(TextAreaCounter, {text:"Bob"}), destination);

}

