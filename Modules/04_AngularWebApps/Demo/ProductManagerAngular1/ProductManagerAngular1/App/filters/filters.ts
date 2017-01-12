
module myApp {

    class AppFilters {
        static $inject: Array<string> = ['$filter'];

        public static listPriceFilter($filter) {
            return (price: number) => {
                return "$" + $filter('number')(price, 2) + " USD";
            }            
        }
    }

    let app = angular.module("myApp");
    app.filter("listPrice", AppFilters.listPriceFilter);
}