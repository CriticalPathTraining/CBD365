module myApp {

  class AsyncInMemoryProductDataService implements IProductDataServiceAsync {

    private productListSeedData: Product[] = [
      { Id: 1, Name: "Batman Action Figure", ListPrice: 14.95, Category: "Action Figures", Description: "A super hero who sometimes plays the role of a dark knight.", ProductImageUrl: "WP0001.jpg" },
      { Id: 2, Name: "Captain America Action Figure", ListPrice: 12.95, Category: "Action Figures", Description: "A super action figure that protects freedom and the American way of life.", ProductImageUrl: "WP0002.jpg" },
      { Id: 3, Name: "Easel with Supply Trays", ListPrice: 49.95, Category: "Arts and Crafts", Description: "A serious easel for serious young artists.", ProductImageUrl: "WP0003.jpg" },
      { Id: 4, Name: "Crate o' Crayons", ListPrice: 14.95, Category: "Arts and Crafts", Description: "More crayons that you can shake a stick at.", ProductImageUrl: "WP0004.jpg" },
      { Id: 5, Name: "Green Stomper Bully", ListPrice: 24.95, Category: "Remote Control", Description: "A green alternative to crush and destroy the Red Stomper Bully.", ProductImageUrl: "WP0005.jpg" }
    ];

    static $inject = ['$q'];
    constructor(private $q: ng.IQService, private products: Product[]) {
      this.products = this.productListSeedData;
    }

    GetAllProductsAsync(): ng.IPromise<Product[]> {
      return this.$q.when(this.productListSeedData);
    }

    GetProductAsync(id: number): ng.IPromise<Product> {
      var products: Product[] = this.products.filter(product => product.Id === id);
      return this.$q.when(products[0]);
    }

    AddProductAsync(product: Product): ng.IPromise<void> {
      let Ids: number[] = this.products.map(p => p.Id);
      let newId = Math.max(...Ids) + 1;
      product.Id = newId;
      this.products.push(product);
      return this.$q.when();
    }

    DeleteProductAsync(id: number): ng.IPromise<void> {
      var index = this.products.map(product => product.Id).indexOf(id);
      this.products.splice(index, 1);
      return this.$q.when();
    }

    UpdateProductAsync(product: Product): ng.IPromise<void> {
      var index = this.products.map(product => product.Id).indexOf(product.Id);
      this.products[index] = product;
      return this.$q.when();
    }

    GetProductCategoriesAsync(): ng.IPromise<string[]> {
      return this.$q.when(["Action Figures", "Arts and Crafts", "Remote Control"]);
    }

    GetProductsByCategoryAsync(category: string): ng.IPromise<Product[]> {
      return this.$q.when(this.products.filter(product => product.Category === category));
    }

  }

  angular.module('myApp').service('ProductDataService', AsyncInMemoryProductDataService);

}