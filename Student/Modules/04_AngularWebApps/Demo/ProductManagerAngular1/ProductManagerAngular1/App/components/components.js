var myApp;
(function (myApp) {
    var app = angular.module("myApp");
    var ProductNavigationController = (function () {
        function ProductNavigationController($location, ProductDataService) {
            this.$location = $location;
            this.ProductDataService = ProductDataService;
            this.title = "Filter";
            console.log("ProductNavigationController...");
        }
        ;
        ProductNavigationController.prototype.$onInit = function () {
            console.log("Init Component");
            this.productCategories = this.ProductDataService.GetProductCategories();
            console.log(this.productCategories.length);
        };
        ProductNavigationController.prototype.$onChanges = function (changesObj) {
            console.log("onChanges: ");
            console.log(changesObj);
        };
        ProductNavigationController.prototype.$postLink = function () {
            console.log("$postLink");
        };
        ProductNavigationController.prototype.$onDestroy = function () { };
        ProductNavigationController.$inject = ['$location', 'ProductDataService'];
        return ProductNavigationController;
    }());
    var ProductNavigation = (function () {
        function ProductNavigation() {
            this.bindings = {};
            this.controller = ProductNavigationController;
            this.templateUrl = '/App/components/productNavigation.html';
            console.log("Comp init");
        }
        return ProductNavigation;
    }());
    app.component("productNavigation", new ProductNavigation());
})(myApp || (myApp = {}));
//# sourceMappingURL=components.js.map