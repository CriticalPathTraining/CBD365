import * as React from 'react';

export interface MyCustomProps {
  name: string;
}

export class Component1 extends React.Component<MyCustomProps, {}> {
  render() {
    return <div>Hello, {this.props.name}</div>;
  }
}
