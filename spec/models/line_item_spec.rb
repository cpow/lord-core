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

require 'rails_helper'

RSpec.describe LineItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
