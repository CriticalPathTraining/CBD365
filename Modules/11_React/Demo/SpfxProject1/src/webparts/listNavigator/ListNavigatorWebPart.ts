import * as React from 'react';
import * as ReactDom from 'react-dom';
import { Version } from '@microsoft/sp-core-library';
import {
  BaseClientSideWebPart,
  IPropertyPaneConfiguration,
  PropertyPaneTextField
} from '@microsoft/sp-webpart-base';

import * as strings from 'ListNavigatorWebPartStrings';
import ListNavigator from './components/ListNavigator';
import { IListNavigatorProps, ISPList } from './components/IListNavigatorProps';
import { IListNavigatorWebPartProps } from './IListNavigatorWebPartProps';


import { Environment, EnvironmentType } from '@microsoft/sp-core-library';
import { SPHttpClient } from '@microsoft/sp-http';
import { MockHttpClient } from './MockHttpClient';

export default class ListNavigatorWebPart extends BaseClientSideWebPart<IListNavigatorWebPartProps> {

  public render(): void {
    
    this._getListData().then(lists => {
      const element: React.ReactElement<IListNavigatorProps> = React.createElement(ListNavigator, {
        Lists: lists
      });

      ReactDom.render(element, this.domElement);
    });
    

  }


  private _getMockListData(): Promise<ISPList[]> {
    return MockHttpClient.get(this.context.pageContext.web.absoluteUrl)
        .then((data: ISPList[]) => {
              return data;
          });
  }

  private _getSharePointListData(): Promise<ISPList[]> {
    const url: string = this.context.pageContext.web.absoluteUrl + `/_api/web/lists?$select=Id,Title,DefaultViewUrl&$filter=Hidden eq false`;
    return this.context.spHttpClient.get(url, SPHttpClient.configurations.v1)
      .then(response => {
        return response.json();
      })
      .then(json => {
        return json.value;
      }) as Promise<ISPList[]>;
  }

  private _getListData(): Promise<ISPList[]> {
    if(Environment.type === EnvironmentType.Local) {
        return this._getMockListData();
    }
    else {
      return this._getSharePointListData();
    }
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
              groupName: strings.BasicGroupName,
              groupFields: [
                PropertyPaneTextField('description', {
                  label: strings.DescriptionFieldLabel
                })
              ]
            }
          ]
        }
      ]
    };
  }
}
