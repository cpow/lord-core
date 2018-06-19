require 'csv'

module Generators
  module Csv
    class LineItems
      def initialize(line_items)
        @line_items = line_items
      end

      def generate
        CSV.generate({}) do |csv|
          csv << LineItem.column_names + ['amount']
          @line_items.each do |line_item|
            csv << line_item.attributes.values + [line_item.itemable.amount]
          end
        end
      end
    end
  end
end
