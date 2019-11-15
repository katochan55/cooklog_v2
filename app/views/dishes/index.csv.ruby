require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(name description created_at)
  csv << csv_column_names
  @dishes.pluck(*csv_column_names).each do |dish|
    csv << dish
  end
end
