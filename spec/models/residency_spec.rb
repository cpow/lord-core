# == Schema Information
#
# Table name: residencies
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer
#  property_id :integer
#  company_id  :integer
#  unit_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  active      :boolean
#

require 'rails_helper'

RSpec.describe Residency, type: :model do
end
