'use strict';

(function () {

  var app = angular.module('UnifiedApiSpa');

  app.factory("unifiedApiService", [ '$http', createServiceObject]);

  function createServiceObject($http) {
    // create service object
    var service = {};

    var apiRoot = "https://graph.microsoft.com/beta/";
    $http.defaults.useXDomain = true;

    // set default headers for $http service
    var config = {
      headers: {
        'Accept': 'application/json; odata.metadata=none',
      }
    };

    service.getUsers = function () {
      var restUrl = apiRoot + "myOrganization/users/";
      return $http.get(restUrl);
    };

    service.getMessages = function () {
      var restUrl = apiRoot + "me/messages/?$top=10";
      return $http.get(restUrl);
    };

    service.getCalendarEvents = function () {
      var restUrl = apiRoot + "me/calendarview/?startdatetime=2015-05-01&enddatetime=2015-07-01";
      return $http.get(restUrl);
    };

    service.getFiles = function () {
      var restUrl = apiRoot + "me/files/";
      return $http.get(restUrl);
    };

    service.getTenantDetails = function () {
      var restUrl = apiRoot + "myOrganization/tenantDetails/";
      return $http.get(restUrl);
    };

   
    // return service object to angular framework
    return service;
  }

})();

