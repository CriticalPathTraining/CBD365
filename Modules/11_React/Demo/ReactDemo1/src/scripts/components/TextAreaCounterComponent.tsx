import * as React from 'react';

export interface TextAreaCounterProps {
    defaultText: string;
}


export interface TextAreaCounterState {
    text: string;
}

export class TextAreaCounter extends React.Component<TextAreaCounterProps, TextAreaCounterState> {

    constructor(props: TextAreaCounterProps) {
        super(props);
        this.state = { text: this.props.defaultText };
    }


    _textChanged(event: any): void {
        this.setState({ text: event.target.value });
    }


    render() {
        return (
            <div>
                <textarea value={this.state.text} onChange={e=>this._textChanged(e)} ></textarea>
                <h3>Number of chars: {this.state.text.length}</h3>
            </div>
        );
    }
}
