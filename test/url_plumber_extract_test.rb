require "test_helper"

class UrlPlumberExtractTest < Minitest::Test
  def test_returns_nil_for_key_paths_that_do_not_match
    plumber = ::UrlPlumber::Plumber.new({ "foo" => 42 })
    assert_nil plumber.extract("bar")
  end

  def test_returns_nil_for_nested_unknown_key_paths
    plumber = ::UrlPlumber::Plumber.new({ "foo" => { "bar" => 12 } })
    assert_nil plumber.extract("foo.x")
  end

  def test_returns_value_for_known_key_paths
    plumber = ::UrlPlumber::Plumber.new({ "foo" => 42 })
    assert_equal 42, plumber.extract("foo")
  end

  def test_returns_value_for_known_nested_key_paths
    plumber = ::UrlPlumber::Plumber.new({ "foo" => { "bar" => 12 } })
    assert_equal 12, plumber.extract("foo.bar")
  end
end
