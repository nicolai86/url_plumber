require "test_helper"

class UrlPlumberPlumbTest < Minitest::Test
  def test_removes_key_from_hash
    plumber = ::UrlPlumber::Plumber.new({ "foo" => 42 })
    assert_empty plumber.plumb("foo" => nil)
  end

  def test_removes_key_from_nested_hash
    plumber = ::UrlPlumber::Plumber.new({
      "a" => {
        "b" => {
          "c" => 4,
          "x" => 6
        }
      }
    })
    expected_hash = {
      "a" => {
        "b" => {
          "c" => 4
        }
      }
    }
    assert_equal expected_hash, plumber.plumb("a.b.x" => nil)
  end

  def test_does_not_modify_original_hash
    hash = { "foo" => 42 }
    plumber = ::UrlPlumber::Plumber.new(hash)
    plumber.plumb "foo" => 12
    assert_equal({ "foo" => 42 }, hash)
  end

  def test_changes_value_of_hash
    hash = { "foo" => 42 }
    plumber = ::UrlPlumber::Plumber.new(hash)
    assert_equal({ "foo" => 12 }, plumber.plumb("foo" => 12))
  end

  def test_changes_value_of_nested_hash
    plumber = ::UrlPlumber::Plumber.new({
      "a" => {
        "b" => {
          "x" => 4,
          "c" => "a"
        }
      }
    })
    expected_hash = {
      "a" => {
        "b" => {
          "x" => 4,
          "c" => 12
        }
      }
    }
    assert_equal expected_hash, plumber.plumb("a.b.c" => 12)
  end

  def test_changes_value_of_hash_with_multiple_key_value_pairs
    hash = { "foo" => 42, "bar" => 10 }
    plumber = ::UrlPlumber::Plumber.new(hash)
    assert_equal({ "foo" => 12, "bar" => 32 }, plumber.plumb("foo" => 12, "bar" => 32))
  end

  def test_removes_key_of_hash_with_multiple_key_value_pairs
    hash = { "foo" => 42, "bar" => 10, "baz" => 12 }
    plumber = ::UrlPlumber::Plumber.new(hash)
    assert_equal({ "foo" => 42 }, plumber.plumb("bar" => nil, "baz" => nil))
  end
end
