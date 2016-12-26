var myApp;
(function (myApp) {
    var AppFilters = (function () {
        function AppFilters() {
        }
        AppFilters.listPriceFilter = function ($filter) {
            return function (price) {
                return "$" + $filter('number')(price, 2) + " USD";
            };
        };
        AppFilters.$inject = ['$filter'];
        return AppFilters;
    }());
    var app = angular.module("myApp");
    app.filter("listPrice", AppFilters.listPriceFilter);
})(myApp || (myApp = {}));
//# sourceMappingURL=filters.js.map