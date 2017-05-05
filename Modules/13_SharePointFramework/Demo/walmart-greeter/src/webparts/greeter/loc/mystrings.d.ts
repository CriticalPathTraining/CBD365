declare interface IGreeterStrings {
  PropertyPaneDescription: string;
  BasicGroupName: string;
  DescriptionFieldLabel: string;
}

declare module 'greeterStrings' {
  const strings: IGreeterStrings;
  export = strings;
}
