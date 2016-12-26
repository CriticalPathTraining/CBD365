/// <reference path="../services/services.ts" />
/// <reference path="../models/product.ts" />

module myApp {

    let app = angular.module("myApp");

    class AboutController {
        static $inject: Array<string> = [];
        title = "About the Product Manager App";
        description = "This Product Manager App is a demo app which uses TypeScript and Angular 1";
        constructor() { }   
    }

    app.controller('aboutController', AboutController);

    class HomeController {
        static $inject: Array<string> = [];
        welcomeMessage = "Welcome to the Wingtip Product Manager";
        topic1Title = "Add a new product";
        topic1Copy = "Click the Add Product link on the navbar aboive to add a new product.";
        topic2Title = "See the Product Showcase";
        topic2Copy = "Click Product Showcase link in the navbar to see the full set of Wingtip products.";
        constructor(){}        
    }

    app.controller('homeController', HomeController);

    class ProductsController {
        static $inject: Array<string> = ['$location', 'ProductDataService'];
        products: Product[];
        constructor(private $location: ng.ILocationService, private ProductDataService: ProductDataService) {
            this.products = ProductDataService.GetAllProducts();
        }
        deleteProduct(id: number) {
            this.ProductDataService.DeleteProduct(id);
            this.$location.path("/products");
        }
    }

    app.controller('productsController', ProductsController);

    class ProductShowcaseController {
        static $inject: Array<string> = ['$location', 'ProductDataService'];
        products: Product[];
        constructor(private $location: ng.ILocationService, private ProductDataService: ProductDataService) {
            console.log("Product showcase controller");
            let categoryFilter: string = $location.search().category;
            console.log(categoryFilter);
            if (categoryFilter === undefined) {
                this.products = ProductDataService.GetAllProducts();
            }
            else {
                this.products = ProductDataService.GetProductsByCategory(categoryFilter); 
            }
        }
    }

    app.controller('productShowcaseController', ProductShowcaseController);


    class AddProductController {
        static $inject: Array<string> = ['$location', 'ProductDataService'];
        product: Product = new Product();
        productCategories: string[];

        constructor(private $location: ng.ILocationService, private ProductDataService: ProductDataService) {
            this.productCategories = ProductDataService.GetProductCategories();
        }

        addProduct() {
            this.ProductDataService.AddProduct(this.product);
            this.$location.path("/products");
        }
    }

    app.controller('addProductController', AddProductController);

    interface IRouteParams extends ng.route.IRouteParamsService {
        id: string;
    }

    class ViewProductController {
        static $inject: Array<string> = ['$routeParams', 'ProductDataService'];
        product: Product;
        constructor($routeParams: IRouteParams, ProductDataService: ProductDataService) {
            var id: number = parseInt($routeParams.id);
            this.product = ProductDataService.GetProduct(id);
        }
    }

    app.controller('viewProductController', ViewProductController);


    class EditProductController {
        static $inject: Array<string> = ['$routeParams', '$location', 'ProductDataService'];
        product: Product;
        productCategories: string[];
        constructor(private $routeParams: IRouteParams, private $location: ng.ILocationService, private ProductDataService: ProductDataService) {
            var id: number = parseInt($routeParams.id);
            this.product = ProductDataService.GetProduct(id);
            this.productCategories = ProductDataService.GetProductCategories();
        }
        updateProduct() {
            this.ProductDataService.UpdateProduct(this.product);
            this.$location.path("/products");
        }        
    }

    app.controller('editProductController', EditProductController);
  
}