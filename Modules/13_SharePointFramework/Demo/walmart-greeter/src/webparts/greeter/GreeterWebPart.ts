import { Version } from '@microsoft/sp-core-library';
import {
  BaseClientSideWebPart,
  IPropertyPaneConfiguration,
  PropertyPaneTextField,
  PropertyPaneToggle,
  PropertyPaneDropdown
} from '@microsoft/sp-webpart-base';


import styles from './Greeter.module.scss';
import * as strings from 'greeterStrings';
import { IGreeterWebPartProps } from './IGreeterWebPartProps';

export default class GreeterWebPart extends BaseClientSideWebPart<IGreeterWebPartProps> {

  public render(): void {
     var fontSize = this.properties.largefont ? "32px" : "56px";

    this.domElement.innerHTML = `
      <div class="${styles.greeterWebpart}">
          <div class="${styles.greeting}" style="font-size:${fontSize} ;color:${this.properties.color}" >
            ${this.properties.greeting}
          </div>
      </div>`;
  }

  protected get dataVersion(): Version {
    return Version.parse('1.0');
  }

  protected getPropertyPaneConfiguration(): IPropertyPaneConfiguration {
    return {
           pages: [
        {
          header: { description: "Greeter Web Part" },
          groups: [
            {
              groupName: "General Properties",
              groupFields: [
                PropertyPaneTextField('greeting', { label: 'Greeting' }),
              ]
            },
            {
              groupName: "Cosmetic Properties",
              groupFields: [
                PropertyPaneToggle('largefont', {
                  label: 'Large Font',
                  onText: 'On',
                  offText: 'Off'
                }),
                PropertyPaneDropdown('color', {
                  label: 'Font Color',
                  options: [
                    { key: 'green', text: 'Green' },
                    { key: 'blue', text: 'Blue' },
                    { key: 'red', text: 'Red' },
                    { key: 'purple', text: 'Purple' }
                  ]
                })
              ]
            }
          ]
        }
      ]
    };
  }
}
