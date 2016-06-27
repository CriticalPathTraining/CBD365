'use strict';

// !!! BEFORE YOU RUN THIS SAMPLE APP !!!
// --------------------------------------

// update the GUID for the client_id variable 
// in the initializeADALSettings function
var client_id = "401b8ad7-86e3-4ba3-83a5-93b3f6ad9435";


(function () {

  var app = angular.module("UnifiedApiSpa", ['ngRoute', 'AdalAngular']);

  app.config(['$routeProvider', '$httpProvider', 'adalAuthenticationServiceProvider', initializeApp]);


  function initializeApp($routeProvider, $httpProvider, adalProvider) {

    initializeADALSettings($httpProvider, adalProvider);

    initializeRouteMap($routeProvider);

  }

  function initializeADALSettings($httpProvider, adalProvider) {

    var endpoints = {
      "https://graph.microsoft.com/": "https://graph.microsoft.com/",
    };

    var adalProviderSettings = {
      tenant: 'common',
      clientId: client_id,
      extraQueryParameter: 'nux=1',
      endpoints: endpoints,
      cacheLocation: 'localStorage' // enable this for IE, as sessionStorage does not work for localhost.
    };

    adalProvider.init(adalProviderSettings, $httpProvider);
   
  }

  function initializeRouteMap($routeProvider) {
    // config app's route map
    $routeProvider
      .when("/",
           { templateUrl: 'App/views/home.html', controller: "homeController" })
     .when("/messages",
           { templateUrl: 'App/views/messages.html', controller: "messagesController", requireADLogin: true })
     .when("/calendar",
           { templateUrl: 'App/views/calendar.html', controller: "calendarController", requireADLogin: true })
     .when("/files",
           { templateUrl: 'App/views/files.html', controller: "filesController", requireADLogin: true })
      .when("/users",
           { templateUrl: 'App/views/users.html', controller: "usersController", requireADLogin: true })
      .when("/tenancy",
           { templateUrl: 'App/views/tenancy.html', controller: "tenancyController", requireADLogin: true })
      .when("/userToken",
           { templateUrl: 'App/views/userToken.html', controller: "userTokenController", requireADLogin: true })
      .otherwise({ redirectTo: "/" });
  }

})();