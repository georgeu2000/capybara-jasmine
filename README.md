# Capybara-Jasmine

This gem uses Capybara to run Jasmine specs. Request a page once, run many JS specs. Works with RSpec and [Jasmine AJAX](https://github.com/jasmine/jasmine-ajax).

Please see [Capybara-Jasmine Demo](https://github.com/georgeu2000/capybara-jasmine-demo) to see how to integrate into an app.

##Why?
Capybara is a powerful tool, but I find it very tedious and slow, especially for JS testing. This is mostly due to the fact that loading a page for each spec is very time consuming.

Being able to write Jasmine specs and run them with the RSpec suite is flexible and fast: write Capybara specs for simple things, but Jasmine is perfect for JS unit tests, on-page JS functionality and AJAX requests.

## Installation
1. Add to your Gemfile:`gem 'capybara-jasmine'`
2. Add to the bottom of your spec helper:
  `require './spec/jasmine/jasmine_helper'
`
3. Create a jasmine folder within spec folder.
2. Create a `jasmine_helper.rb` in the jasmine folder. See Capybara-Jasmine Demo App for inspiration.
2. Create a features folder and put an RSpec spec in it.
2. Create a js folder and put your JS specs in it.
1. Capybara-Jasmine is a Rack app that will call your app. Name your app "app" or allow it to respond to "app".

## How it Works
Each Jasmine spec file must be selected within the RSpec spec:

    specify 'Index Page' do
      run_specs 'IndexPageSpec'
      visit '/'

In this example, we will load the index page run the JS specs `IndexPageSpecs` against it. 

You can specify multiple Jasmine spec files on one Capybara visit:

    run_specs 'IndexPageSpec, NavigationSpec'
    visit '/'

Capybara-Jasmine uses with RSpec and WebKit.

**JS helpers:**

1. Fill in a form field. Takes a finder and a value:
   `fillIn( '#emailField', 'joe@example.com' )`

1. Click Submit:
    `clickSubmit()`

1. Click link or button. Takes a finder:
     `Click('#logo');`  

