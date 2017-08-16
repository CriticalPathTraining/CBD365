var myApp;
(function (myApp) {
    var app = angular.module("myApp");
    var ProductNavigationController = (function () {
        function ProductNavigationController(ProductDataService) {
            this.ProductDataService = ProductDataService;
            // initialize view model inside $onInit not in constructor
        }
        ;
        ProductNavigationController.prototype.$onInit = function () {
            var _this = this;
            this.ProductDataService.GetProductCategoriesAsync()
                .then(function (result) {
                _this.productCategories = result;
            });
        };
        return ProductNavigationController;
    }());
    ProductNavigationController.$inject = ['ProductDataService'];
    var ProductNavigation = (function () {
        function ProductNavigation() {
            this.bindings = {};
            this.controller = ProductNavigationController;
            this.templateUrl = '/App/components/productNavigation.html';
        }
        return ProductNavigation;
    }());
    app.component("productNavigation", new ProductNavigation());
})(myApp || (myApp = {}));
//# sourceMappingURL=components.js.map