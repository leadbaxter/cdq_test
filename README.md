# cdq_test
Test CDQ gem in a client RubyMotion application

Initially adding a bunch of tests with the main purpose of demonstrating that some operations fail.

A number of the tests are commented:
```# Maybe I don't know what I'm doing?```

Those tests are the most suspected (by myself) that maybe I'm just doing it wrong, misunderstanding the CDQ documention, or whatever.

#### It's a RubyMotion application, so just follow these steps:

```
$ git clone git@github.com:leadbaxter/cdq_test.git cdq_test
$ cd cdq_test
$ bundle install
$ rake spec
```

#### Particular attention is drawn to these test results
* ```Weather.last``` fails, but ```Weather.first``` works as expected
* ```Weather.sum(:readings) # an integer``` fails
* ```Weather.sum(:inches_f) # a float``` fails

The reason I'm drawing attention to those is because that is what I started out the prove. The additional tests are just because I started going a little crazy. ;-)

#### Please feel free to box my ears if I am doing something stupid or just plain wrong.
This is my first usage of the CDQ gem, so I could easily just be doing things the wrong way.
