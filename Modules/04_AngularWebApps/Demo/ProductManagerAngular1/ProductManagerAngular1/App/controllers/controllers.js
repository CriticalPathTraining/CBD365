/// <reference path="../services/services.ts" />
/// <reference path="../models/product.ts" />
var myApp;
(function (myApp) {
    var app = angular.module("myApp");
    var AboutController = (function () {
        function AboutController() {
            this.title = "About the Product Manager App";
            this.description = "This Product Manager App is a demo app which uses TypeScript and Angular 1";
        }
        AboutController.$inject = [];
        return AboutController;
    }());
    app.controller('aboutController', AboutController);
    var HomeController = (function () {
        function HomeController() {
            this.welcomeMessage = "Welcome to the Wingtip Product Manager";
            this.topic1Title = "Add a new product";
            this.topic1Copy = "Click the Add Product link on the navbar aboive to add a new product.";
            this.topic2Title = "See the Product Showcase";
            this.topic2Copy = "Click Product Showcase link in the navbar to see the full set of Wingtip products.";
        }
        HomeController.$inject = [];
        return HomeController;
    }());
    app.controller('homeController', HomeController);
    var ProductsController = (function () {
        function ProductsController($location, ProductDataService) {
            this.$location = $location;
            this.ProductDataService = ProductDataService;
            this.products = ProductDataService.GetAllProducts();
        }
        ProductsController.prototype.deleteProduct = function (id) {
            this.ProductDataService.DeleteProduct(id);
            this.$location.path("/products");
        };
        ProductsController.$inject = ['$location', 'ProductDataService'];
        return ProductsController;
    }());
    app.controller('productsController', ProductsController);
    var ProductShowcaseController = (function () {
        function ProductShowcaseController($location, ProductDataService) {
            this.$location = $location;
            this.ProductDataService = ProductDataService;
            console.log("Product showcase controller");
            var categoryFilter = $location.search().category;
            console.log(categoryFilter);
            if (categoryFilter === undefined) {
                this.products = ProductDataService.GetAllProducts();
            }
            else {
                this.products = ProductDataService.GetProductsByCategory(categoryFilter);
            }
        }
        ProductShowcaseController.$inject = ['$location', 'ProductDataService'];
        return ProductShowcaseController;
    }());
    app.controller('productShowcaseController', ProductShowcaseController);
    var AddProductController = (function () {
        function AddProductController($location, ProductDataService) {
            this.$location = $location;
            this.ProductDataService = ProductDataService;
            this.product = new myApp.Product();
            this.productCategories = ProductDataService.GetProductCategories();
        }
        AddProductController.prototype.addProduct = function () {
            this.ProductDataService.AddProduct(this.product);
            this.$location.path("/products");
        };
        AddProductController.$inject = ['$location', 'ProductDataService'];
        return AddProductController;
    }());
    app.controller('addProductController', AddProductController);
    var ViewProductController = (function () {
        function ViewProductController($routeParams, ProductDataService) {
            var id = parseInt($routeParams.id);
            this.product = ProductDataService.GetProduct(id);
        }
        ViewProductController.$inject = ['$routeParams', 'ProductDataService'];
        return ViewProductController;
    }());
    app.controller('viewProductController', ViewProductController);
    var EditProductController = (function () {
        function EditProductController($routeParams, $location, ProductDataService) {
            this.$routeParams = $routeParams;
            this.$location = $location;
            this.ProductDataService = ProductDataService;
            var id = parseInt($routeParams.id);
            this.product = ProductDataService.GetProduct(id);
            this.productCategories = ProductDataService.GetProductCategories();
        }
        EditProductController.prototype.updateProduct = function () {
            this.ProductDataService.UpdateProduct(this.product);
            this.$location.path("/products");
        };
        EditProductController.$inject = ['$routeParams', '$location', 'ProductDataService'];
        return EditProductController;
    }());
    app.controller('editProductController', EditProductController);
})(myApp || (myApp = {}));
//# sourceMappingURL=controllers.js.map