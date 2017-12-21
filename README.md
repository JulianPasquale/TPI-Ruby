# README

This is a proyect for the subject "Taller de Tecnologias de Produccion de Software"

* Ruby version: 2.4.1

* System dependencies:

   System will use the gem mysql2, and you need to install its dependences

```console
$ sudo apt-get install libmysqlclient-dev
```
	
   For the gem nokogiri run

```console
$  sudo apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev
```
	
   Finally you need to install the system dependences includes in the Gemfile

```console
$ bundle install
```


  References: 
  1- https://github.com/brianmario/mysql2
  2- http://www.nokogiri.org/tutorials/installing_nokogiri.html

* Configuration

* Database creation: 
```ruby
$ rails db:create db:migrate
```

* Database initialization
```ruby
$ rails db:seed
```

* How to run the test suite

   For test you need to execute the command

```ruby
$ rails test
```
	
   You can run the tests individualy like this

```ruby
$ rails test ROUTE_TO_THE_TESTFILE
```

