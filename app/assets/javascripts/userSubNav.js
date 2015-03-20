(function() {
  var app = angular.module('wagglr', []);

  app.controller('TabController', function(){
    this.tab = 1;

    this.setTab = function(setTab) {
      this.tab = setTab;
    };

    this.isSet = function(checkTab) {
      return this.tab === checkTab;
    };
  });
})();
