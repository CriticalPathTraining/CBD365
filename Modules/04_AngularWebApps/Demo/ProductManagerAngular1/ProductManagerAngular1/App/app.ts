/// <reference path="../scripts/typings/jquery/jquery.d.ts" />
/// <reference path="../scripts/typings/angularjs/angular.d.ts" />
/// <reference path="../scripts/typings/angularjs/angular-route.d.ts" />

module myApp {

    var app = angular.module("myApp", ['ngRoute']);

    app.config(function ($locationProvider: ng.ILocationProvider, $routeProvider: ng.route.IRouteProvider) {

        $locationProvider.html5Mode(true);

        $routeProvider
            .when("/", {
                templateUrl: 'App/views/home.html',
                controller: "homeController",
                controllerAs: "vm"
            })
            .when("/about", {
                templateUrl: 'App/views/about.html',
                controller: "aboutController",
                controllerAs: "vm"
            })
            .when("/products", {
                templateUrl: 'App/views/products.html',
                controller: "productsController",
                controllerAs: "vm"
            })
            .when("/addproduct", {
                templateUrl: 'App/views/addproduct.html',
                controller: "addProductController",
                controllerAs: "vm"
            })
            .when("/viewproduct/:id", {
                templateUrl: 'App/views/viewproduct.html',
                controller: "viewProductController",
                controllerAs: "vm"
            })
            .when("/editproduct/:id", {
                templateUrl: 'App/views/editproduct.html',
                controller: "editProductController",
                controllerAs: "vm"
            })
            .when("/productShowcase", {
                templateUrl: 'App/views/productShowcase.html',
                controller: "productShowcaseController",
                controllerAs: "vm"
            })
            .otherwise({ redirectTo: "/" });
    });
}