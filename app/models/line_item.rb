# == Schema Information
#
# Table name: line_items
#
#  id            :bigint(8)        not null, primary key
#  itemable_type :string
#  itemable_id   :bigint(8)
#  company_id    :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

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
      created_on: created_at.strftime('%Y-%m-%d'),
      company_id: company.id
    }
  end
end
