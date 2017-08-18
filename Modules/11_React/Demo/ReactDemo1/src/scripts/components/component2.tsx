import * as React from 'react';


export class Component2 extends React.Component<any, any> {
    
    constructor(props: any) {
        super(props);
        this.state = {
            name: this.props.name
        };
    }

    public handleChange(event: any): void{
        console.log("running handlerChange...");
        this.setState({name: "bingo"});
    }

    render() {
        return ( 
            <div>Hello, {this.state.name}<button name="Update" onClick={e => this.handleChange(e)}>Update</button></div>
        );
    }
}
