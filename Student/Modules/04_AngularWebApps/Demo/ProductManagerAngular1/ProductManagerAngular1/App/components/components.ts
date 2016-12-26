module myApp {

    let app = angular.module("myApp");
    
    class ProductNavigationController {

        static $inject: string[] = ['$location', 'ProductDataService'];

        public productCategories: string[];
        public title: string = "Filter";

        constructor(private $location: ng.ILocationService, private ProductDataService: ProductDataService) {
                 console.log("ProductNavigationController...");
        };

        public $onInit() {
            console.log("Init Component");
            this.productCategories = this.ProductDataService.GetProductCategories();
            console.log(this.productCategories.length);
        }

        public $onChanges(changesObj) {
            console.log("onChanges: ");
            console.log(changesObj);
        }

        public $postLink() {
            console.log("$postLink");
        }

        public $onDestroy() { }
    }

    class ProductNavigation implements ng.IComponentOptions {

        public bindings: { [binding: string]: string };
        public controller: any;
        public templateUrl: any;

        constructor() { 
            this.bindings = {};
            this.controller = ProductNavigationController;
            this.templateUrl = '/App/components/productNavigation.html';
            console.log("Comp init");
        }
        
    }

    app.component("productNavigation", new ProductNavigation());


}



    