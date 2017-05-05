import { Version } from '@microsoft/sp-core-library';
import {
  BaseClientSideWebPart,
  IPropertyPaneConfiguration,
  PropertyPaneTextField
} from '@microsoft/sp-webpart-base';
import { escape } from '@microsoft/sp-lodash-subset';

import styles from './HelloWebPart.module.scss';
import * as strings from 'helloWebPartStrings';
import { IHelloWebPartWebPartProps } from './IHelloWebPartWebPartProps';

export default class HelloWebPartWebPart extends BaseClientSideWebPart<IHelloWebPartWebPartProps> {

  public render(): void {
    this.domElement.innerHTML = `<h3>${this.properties.greeting}<h3>`;
  }

  protected get dataVersion(): Version {
    return Version.parse('1.0');
  }

  protected getPropertyPaneConfiguration(): IPropertyPaneConfiguration {
    return {
      pages: [
        {
          header: {
            description: strings.PropertyPaneDescription
          },
          groups: [
            {
              groupName: "My Properties",
              groupFields: [
                PropertyPaneTextField('greeting', {
                  label: "Greeting"
                })
              ]
            }
          ]
        }
      ]
    };
  }
}
