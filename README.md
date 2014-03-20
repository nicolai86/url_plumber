# UrlPlumber

[![Gem Version](https://badge.fury.io/rb/url_plumber.png)](http://badge.fury.io/rb/url_plumber)
[![Build Status](https://travis-ci.org/nicolai86/url_plumber.png)](https://travis-ci.org/nicolai86/url_plumber)

Ever had a table with multiple filter-options and the need to change one filter while keeping another active?

Using `UrlPlumber` you can change individual parts of your url parameters while not touching anything else.

## Installation

Add this line to your application's Gemfile:

    gem 'url_plumber'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install url_plumber

## Usage

`UrlPlumber` has two main functions: changing values inside a hash and reading values stored inside of hash objects.

#### changing url parameters

The easiest way to get start is somewhere along these lines:

```
# url_plumber_helper.rb
module UrlPlumberHelper
  def plumb(key_path, value = nil)
    return url_for (@plumber ||= ::UrlPlumber::Plumber.new(params)).plumb(key_path => value)
  end
end
```

You can use it like this:

```
# some_view.haml
= link_to 'Clear Option A', plumb('filter.option_a')
= link_to 'Option A 1', plumb('filter.option_a', 1)
= link_to 'Option A 2', plumb('filter.option_a', 2)

= link_to 'Clear Option B', plumb('filter.option_b')
= link_to 'Option B 1', plumb('filter.option_b', 1)
= link_to 'Option B 2', plumb('filter.option_b', 2)
```

#### reading url parameters

```
# url_plumber_helper.rb
module UrlPlumberHelper
  def url_inquirer(key_path)
    return ::ActiveSupport::StringInquirer.new(@plumber ||= ::UrlPlumber::Plumber.new(params)).extract(key_path)
  end
end
```

You can use it like this:

```
# some_view.haml
- unless url_inquirer("filter.free_text").blank?
  = link_to 'clear search', root_path
```

Mix and match your plumber got you covert :)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

