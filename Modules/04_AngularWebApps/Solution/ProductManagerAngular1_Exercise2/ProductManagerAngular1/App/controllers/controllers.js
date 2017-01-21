/// <reference path="../../scripts/typings/angularjs/angular.d.ts" />
/// <reference path="../models/models.ts" />
/// <reference path="../services/services.ts" />
var myApp;
(function (myApp) {
    var app = angular.module("myApp");
    var HomeController = (function () {
        function HomeController() {
            this.welcomeMessage = "Welcome to the Wingtip Product Manager";
            this.topic1Title = "Add a new product";
            this.topic1Copy = "Click the Add Product link on the navbar aboive to add a new product.";
            this.topic2Title = "See the Product Showcase";
            this.topic2Copy = "Click Product Showcase link in the navbar to see the full set of Wingtip products.";
        }
        return HomeController;
    }());
    HomeController.$inject = [];
    app.controller('homeController', HomeController);
    var ProductsController = (function () {
        function ProductsController($location, ProductDataService) {
            this.$location = $location;
            this.ProductDataService = ProductDataService;
            this.products = ProductDataService.GetAllProducts();
            this.productCategories = ProductDataService.GetProductCategories();
        }
        ProductsController.prototype.deleteProduct = function (id) {
            this.ProductDataService.DeleteProduct(id);
            this.$location.path("/products");
        };
        return ProductsController;
    }());
    ProductsController.$inject = ['$location', 'ProductDataService'];
    app.controller('productsController', ProductsController);
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
        return AddProductController;
    }());
    AddProductController.$inject = ['$location', 'ProductDataService'];
    app.controller('addProductController', AddProductController);
    var ViewProductController = (function () {
        function ViewProductController($routeParams, ProductDataService) {
            var id = parseInt($routeParams.id);
            this.product = ProductDataService.GetProduct(id);
        }
        return ViewProductController;
    }());
    ViewProductController.$inject = ['$routeParams', 'ProductDataService'];
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
        return EditProductController;
    }());
    EditProductController.$inject = ['$routeParams', '$location', 'ProductDataService'];
    app.controller('editProductController', EditProductController);
    var ProductShowcaseController = (function () {
        function ProductShowcaseController() {
        }
        return ProductShowcaseController;
    }());
    ProductShowcaseController.$inject = [];
    app.controller('productShowcaseController', ProductShowcaseController);
})(myApp || (myApp = {}));
//# sourceMappingURL=controllers.js.map