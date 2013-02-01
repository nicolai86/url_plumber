require 'test/unit'
require 'active_support/test_case'
require 'active_support/inflector'

require 'url_plumber'

class UrlPlumberTest < ActiveSupport::TestCase
  test 'removes key from hash' do
    plumber = ::UrlPlumber::Plumber.new({ foo: 42 })
    assert_empty plumber.plumb(:foo)
  end

  test 'removes key from nested hash' do
    plumber = ::UrlPlumber::Plumber.new({
      a: {
        b: {
          c: 4,
          x: 6
        }
      }
    })
    expected_hash = {
      a: {
        b: {
          c: 4
        }
      }
    }
    assert_equal expected_hash, plumber.plumb("a.b.x")
  end

  test 'does not modify original hash' do
    hash = { foo: 42 }
    plumber = ::UrlPlumber::Plumber.new(hash)
    plumber.plumb :foo, 12
    assert_equal({ foo: 42 }, hash)
  end

  test 'changes value of hash' do
    hash = { foo: 42 }
    plumber = ::UrlPlumber::Plumber.new(hash)
    assert_equal({ foo: 12 }, plumber.plumb(:foo, 12))
  end

  test 'changes value of nested hash' do
    plumber = ::UrlPlumber::Plumber.new({
      a: {
        b: {
          x: 4,
          c: "a"
        }
      }
    })
    expected_hash = {
      a: {
        b: {
          x: 4,
          c: 12
        }
      }
    }
    assert_equal expected_hash, plumber.plumb("a.b.c", 12)
  end
end