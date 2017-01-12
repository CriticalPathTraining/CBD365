declare module myApp {
    class ProductDataService {
        private $http;
        static $inject: string[];
        private _products;
        constructor($http: ng.IHttpService);
        GetAllProducts(): Product[];
        GetProduct(id: number): Product;
        GetProductCategories(): string[];
        GetProductsByCategory(category: string): Product[];
        AddProduct(product: Product): void;
        DeleteProduct(id: number): void;
        UpdateProduct(product: Product): void;
        private productListSeedData;
    }
}
