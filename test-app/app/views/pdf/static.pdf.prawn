prawn_document do |pdf|
  pdf.text 'Text boxes - base case and size modifications',
    align: :center, size: 14
  unit_width = pdf.bounds.width / 5
  y = pdf.cursor
  pdf.bounding_box [0, y], height: 15, width: unit_width do
    pdf.text_box 'This should look normal',
      size: 10, valign: :bottom, align: :center
  end
  pdf.bounding_box [unit_width, y], height: 20, width: unit_width * 2 do
    pdf.text_box 'This should be twice as long as the others',
      size: 10, valign: :bottom, align: :center
  end
  pdf.bounding_box [unit_width * 3, y], height: 20, width: unit_width do
    pdf.text_box 'This should have bigger text',
      size: 10, valign: :bottom, align: :center
  end
  pdf.bounding_box [unit_width * 4, y], height: 20, width: unit_width do
    pdf.text_box 'This should be 5 pixels less tall than the others',
      size: 10, valign: :bottom, align: :center
  end

  pdf.field_row height: 30, units: 5 do |row|
    row.text_field field: 'Favorite fruit', value: 'Bananas!'
    row.text_field field: 'Longer bananas?', value: 'Absolutely.',
      width: 2
    row.text_field field: 'Bigger bananas?', value: 'Yes!',
      options: { size: 14 }
    row.text_field field: 'Smaller bananas?', value: 'If you must',
      height: 25
  end

  pdf.move_down 70
  pdf.text 'Text boxes - conditional display options',
    align: :center, size: 14
  unit_width = pdf.bounds.width / 4
  y = pdf.cursor
  4.times do |i|
    pdf.bounding_box [unit_width * i, y], height: 15, width: unit_width do
      message = i.even? ? 'This should show a value' : 'This should not show a value'
      pdf.text_box message, size: 10, valign: :bottom, align: :center
    end
  end

  pdf.field_row height: 30, units: 4 do |row|
    row.text_field field: 'If true', value: 'True',
      options: { if: true }
    row.text_field field: 'If false', value: 'False',
      options: { if: false }
    row.text_field field: 'Unless false', value: 'True',
      options: { unless: false }
    row.text_field field: 'Unless true', value: 'False',
      options: { unless: true }
  end

  pdf.move_down 70
  pdf.text 'Check boxes',
    align: :center, size: 14
  unit_width = pdf.bounds.width / 5
  y = pdf.cursor
  messages = [
    'This should have none checked',
    'This should have all checked',
    'This should have 2 and 4 checked',
    'This should have 4 options shown, 3 per column (default)',
    'This should have 4 options shown, 2 per column'
  ]
  messages.each.with_index do |message, i|
    pdf.bounding_box [unit_width * i, y], height: 25, width: unit_width do
      pdf.text_box message, size: 10, valign: :bottom, align: :center
    end
  end

  pdf.field_row height: 50, units: 5 do |row|
    numbers = [2, 3, 4]
    row.check_box_field field: 'Check the negatives', options: numbers,
      checked: numbers.map(&:negative?)
    row.check_box_field field: 'Check the positives', options: numbers,
      checked: numbers.map(&:positive?)
    row.check_box_field field: 'Check the evens', options: numbers,
      checked: numbers.map(&:even?)

    numbers << 5

    row.check_box_field field: 'Check the evens', options: numbers,
      checked: numbers.map(&:even?)
    row.check_box_field field: 'Check the evens', options: numbers,
      checked: numbers.map(&:even?), per_column: 2
  end

  pdf.move_down 70
  pdf.text 'Splitting rows',
    align: :center, size: 14
  pdf.move_down 10
  pdf.text 'This should look as expected', size: 10, align: :center

  pdf.field_row height: 50, units: 2 do |row|
    row.text_field field: 'Full height', value: 'Yep',
      options: { valign: :center }
    row.text_field field: 'Half height, top', value: 'Hope so',
      height: 25, options: { valign: :center }
    row.at_height 25, unit: 1 do
      row.text_field field: 'Half height, bottom', value: 'Aww yeah',
        height: 25, options: { valign: :center }
    end
  end

end
