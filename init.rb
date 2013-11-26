require 'bundler'
Bundler.setup

lib_dir = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include?(lib_dir)


require 'rspec'
require 'rspec-given'
require 'initializer'
require 'extension'
require 'movies'
