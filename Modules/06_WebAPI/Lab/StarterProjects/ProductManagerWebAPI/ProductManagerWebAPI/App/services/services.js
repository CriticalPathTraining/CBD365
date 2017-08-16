var myApp;
(function (myApp) {
    var AsyncInMemoryProductDataService = (function () {
        function AsyncInMemoryProductDataService($q, products) {
            this.$q = $q;
            this.products = products;
            this.productListSeedData = [
                { Id: 1, Name: "Batman Action Figure", ListPrice: 14.95, Category: "Action Figures", Description: "A super hero who sometimes plays the role of a dark knight.", ProductImageUrl: "WP0001.jpg" },
                { Id: 2, Name: "Captain America Action Figure", ListPrice: 12.95, Category: "Action Figures", Description: "A super action figure that protects freedom and the American way of life.", ProductImageUrl: "WP0002.jpg" },
                { Id: 3, Name: "Easel with Supply Trays", ListPrice: 49.95, Category: "Arts and Crafts", Description: "A serious easel for serious young artists.", ProductImageUrl: "WP0003.jpg" },
                { Id: 4, Name: "Crate o' Crayons", ListPrice: 14.95, Category: "Arts and Crafts", Description: "More crayons that you can shake a stick at.", ProductImageUrl: "WP0004.jpg" },
                { Id: 5, Name: "Green Stomper Bully", ListPrice: 24.95, Category: "Remote Control", Description: "A green alternative to crush and destroy the Red Stomper Bully.", ProductImageUrl: "WP0005.jpg" }
            ];
            this.products = this.productListSeedData;
        }
        AsyncInMemoryProductDataService.prototype.GetAllProductsAsync = function () {
            return this.$q.when(this.productListSeedData);
        };
        AsyncInMemoryProductDataService.prototype.GetProductAsync = function (id) {
            var products = this.products.filter(function (product) { return product.Id === id; });
            return this.$q.when(products[0]);
        };
        AsyncInMemoryProductDataService.prototype.AddProductAsync = function (product) {
            var Ids = this.products.map(function (p) { return p.Id; });
            var newId = Math.max.apply(Math, Ids) + 1;
            product.Id = newId;
            this.products.push(product);
            return this.$q.when();
        };
        AsyncInMemoryProductDataService.prototype.DeleteProductAsync = function (id) {
            var index = this.products.map(function (product) { return product.Id; }).indexOf(id);
            this.products.splice(index, 1);
            return this.$q.when();
        };
        AsyncInMemoryProductDataService.prototype.UpdateProductAsync = function (product) {
            var index = this.products.map(function (product) { return product.Id; }).indexOf(product.Id);
            this.products[index] = product;
            return this.$q.when();
        };
        AsyncInMemoryProductDataService.prototype.GetProductCategoriesAsync = function () {
            return this.$q.when(["Action Figures", "Arts and Crafts", "Remote Control"]);
        };
        AsyncInMemoryProductDataService.prototype.GetProductsByCategoryAsync = function (category) {
            return this.$q.when(this.products.filter(function (product) { return product.Category === category; }));
        };
        return AsyncInMemoryProductDataService;
    }());
    AsyncInMemoryProductDataService.$inject = ['$q'];
    angular.module('myApp').service('ProductDataService', AsyncInMemoryProductDataService);
})(myApp || (myApp = {}));
//# sourceMappingURL=services.js.map