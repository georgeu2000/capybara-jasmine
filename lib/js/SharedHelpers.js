beforeEach(function () {
  jasmine.addMatchers({
  });
});


function lastRequest(){
  if (typeof jasmine.Ajax.requests.mostRecent() == 'undefined'){
    var err = new Error('no last request');
    console.dir(err);
    throw err
  };

  return jasmine.Ajax.requests.mostRecent()
};

function noAjaxRequests(){
  return typeof jasmine.Ajax.requests.mostRecent() == 'undefined'
}

function requestCount(){
  return jasmine.Ajax.requests.count()
};

function fillIn( finder, value ){
  $(finder).val(value);
};

function clickSubmit(){
  $('form input[type="submit"]').click();
};

function click(finder){
  $(finder).click();
};

function currentFunctionName() {
   var myName = arguments.callee.caller.toString();
   myName = myName.substr('function '.length);
   return myName.substr(0, myName.indexOf('('));
}
