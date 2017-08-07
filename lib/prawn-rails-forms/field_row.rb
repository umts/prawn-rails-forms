# frozen_string_literal: true

module PrawnRailsForms
  class FieldRow
    attr_accessor :document, :height, :units, :x, :y, :unit_width

    def initialize(document, height, units, x, y, unit_width)
      @document, @height, @units, @x, @y, @unit_width =
        document, height, units, x, y, unit_width
    end

    def at_height(height, options = {})
      @y -= height
      @x = options[:unit] * @unit_width if options[:unit].present?
      yield
      @y += height
    end

    def text_field(**args)
      start, width, height = field_attributes args
      @document.send :make_text_field, start, width, height,
                     **args.except(:width, :height)
      @x += width
    end

    def check_box_field(**args)
      start, width, height = field_attributes args
      @document.send :make_check_box_field, start, width, height,
                     **args.except(:width, :height)
      @x += width
    end

    private

    def field_attributes(args)
      start = [@x, @y]
      width = @unit_width * (args[:width] || 1)
      height = args[:height] || @height
      [start, width, height]
    end
  end
end
