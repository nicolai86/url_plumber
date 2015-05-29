$:.unshift File.dirname(__FILE__) + "/lib"

require "bundler/setup"
Bundler.setup

require "minitest"
require "minitest/autorun"
require "minitest/hell"

require "active_support/inflector"

require "url_plumber"
