module myApp {

  export interface IProductDataServiceAsync {
    GetAllProductsAsync(): ng.IPromise<Product[]>;
    GetProductAsync(id: number): ng.IPromise<Product>;
    AddProductAsync(product: Product): ng.IPromise<void>;
    DeleteProductAsync(id: number): ng.IPromise<void>;
    UpdateProductAsync(product: Product): ng.IPromise<void>;
    GetProductCategoriesAsync(): ng.IPromise<string[]>;
    GetProductsByCategoryAsync(category: string): ng.IPromise<Product[]>;
  }

}