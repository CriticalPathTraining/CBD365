export interface ISPList {
  Id: string;
  Title: string;
  DefaultViewUrl: string; 
}

export interface IListNavigatorProps {
  Lists: ISPList[];
}

