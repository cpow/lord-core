# == Schema Information
#
# Table name: issues
#
#  id            :integer          not null, primary key
#  property_id   :integer
#  unit_id       :integer
#  reporter_type :string
#  reporter_id   :integer
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
