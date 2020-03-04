# frozen_string_literal: true

require 'prawn-rails-forms/field_row'

module PrawnRailsForms
  module DocumentExtensions
    def field_row(height:, units:)
      unit_width = bounds.width / units
      yield FieldRow.new(self, height, units, 0, cursor, unit_width)
    end

    private

    def make_text_field(start, width, height, field:, value:, options: {})
      bounding_box start, width: width, height: height do
        make_field_box field
        if value.present? && options[:if] != false && options[:unless] != true
          # cursor is current y position
          bounding_box [0, cursor], width: bounds.width do
            text_box text_field_text(value), text_field_options(options)
          end
        end
      end
    end

    def make_check_box_field(start, width, height, field:, options:, checked:, per_column: 3)
      bounding_box start, width: width, height: height do
        make_field_box field
        move_down 2
        box_height = cursor
        box_width = (width - 4) / options.each_slice(per_column).count
        options.each_slice(per_column).with_index do |opts, i|
          bounding_box [box_width * i, box_height], width: box_width, height: box_height do
            bounds.add_left_padding 2
            bounds.add_right_padding 2
            move_down 2
            opts.each.with_index do |opt, j|
              overall_index = i * per_column + j
              make_check_box checked: checked[overall_index], text: opt
              move_down 2
            end
          end
        end
      end
    end

    def make_check_box(checked:, text:)
      box_y = cursor
      bounding_box [0, box_y], width: 7, height: 7 do
        stroke_bounds
        if checked
          move_down 1
          text 'X', align: :center, size: 6, style: :bold
        end
      end
      bounding_box [9, box_y], width: bounds.width - 9, height: 10 do
        text text, size: 10
      end
    end

    def make_field_box(field)
      stroke_bounds
      bounds.add_left_padding 2
      move_down 2
      text field.upcase, size: 6
    end

    def text_field_options(options)
      {
        size: 10,
        align: :center,
        valign: :bottom,
        overflow: :ellipses
      }.merge(PrawnRailsForms.default_text_field_options).merge(options)
    end

    def text_field_text(value)
      if value.is_a? Array
        value.join "\n"
      else value.to_s
      end
    end
  end
end
