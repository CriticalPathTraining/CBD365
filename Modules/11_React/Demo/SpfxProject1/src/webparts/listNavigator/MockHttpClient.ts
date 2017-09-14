import { ISPList } from './components/IListNavigatorProps';

export class MockHttpClient {

    private static _items: ISPList[] = [
    { Title: 'Mock List 1', Id: '1' , DefaultViewUrl: "http://google.com"},
    { Title: 'Mock List 2', Id: '2' , DefaultViewUrl: "http://google.com"},
    { Title: 'Mock List 3', Id: '3' , DefaultViewUrl: "http://google.com"},
    { Title: 'Mock List 4', Id: '4' , DefaultViewUrl: "http://google.com"},
    { Title: 'Mock List 5', Id: '5' , DefaultViewUrl: "http://google.com"}
    ];

    public static get(restUrl: string, options?: any): Promise<ISPList[]> {
    return new Promise<ISPList[]>((resolve) => {
            resolve(MockHttpClient._items);
        });
    }
}