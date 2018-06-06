class LineItem < ApplicationRecord
  belongs_to :itemable, polymorphic: true
  belongs_to :company

  searchkick _all: false

  def search_data
    {
      itemable_type: itemable_type,
      itemable_id: itemable_id,
      itemable_amount: itemable.amount,
      created_at: created_at,
      company_id: company.id
    }
  end
end
