declare interface IHelloWebPartStrings {
  PropertyPaneDescription: string;
  BasicGroupName: string;
  DescriptionFieldLabel: string;
}

declare module 'helloWebPartStrings' {
  const strings: IHelloWebPartStrings;
  export = strings;
}
