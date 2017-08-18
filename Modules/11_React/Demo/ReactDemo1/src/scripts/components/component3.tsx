import * as React from 'react';

export interface Component3Props {
    name: string;
}


export interface Component3State {
    score: number;
}

export class Component3 extends React.Component<Component3Props, Component3State> {

    constructor(props: any) {
        super(props);
        this.state = { score: 0 };
    }

    addOneToScore(event: any): void {
        this.setState({ score: this.state.score + 1 });
    }


    render() {
        return (
            <div>
                <div>Hello, {this.props.name} - your score is {this.state.score}</div>
                <button onClick={e => this.addOneToScore(e)} >Add</button>
            </div>
        );
    }
}
