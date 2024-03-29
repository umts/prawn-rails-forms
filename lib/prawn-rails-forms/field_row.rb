# frozen_string_literal: true

module PrawnRailsForms
  class FieldRow
    attr_accessor :document, :height, :units, :x, :y, :unit_width

    # 'x' and 'y' are easily understood in this context
    # rubocop:disable Naming/MethodParameterName
    def initialize(document, height, units, x, y, unit_width)
      @document = document
      @height = height
      @units = units
      @x = x
      @y = y
      @unit_width = unit_width
    end
    # rubocop:enable Naming/MethodParameterName

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
