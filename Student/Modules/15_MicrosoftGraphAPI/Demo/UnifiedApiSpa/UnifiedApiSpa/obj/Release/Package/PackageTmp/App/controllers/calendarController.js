'use strict';

var app = angular.module('UnifiedApiSpa');

app.controller('calendarController', ['$scope', 'unifiedApiService', calendarController]);

function calendarController($scope, unifiedApiService) {

  unifiedApiService.getCalendarEvents().success(function (data) {
    $scope.calendarEvents = data.value;
  }).
  error(function(data, status, headers, config) {
    alert("Error getting users");
  });


}