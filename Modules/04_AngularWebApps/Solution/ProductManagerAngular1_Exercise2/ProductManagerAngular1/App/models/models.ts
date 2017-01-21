/// <reference path="../../scripts/typings/angularjs/angular.d.ts" />

module myApp {

  export class Product {
    Id: number;
    Name: string;
    Category: string;
    ListPrice: number;
    Description: string;
    ProductImageUrl: string;
  }

  export interface IProductDataService {
    GetAllProducts(): Product[];
    GetProduct(id: number): Product;
    AddProduct(product: Product): void;
    DeleteProduct(id: number): void;
    UpdateProduct(product: Product): void;
    GetProductCategories(): string[];
    GetProductsByCategory(category: string): Product[];
  }

}