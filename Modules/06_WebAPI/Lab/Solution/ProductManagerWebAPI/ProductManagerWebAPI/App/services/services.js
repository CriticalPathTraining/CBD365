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
    var SqlProductDataService = (function () {
        function SqlProductDataService($http, $q) {
            this.$http = $http;
            this.$q = $q;
        }
        SqlProductDataService.prototype.GetAllProductsAsync = function () {
            var defer = this.$q.defer();
            var restQueryUrl = "/odata/Products/?$select=Id,Name, Category, ListPrice, Description, ProductImageUrl";
            this.$http({
                method: 'GET',
                url: restQueryUrl,
                headers: { "Accept": "application/json" }
            }).then(function (result) {
                var products = result.data.value;
                defer.resolve(products);
            });
            return defer.promise;
        };
        SqlProductDataService.prototype.GetProductAsync = function (id) {
            var defer = this.$q.defer();
            var restQueryUrl = "/odata/Products(" + id + ")/?$select=Id,Name, Category, ListPrice, Description, ProductImageUrl";
            this.$http({
                method: 'GET',
                url: restQueryUrl,
                headers: { "Accept": "application/json" }
            }).then(function (result) {
                var product = result.data;
                defer.resolve(product);
            });
            return defer.promise;
        };
        SqlProductDataService.prototype.AddProductAsync = function (product) {
            var defer = this.$q.defer();
            var restQueryUrl = "/odata/Products";
            var requestBody = JSON.stringify({
                Name: product.Name,
                Category: product.Category,
                ListPrice: product.ListPrice,
                Description: product.Description,
                ProductImageUrl: product.ProductImageUrl
            });
            this.$http.post(restQueryUrl, requestBody).then(function (result) {
                defer.resolve();
            });
            return defer.promise;
        };
        SqlProductDataService.prototype.DeleteProductAsync = function (id) {
            var defer = this.$q.defer();
            var restQueryUrl = "/odata/Products(" + id + ")";
            this.$http.delete(restQueryUrl).then(function (result) {
                defer.resolve();
            });
            return defer.promise;
        };
        SqlProductDataService.prototype.UpdateProductAsync = function (product) {
            var defer = this.$q.defer();
            var restQueryUrl = "/odata/Products(" + product.Id + ")";
            var requestBody = JSON.stringify({
                Name: product.Name,
                Category: product.Category,
                ListPrice: product.ListPrice,
                Description: product.Description,
                ProductImageUrl: product.ProductImageUrl
            });
            this.$http.patch(restQueryUrl, requestBody).then(function (result) {
                defer.resolve();
            });
            return defer.promise;
        };
        SqlProductDataService.prototype.GetProductCategoriesAsync = function () {
            var defer = this.$q.defer();
            var restQueryUrl = "/odata/Products/?$select=Category";
            this.$http({
                method: 'GET',
                url: restQueryUrl,
                headers: { "Accept": "application/json" }
            }).then(function (result) {
                var categories = result.data.value.map(function (category) { return category.Category; });
                var uniqueCategories = categories.filter(function (x, i, a) { return a.indexOf(x) == i; });
                console.log(uniqueCategories);
                defer.resolve(uniqueCategories);
            });
            return defer.promise;
        };
        SqlProductDataService.prototype.GetProductsByCategoryAsync = function (category) {
            var defer = this.$q.defer();
            var restQueryUrl = "/odata/Products/?$select=Id,Name, Category, ListPrice, Description, ProductImageUrl" +
                "&$filter=Category eq '" + category + "'";
            this.$http({
                method: 'GET',
                url: restQueryUrl,
                headers: { "Accept": "application/json" }
            }).then(function (result) {
                var products = result.data.value;
                defer.resolve(products);
            });
            return defer.promise;
        };
        return SqlProductDataService;
    }());
    SqlProductDataService.$inject = ['$http', "$q"];
    angular.module('myApp').service('ProductDataService', SqlProductDataService);
})(myApp || (myApp = {}));
//# sourceMappingURL=services.js.map