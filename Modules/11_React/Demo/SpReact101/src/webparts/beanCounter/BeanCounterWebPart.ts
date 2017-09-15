import * as React from 'react';
import * as ReactDom from 'react-dom';
import { Version } from '@microsoft/sp-core-library';
import {
  BaseClientSideWebPart,
  IPropertyPaneConfiguration,
  PropertyPaneTextField
} from '@microsoft/sp-webpart-base';

import * as strings from 'BeanCounterWebPartStrings';
import BeanCounter from './components/BeanCounter';
import { IBeanCounterProps } from './components/IBeanCounterProps';
import { IBeanCounterWebPartProps } from './IBeanCounterWebPartProps';

export default class BeanCounterWebPart extends BaseClientSideWebPart<IBeanCounterWebPartProps> {

  public render(): void {
    const element: React.ReactElement<IBeanCounterProps> = 
      React.createElement(BeanCounter, { StartingValue: 7 /*this.properties.StartingValue*/ } );

    ReactDom.render(element, this.domElement);
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
           
          ]
        }
      ]
    };
  }
}
