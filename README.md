# UrlPlumber

`UrlPlumber` helps you change individual url parameters while keeping everything else as is.

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

It's best to add a helper to your application to use `UrlPlumber` like this:

```
# url_plumber.rb
module UrlPlumber
  def plumb(key_path, value = nil)
    return url_for (@plumber ||= ::UrlPlumber::Plumber.new(params)).plumb(key_path, value)
  end
end
```

Then, in your view, you can use it like this:

```
# some_view.haml
= link_to 'Clear Option A', plumb('filter.option_a')
= link_to 'Option A 1', plumb('filter.option_a', 1)
= link_to 'Option A 2', plumb('filter.option_a', 2)

= link_to 'Clear Option B', plumb('filter.option_b')
= link_to 'Option B 1', plumb('filter.option_b', 1)
= link_to 'Option B 2', plumb('filter.option_b', 2)
```

Mix and match your plumber got you covert :)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# TODO

1. Test Unit tests.
