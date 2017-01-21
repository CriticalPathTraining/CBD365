module myApp {

    let app = angular.module("myApp");
    
    class ProductNavigationController {

        static $inject: string[] = ['$location', 'ProductDataService'];

        public productCategories: string[];
        public title: string = "Filter";

        constructor(private $location: ng.ILocationService, private ProductDataService: IProductDataServiceAsync) {
                 console.log("ProductNavigationController...");
        };

        public $onInit() {
          console.log("component $onInit executing");
          this.ProductDataService.GetProductCategoriesAsync()
            .then( (result: string[]) => {
              this.productCategories = result; 
            });
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
            console.log("component constructor executing");
        }
        
    }

    app.component("productNavigation", new ProductNavigation());
}    