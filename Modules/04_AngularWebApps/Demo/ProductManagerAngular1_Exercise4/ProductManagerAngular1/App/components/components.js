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
            var _this = this;
            console.log("component $onInit executing");
            this.ProductDataService.GetProductCategoriesAsync()
                .then(function (result) {
                _this.productCategories = result;
            });
        };
        ProductNavigationController.prototype.$onChanges = function (changesObj) {
            console.log("onChanges: ");
            console.log(changesObj);
        };
        ProductNavigationController.prototype.$postLink = function () {
            console.log("$postLink");
        };
        ProductNavigationController.prototype.$onDestroy = function () { };
        return ProductNavigationController;
    }());
    ProductNavigationController.$inject = ['$location', 'ProductDataService'];
    var ProductNavigation = (function () {
        function ProductNavigation() {
            this.bindings = {};
            this.controller = ProductNavigationController;
            this.templateUrl = '/App/components/productNavigation.html';
            console.log("component constructor executing");
        }
        return ProductNavigation;
    }());
    app.component("productNavigation", new ProductNavigation());
})(myApp || (myApp = {}));
//# sourceMappingURL=components.js.map