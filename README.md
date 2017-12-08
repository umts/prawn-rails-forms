# PrawnRailsForms

A simple extension to PrawnRails, allowing you to specify dynamically filled forms in terms of their layout on the page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prawn-rails-forms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prawn-rails-forms

Then, anywhere in the `config/initializers/prawn_rails.rb` file specified by [the PrawnRails docs](https://github.com/cortiz/prawn-rails), add:

```ruby
include PrawnRailsForms
```

## Usage

In a PrawnRails `.pdf.prawn` document, with a `pdf` block variable, e.g.:

```ruby
prawn_document do |pdf|
  # Your code goes here...
end
```

Fields are laid out in rows, subdivided into an arbitrary number of units.
Rows must have a height specified, in points.
Fields cannot be created outside of rows.
For instance, say we want to create the following row of a form:

![1](https://cloud.githubusercontent.com/assets/3988134/26561634/e6028f68-448d-11e7-800a-93e3aca2db6a.png)

Then this row will be subdivided into 8 units. We specify this with:

```ruby
pdf.field_row height: 25, units: 8 do |row|
  # Specify fields...
end
```

Then we specify the fields in terms of how many units they take up, what their name should be, and what variable should be dynamically filled into this space.

For example, the first field in the image above would be:

```ruby
pdf.field_row height: 25, units: 8 do |row|
  row.text_field width: 4, field: 'Operator', value: @incident.driver.name
  # etc.
end
```

Note that the `@incident.driver.name` is arbitrary — this would be whatever code you need to fill the value of this field.

### Text fields

Text fields must have a `field` and `value` attribute.

The value can be a string, or an array of strings (which will be newline-separated in the output).

If the text overflows, it will be truncated (rather than doing any damage to subsequent fields or rows.)

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit
```

You can optionally specify the `width`, in terms of the units of the row. (Default is 1 unit.)

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  width: 3
```

You can optionally specify the `height` of the field, in points. It's not recommended for this to be more than the row height.

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  height: 30
```

#### Additional options

You can change the text size with a `size` attribute. Default is 10pt.

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  options: { size: 8 } # for large fruits
```

If there is a certain condition which you want to be true in order to display the value:

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  options: { if: @user.likes_fruit? }
```

Or a condition which you want to be false:

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  options: { unless: @user.hates_fruit? }
```

You can change how you want the text to be aligned horizontally. Default is center.

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  options: { align: :left }
```

You can also change the vertical alignment. Default is bottom.

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  options: { valign: :center }
```

You can also change the font style.

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  options: { style: :italic }
```

And of course, you can combine any or all of the above:

```ruby
row.text_field field: 'Favorite fruit', value: @user.favorite_fruit,
  width: 3, height: 30,
  options: {  align: :left, valign: :center, size: 8,
              if: @user.likes_fruit?, unless: @user.hates_fruit? }
```

### Check box fields

For selecting one of a group of options (the equivalent of an HTML select tag), you can have check box fields, e.g.:

![2](https://cloud.githubusercontent.com/assets/3988134/26561635/e603f628-448d-11e7-8af8-6ced6a729cd5.png)

Check box fields must have `field`, `options`, and `checked` attributes specified.

`field` is the name of the field.

`options` is the Array of options which will be shown.

`checked` is the Array, of equal size to `options`, of booleans specifying whether each option should be checked.

```ruby
vegetables = %w[celery asparagus yams]
row.check_box_field field: 'Favorite vegetables',
  options: vegetables,
  checked: vegetables.map{ |v| @user.likes? v }
```

You can optionally specify the width of the field, in the subunits into which the row is divided:

```ruby
row.check_box_field field: 'Favorite vegetables'
  options: vegetables,
  checked: vegetables.map{ |v| @user.likes? v },
  width: 4
```

Or the height, in points. Default is the row height.

```ruby
row.check_box_field field: 'Favorite vegetables'
  options: vegetables,
  checked: vegetables.map{ |v| @user.likes? v },
  height: 60
```

In the event that you would like multiple columns of checkboxes, you can specify the number of checkboxes which should occur in a column (default is 3):

```ruby
row.check_box_field field: 'Favorite vegetables',
  options: vegetables,
  checked: vegetables.map{ |v| @user.likes? v },
  per_column: 5
```

### Splitting rows into sub-rows

Say we want the following layout:

![3](https://cloud.githubusercontent.com/assets/3988134/26561633/e601874e-448d-11e7-8951-2f8627285a63.png)

The easiest way to apprach this is to complete the top line (the fields which all touch the top of the row), and then to go back and do the first field which does not.

```ruby
pdf.field_row height: 75, units: 8 do |row|
  # ...
  row.at_height 25 do
    row.text_field # ...
  end
end
```

If you want to jump midway through a line, then you can optionally specify the unit you would like to jump to:

```ruby
row.at_height 25, unit: 5 do
  # ...
end
```

This would start a new field 25 points from the top, halfway through the row.

## Development

There's a test rails app in `test-app/`. Bundle and boot it up, and the root page should show you a fairly self-explanatory static PDF.

New functionality would ideally be coupled with new 'test cases' in `static.pdf.prawn`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/umts/prawn-rails-forms.
