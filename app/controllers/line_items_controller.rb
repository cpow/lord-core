class LineItemsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :company

  def index
    @line_items = LineItem.search(
      '*',
      where: filter_params(filter_keys, initial_object),
      order: {
        created_at: {
          order: 'desc'
        }
      }
    )

    @chart_items = @line_items.group_by(&:itemable_type).map do |type, items|
      [type, items.map{|i| i.itemable.human_amount}.sum]
    end
  end

  private

  def company
    @company ||= current_property_manager.company
  end

  def filter_keys
    %i[itemable_type]
  end

  def initial_object
    { company_id: company.id }
  end
end
