/// <reference path="../../scripts/typings/angularjs/angular.d.ts" />
/// <reference path="../models/models.ts" />
/// <reference path="../services/services.ts" />

module myApp {

  let app = angular.module("myApp");

  class HomeController {
    static $inject: Array<string> = [];
    welcomeMessage = "Welcome to the Wingtip Product Manager";
    topic1Title = "Add a new product";
    topic1Copy = "Click the Add Product link on the navbar aboive to add a new product.";
    topic2Title = "See the Product Showcase";
    topic2Copy = "Click Product Showcase link in the navbar to see the full set of Wingtip products.";
    constructor() { }
  }

  app.controller('homeController', HomeController);

  class ProductsController {
    static $inject: Array<string> = ['$location', 'ProductDataService'];
    products: Product[];
    productCategories: string[];
    constructor(private $location: ng.ILocationService, private ProductDataService: IProductDataServiceAsync) {
      ProductDataService.GetAllProductsAsync()
        .then((result: Product[]) => {
          this.products = result;
        });
      ProductDataService.GetProductCategoriesAsync()
        .then((result: string[]) => {
          this.productCategories = result;
        });
    }

    deleteProduct(id: number) {
      this.ProductDataService.DeleteProductAsync(id)
        .then( () => {
          this.$location.path("/products");
        });
    }
  }

  app.controller('productsController', ProductsController);

  class AddProductController {
    static $inject: Array<string> = ['$location', 'ProductDataService'];
    product: Product = new Product();
    productCategories: string[];
    userMessage: string;
    constructor(private $location: ng.ILocationService, private ProductDataService: IProductDataServiceAsync) {
      ProductDataService.GetProductCategoriesAsync()
        .then((result: string[]) => {
          this.productCategories = result;
        });
    }

    addProduct() {
      this.ProductDataService.AddProductAsync(this.product)
        .then(() => {
          this.$location.path("/products");
        });      
    }
  }

  app.controller('addProductController', AddProductController);

  interface IRouteParams extends ng.route.IRouteParamsService {
    id: string;
  }

  class ViewProductController {
    static $inject: Array<string> = ['$routeParams', 'ProductDataService'];
    product: Product;
    constructor($routeParams: IRouteParams, ProductDataService: IProductDataServiceAsync) {
      var id: number = parseInt($routeParams.id);
      ProductDataService.GetProductAsync(id)
        .then((result: Product) => {
          this.product = result;
        });
    }
  }

  app.controller('viewProductController', ViewProductController);

  class EditProductController {
    static $inject: Array<string> = ['$routeParams', '$location', 'ProductDataService'];
    product: Product;
    productCategories: string[];
    constructor(private $routeParams: IRouteParams, private $location: ng.ILocationService, private ProductDataService: IProductDataServiceAsync) {
      var id: number = parseInt($routeParams.id);
      ProductDataService.GetProductAsync(id)
        .then((result: Product) => {
          this.product = result;
        });
      ProductDataService.GetProductCategoriesAsync()
        .then((result: string[]) => {
          this.productCategories = result;
        });
    }
    updateProduct() {
      this.ProductDataService.UpdateProductAsync(this.product)
        .then( () => { this.$location.path("/products"); });
    }
  }

  app.controller('editProductController', EditProductController);

  class ProductShowcaseController {
    static $inject: Array<string> = ['$location', 'ProductDataService'];
    products: Product[];
    constructor(private $location: ng.ILocationService, private ProductDataService: IProductDataServiceAsync) {
      console.log("Product showcase controller");
      let categoryFilter: string = $location.search().category;
      console.log(categoryFilter);
      if (categoryFilter === undefined) {
        ProductDataService.GetAllProductsAsync()
          .then((result: Product[]) => {
            this.products = result;
          });
      }
      else {
        ProductDataService.GetProductsByCategoryAsync(categoryFilter)
          .then((result: Product[]) => {
            this.products = result;
          });
      }
    }
  }

  app.controller('productShowcaseController', ProductShowcaseController);
}
