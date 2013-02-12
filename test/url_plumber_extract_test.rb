require "test/unit"
require "active_support/test_case"
require "active_support/inflector"

require "url_plumber"

class UrlPlumberExtractTest < ActiveSupport::TestCase
  test 'returns nil for key_paths that do not match' do
    plumber = ::UrlPlumber::Plumber.new({ "foo" => 42 })
    assert_nil plumber.extract("bar")
  end

  test 'returns nil for nested, unknown key_paths' do
    plumber = ::UrlPlumber::Plumber.new({ "foo" => { "bar" => 12 } })
    assert_nil plumber.extract("foo.x")
  end

  test 'returns value for known key_paths' do
    plumber = ::UrlPlumber::Plumber.new({ "foo" => 42 })
    assert_equal 42, plumber.extract("foo")
  end

  test 'returns value for known nested key_paths' do
    plumber = ::UrlPlumber::Plumber.new({ "foo" => { "bar" => 12 } })
    assert_equal 12, plumber.extract("foo.bar")
  end
end