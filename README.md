# Ruby on Rails Tutorial sample application

[![Build Status](https://travis-ci.org/cheezenaan-sandbox/sample_app_rev4.svg?branch=master)](https://travis-ci.org/cheezenaan-sandbox/sample_app_rev4)

This is the sample application based on
[_Ruby on Rails Tutorial:
Learn Web Development with Rails_](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## Getting started

To get started with the app, clone the repo and then install dependencies:

```
$ docker-compose run --rm node yarn install
$ docker-compose run --rm spring bundle install
```

Next, build frontend assets:

```
$ docker-compose run --node /bin/sh -c "yarn lint && yarn build"
```

Then, migrate the database:

```
$ docker-compose run --rm spring bin/rails db:create db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ docker-compose run --rm spring bin/rspec 
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ docker-compose up -d app node
```
