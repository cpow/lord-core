# == Schema Information
#
# Table name: properties
#
#  id             :integer          not null, primary key
#  address_city   :string           not null
#  address_line1  :string           not null
#  address_state  :string           not null
#  address_postal :string           not null
#  name           :string           not null
#  description    :text             not null
#  company_id     :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Property, type: :model do
end
