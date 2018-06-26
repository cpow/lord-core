# == Schema Information
#
# Table name: issues
#
#  id            :bigint(8)        not null, primary key
#  property_id   :bigint(8)
#  unit_id       :bigint(8)
#  reporter_type :string
#  reporter_id   :bigint(8)
#  description   :text
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :string           default("created")
#

require 'rails_helper'

RSpec.describe Issue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
