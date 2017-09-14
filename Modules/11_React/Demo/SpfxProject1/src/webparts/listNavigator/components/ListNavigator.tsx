import * as React from 'react';
import styles from './ListNavigator.module.scss';
import { IListNavigatorProps } from './IListNavigatorProps';
import { escape } from '@microsoft/sp-lodash-subset';

export default class ListNavigator extends React.Component<IListNavigatorProps, {}> {
  public render(): React.ReactElement<IListNavigatorProps> {
    return (
      <div className={styles.listNavigator}>
         <h3>List Navigator</h3>
         <ul>
	          {this.props.Lists.map((list) =>
	            <li key={list.Id} >
                <a href={list.DefaultViewUrl} >{list.Title} </a>
	            </li>
	          )}
	        </ul>
      </div>
    );
  }
}
